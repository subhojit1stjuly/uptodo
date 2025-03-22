import 'dart:async';

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/core/storage/database/config/app_database.dart';
import 'package:uptodo/features/task_details/domain/entities/tasks_entity.dart';

part 'tasks_database_module.g.dart';

/// TasksDatabaseModule
@injectable
@DriftAccessor(tables: [TasksEntity])
class TasksDatabaseModule extends DatabaseAccessor<AppDatabase>
    with _$TasksDatabaseModuleMixin {
  /// TasksDatabaseModule constructor
  TasksDatabaseModule(super.attachedDatabase);

  /// You'll need a StreamController for deleted tasks
  final _deletedTasksController =
      StreamController<TasksEntityData?>.broadcast();

  /// Stream of deleted tasks
  Stream<TasksEntityData?> get deletedTasksStream =>
      _deletedTasksController.stream;

  /// Watch for the most recent task operation (create, update, delete)
  /// Returns a stream that emits the affected task whenever there's a change
  Stream<TasksEntityData?> watchTaskChanges() {
    /// Create a broadcast stream controller to emit task changes
    final controller = StreamController<TasksEntityData?>.broadcast();

    /// Variable to store the last task ID for comparison
    int? lastTaskId;
    TasksEntityData? lastTask;

    /// Subscribe to the underlying database changes
    (select(tasksEntity)
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.taskTime, mode: OrderingMode.desc),
          ]))
        .watch()
        .listen((tasks) {
      /// If there are no tasks or the list is empty
      if (tasks.isEmpty) {
        /// If we had a last task, it means it was deleted
        if (lastTask != null) {
          controller.add(lastTask); // Emit the deleted task
          lastTask = null;
          lastTaskId = null;
        }
        return;
      }

      /// Check if the first task is new or updated
      if (lastTaskId == null || tasks[0].taskId != lastTaskId) {
        lastTaskId = tasks[0].taskId;
        lastTask = tasks[0];
        controller.add(tasks[0]);

        /// Emit the new/updated task
      }
    });

    /// Listen for delete operations specifically
    deletedTasksStream.listen((deletedTask) {
      if (deletedTask != null) {
        controller.add(deletedTask);
        lastTask = deletedTask;
      }
    });

    return controller.stream;
  }

  /// Override the delete method to track the deleted task
  Future<int> deleteTask(int id) async {
    /// Get the task before deleting it
    final taskToDelete = await getTaskById(id).catchError((_) {
      throw Exception('Task not found');
    });

    /// Perform the deletion
    final result =
        await (delete(tasksEntity)..where((t) => t.taskId.equals(id))).go();

    /// If deletion was successful and we have the task, emit it
    if (result > 0) {
      _deletedTasksController.add(taskToDelete);
    }

    return result;
  }

  /// Get all tasks by date
  Future<List<TasksEntityData>> getAllTasksByDateAndPage({
    required DateTime date,
    int page = 0,
    int pageSize = 20,
  }) async {
    return (select(tasksEntity)
          ..where((t) => t.taskTime.year.equals(date.year))
          ..where((t) => t.taskTime.month.equals(date.month))
          ..where((t) => t.taskTime.day.equals(date.day))
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.taskTime, mode: OrderingMode.desc),
          ])
          ..limit(pageSize, offset: page * pageSize))
        .get();
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
}
