import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
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
    final allTask = await _databaseModule.getAllTasksByDateAndPage(
      date: date,
      page: page,
      pageSize: pageSize,
    );
    return allTask
        .map(
          (task) => TaskModel(
            taskId: task.taskId.toString(),
            title: task.title,
            description: task.description,
            subTaskId: task.subTaskId,
            priorityId: task.priorityId,
            taskTime: TimeOfDay.fromDateTime(task.taskTime),
            categoryId: task.categoryId,
            status: task.status,
            taskDate: DateTime(
              task.taskTime.year,
              task.taskTime.month,
              task.taskTime.day,
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
