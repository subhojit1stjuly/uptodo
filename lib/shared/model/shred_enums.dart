/// This file contains all the enums used in the app
/// FilterType
enum DayFilterType {
  /// today
  today(0),

  /// tomorrow
  tomorrow(1),

  /// yesterday
  yesterday(2);

  const DayFilterType(this.id);

  /// id
  final int id;
}

/// task Status
enum TaskStatus {
  /// pending
  pending(0),

  /// in progress
  inProgress(1),

  /// done
  completed(2),

  /// overdue
  overdue(3);

  const TaskStatus(this.id);

  /// id
  final int id;
}
