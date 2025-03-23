import 'package:injectable/injectable.dart';
import 'package:uptodo/features/task_details/data/model/task_analytics_data/task_analytics_data.dart';
import 'package:uptodo/features/task_details/data/model/task_event_types.dart';
import 'package:uptodo/features/task_details/data/model/task_model/task_model.dart';

/// TaskDetailsRepository
@factoryMethod
abstract class TaskDetailsRepository {
  /// Watch all tasks with real-time updates
  /// Returns a stream that emits a new list whenever tasks are added, updated, or deleted
  /// [page] The page number for pagination
  /// [pageSize] The number of items per page
  Future<List<TaskModel>> getAllTasksByDate({
    required DateTime date,
    int page = 0,
    int pageSize = 20,
  });

  /// Watch all tasks with real-time updates
  /// Returns a stream that emits a new task whenever
  /// tasks are added, updated, or deleted
  Stream<TaskTableEvents> watchTask();

  /// Analyze task completion patterns and productivity metrics
  /// [startDate] The start date for analysis period
  /// [endDate] The end date for analysis period
  /// [groupBy] How to group the data (daily, weekly, monthly)
  /// Returns analytics data grouped by the specified period
  Future<Map<String, TaskAnalyticsData>> analyzeTaskProductivity(
    DateTime startDate,
    DateTime endDate, {
    AnalyticsPeriod groupBy = AnalyticsPeriod.daily,
  });

  /// Load task summary
  Future<bool> loadTaskSummary(DateTime date);
}
