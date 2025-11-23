import 'dart:async';

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/core/storage/database/config/app_database.dart';
import 'package:uptodo/features/task_details/data/model/task_event_types.dart';
import 'package:uptodo/features/task_details/data/model/task_with_category.dart';
import 'package:uptodo/features/task_details/domain/entities/tasks_entity.dart';
import 'package:uptodo/shared/model/shred_enums.dart';

part 'tasks_database_module.g.dart';

/// TasksDatabaseModule
@injectable
@DriftAccessor(tables: [TasksEntity])
class TasksDatabaseModule extends DatabaseAccessor<AppDatabase>
    with _$TasksDatabaseModuleMixin {
  /// TasksDatabaseModule constructor
  TasksDatabaseModule(super.attachedDatabase);

  /// Watch for the most recent task operation (create, update, delete)
  /// Returns a stream that emits the affected task whenever there's a change
  Stream<TaskTableEvents> watchTaskChanges() {
    /// Create a broadcast stream controller to emit task changes
    final controller = StreamController<TaskTableEvents>.broadcast();

    /// Set up a join query between tasks and categories
    final query = select(tasksEntity).join([
      innerJoin(
        categoryEntity,
        categoryEntity.id.equalsExp(tasksEntity.categoryId),
      ),
    ])
      ..orderBy([
        OrderingTerm(expression: tasksEntity.taskTime, mode: OrderingMode.desc),
      ]);

    /// Track the last known tasks to detect changes
    var previousTasksWithCategories = <TaskWithCategory>[];

    /// Subscribe to the underlying database changes
    query.watch().listen((rows) {
      // Convert joined rows to TaskWithCategory objects
      final currentTasksWithCategories = rows.map((row) {
        return TaskWithCategory(
          task: row.readTable(tasksEntity),
          category: row.readTable(categoryEntity),
        );
      }).toList();

      if (previousTasksWithCategories.isEmpty &&
          currentTasksWithCategories.isNotEmpty) {
        // First load or all tasks were previously deleted
        for (final taskWithCategory in currentTasksWithCategories) {
          controller.add(
              TaskTableEvents(taskWithCategory, TaskTableEventType.created));
        }
      } else {
        // Find created tasks (in current but not in previous)
        for (final current in currentTasksWithCategories) {
          if (!previousTasksWithCategories
              .any((prev) => prev.task.taskId == current.task.taskId)) {
            controller
                .add(TaskTableEvents(current, TaskTableEventType.created));
          }
        }

        // Find updated tasks (in both, but with changes)
        for (final current in currentTasksWithCategories) {
          final previous = previousTasksWithCategories.firstWhere(
            (prev) => prev.task.taskId == current.task.taskId,
            orElse: () => TaskWithCategory(
              task: TasksEntityData(
                taskId: -1,
                title: '',
                description: '',
                priorityId: 0,
                taskTime: DateTime.now(),
                categoryId: 0,
                status: TaskStatus.pending,
              ),
              category: const CategoryEntityData(
                id: -1,
                name: '',
                icon: '',
                color: '',
              ),
            ),
          );

          if (previous.task.taskId != -1 &&
              !_tasksEqual(previous.task, current.task)) {
            controller
                .add(TaskTableEvents(current, TaskTableEventType.updated));
          }
        }

        // Find deleted tasks (in previous but not in current)
        for (final previous in previousTasksWithCategories) {
          if (!currentTasksWithCategories
              .any((current) => current.task.taskId == previous.task.taskId)) {
            controller
                .add(TaskTableEvents(previous, TaskTableEventType.deleted));
          }
        }
      }

      previousTasksWithCategories = List.from(currentTasksWithCategories);
    });

    return controller.stream;
  }

  /// Helper method to compare tasks
  bool _tasksEqual(TasksEntityData a, TasksEntityData b) {
    return a.taskId == b.taskId &&
        a.title == b.title &&
        a.description == b.description &&
        a.priorityId == b.priorityId &&
        a.taskTime == b.taskTime &&
        a.categoryId == b.categoryId &&
        a.status == b.status;
  }

  /// Override the delete method to track the deleted task
  Future<void> deleteTask(int id) async {
    await (delete(tasksEntity)..where((t) => t.taskId.equals(id))).go();
  }

  /// Get all tasks by date
  Future<List<TaskWithCategory>> getAllTasksByDateAndPage({
    required DateTime date,
    int page = 0,
    int pageSize = 20,
  }) async {
    /// we don't need to change this date to utc since, the database
    /// return the data in local format automatically
    /// Create a join query between tasks and categories
    final query = select(tasksEntity).join([
      innerJoin(
          categoryEntity, categoryEntity.id.equalsExp(tasksEntity.categoryId)),
    ])
      // Apply the date filter
      ..where(tasksEntity.taskTime.year.equals(date.year))
      ..where(tasksEntity.taskTime.month.equals(date.month))
      ..where(tasksEntity.taskTime.day.equals(date.day))
      // Apply ordering
      ..orderBy([
        OrderingTerm(expression: tasksEntity.taskTime, mode: OrderingMode.desc),
      ])
      // Apply pagination
      ..limit(pageSize, offset: page * pageSize);

    // Execute the query
    final rows = await query.get();

    // Map the results to your custom class
    return rows.map((row) {
      return TaskWithCategory(
        task: row.readTable(tasksEntity),
        category: row.readTable(categoryEntity),
      );
    }).toList();
  }

  /// Get task by id
  Future<TasksEntityData> getTaskById(int id) {
    return (select(tasksEntity)..where((t) => t.taskId.equals(id))).getSingle();
  }

  /// Insert task
  Future<int> insertTask(TasksEntityCompanion task) {
    return into(tasksEntity).insert(task);
  }

  /// Update task
  Future<bool> updateTask(TasksEntityCompanion task) {
    return update(tasksEntity).replace(task);
  }

  /// Checks if any tasks exist for a specific date and its adjacent days
  /// Returns a map with dates as keys and boolean values
  /// indicating task presence
  Future<Map<DateTime, bool>> hasTasksInThreeDayRange(DateTime date) async {
    final dbDate = date.toUtc();
    // Create normalized dates (time set to midnight)
    final yesterday = DateTime(dbDate.year, dbDate.month, dbDate.day - 1);
    final today = DateTime(dbDate.year, dbDate.month, dbDate.day);
    final tomorrow = DateTime(dbDate.year, dbDate.month, dbDate.day + 1);

    final result = <DateTime, bool>{
      yesterday: false,
      today: false,
      tomorrow: false,
    };

    for (final checkDate in [yesterday, today, tomorrow]) {
      // Get start and end of the day
      final startOfDay =
          DateTime(checkDate.year, checkDate.month, checkDate.day);
      final endOfDay = DateTime(
          checkDate.year, checkDate.month, checkDate.day, 23, 59, 59, 999);

      // Count tasks on this date
      final count = await (select(tasksEntity)
            ..where((t) => t.taskTime.isBetweenValues(startOfDay, endOfDay)))
          .get()
          .then((tasks) => tasks.length);

      result[checkDate] = count > 0;
    }

    return result;
  }
}
