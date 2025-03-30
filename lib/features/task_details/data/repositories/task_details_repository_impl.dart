import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/core/utils/common_extainsions.dart';
import 'package:uptodo/features/category/data/model/category_model.dart';
import 'package:uptodo/features/home/domain/repositories/task_details_repository.dart';
import 'package:uptodo/features/task_details/data/database/tasks_database_module.dart';
import 'package:uptodo/features/task_details/data/model/task_analytics_data/task_analytics_data.dart';
import 'package:uptodo/features/task_details/data/model/task_event_types.dart';
import 'package:uptodo/features/task_details/data/model/task_model/task_model.dart';

/// TaskDetailsRepositoryImpl
@Injectable(as: TaskDetailsRepository)
class TaskDetailsRepositoryImpl implements TaskDetailsRepository {
  /// TaskDetailsRepositoryImpl constructor
  TaskDetailsRepositoryImpl(this._databaseModule);

  final TasksDatabaseModule _databaseModule;

  @override
  Future<List<TaskModel>> getAllTasksByDate({
    required DateTime date,
    int page = 0,
    int pageSize = 20,
  }) async {
    final taskWithCategories = await _databaseModule.getAllTasksByDateAndPage(
      date: date,
      page: page,
      pageSize: pageSize,
    );

    return taskWithCategories
        .map(
          (data) => TaskModel(
            taskId: data.task.taskId.toString(),
            title: data.task.title,
            description: data.task.description,
            subTaskId: data.task.subTaskId,
            priorityId: data.task.priorityId,
            taskTime: TimeOfDay.fromDateTime(data.task.taskTime),
            categoryId: data.task.categoryId,
            status: data.task.status,
            taskDate: DateTime(
              data.task.taskTime.year,
              data.task.taskTime.month,
              data.task.taskTime.day,
            ),
            category: CategoryItem(
              id: data.category.id,
              name: data.category.name,
              color: Color(int.parse(data.category.color)),
              icon: data.category.icon.getIconFromCodePoint(),
            ),
          ),
        )
        .toList();
  }

  @override
  Stream<TaskTableEvents> watchTask() {
    return _databaseModule.watchTaskChanges();
  }

  @override
  Future<Map<String, TaskAnalyticsData>> analyzeTaskProductivity(
    DateTime startDate,
    DateTime endDate, {
    AnalyticsPeriod groupBy = AnalyticsPeriod.daily,
  }) {
    // TODO: implement watchTask
    throw UnimplementedError();
  }

  /// this method will return if there is any task available
  /// for today,yesterday or tomorrow.
  /// will be false, if there is none
  /// will be true if there is any task available
  @override
  Future<bool> loadTaskSummary(DateTime date) async {
    final taskSummary = await _databaseModule.hasTasksInThreeDayRange(date);
    return taskSummary.values.any((hasTask) => hasTask);
  }
}
