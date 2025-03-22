import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// TimeOfDay JSON converter
class TimeOfDayConverter implements JsonConverter<TimeOfDay, int> {
  /// Constructor for TimeOfDayConverter
  const TimeOfDayConverter();

  @override
  TimeOfDay fromJson(int json) {
    return TimeOfDay(
      hour: json ~/ 60,
      minute: json % 60,
    );
  }

  @override
  int toJson(TimeOfDay object) {
    return object.hour * 60 + object.minute;
  }
}
