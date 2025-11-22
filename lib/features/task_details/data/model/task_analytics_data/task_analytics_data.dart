import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_analytics_data.freezed.dart';
part 'task_analytics_data.g.dart';

/// Data model for task analytics
@freezed
abstract class TaskAnalyticsData with _$TaskAnalyticsData {
  /// factory constructor for TaskAnalyticsData
  const factory TaskAnalyticsData({
    required int totalTasks,
    required int completedTasks,
    required int pendingTasks,
    required int overdueTasks,
    required double completionRate,
    required double tasksPerDay,
    int? mostActiveCategory,
    int? mostUsedPriority,
  }) = _TaskAnalyticsData;

  /// fromJson
  factory TaskAnalyticsData.fromJson(Map<String, dynamic> json) =>
      _$TaskAnalyticsDataFromJson(json);
}

/// Analytics grouping period
enum AnalyticsPeriod {
  /// Group by day
  daily(0),

  /// Group by week
  weekly(1),

  /// Group by month
  monthly(2),

  /// Group by year
  yearly(3);

  const AnalyticsPeriod(this.id);

  /// Unique identifier for this period
  final int id;
}
