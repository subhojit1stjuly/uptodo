import 'package:flutter/material.dart';
import 'package:uptodo/core/localizations/app_localizations.dart';

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

/// extension for the enum [DayFilterType]
extension DayFilterTypeExtension on DayFilterType {
  /// get the string value of the enum
  String value(BuildContext context) {
    switch (this) {
      case DayFilterType.today:
        return AppLocalizations.of(context)!.today;
      case DayFilterType.tomorrow:
        return AppLocalizations.of(context)!.tomorrow;
      case DayFilterType.yesterday:
        return AppLocalizations.of(context)!.yesterday;
    }
  }
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
