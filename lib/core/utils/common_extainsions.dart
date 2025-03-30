import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// some common string extensions
extension StringExtainsion on String {
  /// Convert a string to a Color
  IconData getIconFromCodePoint() {
    // Parse the codePoint string to an integer
    final codePoint = int.parse(this);

    // Create an IconData with the codePoint and material icons font family
    return IconData(
      codePoint,
      fontFamily: 'MaterialIcons',
    );
  }
}

/// some common date time extensions
extension TimeOfDayExtainsion on TimeOfDay {
  /// convert a timeOfDay to proper string
  String convertTimeOfDayToString() {
    final now = DateTime.now();
    final dt = DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    return DateFormat.jm().format(dt);
  }
}
