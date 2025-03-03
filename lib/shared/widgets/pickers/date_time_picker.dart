/*Can you help me create a date time Picker*/
import 'package:flutter/material.dart';

/// A reusable date time picker component that can be used anywhere in the app
class DateTimePicker {
  /// Shows date time picker and returns the selected DateTime
  static Future<DateTime?> show({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? now,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2101),
    ).then((date) => date ?? now);

    // If user cancels date selection
    if (pickedDate == now && initialDate == null) {
      return null;
    }
    // Verify context is still mounted before showing time picker
    if (!context.mounted) {
      return null;
    }
    // Show time picker
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate ?? now),
    ).then((time) => time ?? TimeOfDay.fromDateTime(now));

    // If user cancels time selection
    if (pickedTime == TimeOfDay.fromDateTime(now) && initialDate == null) {
      return null;
    }

    // Combine date and time
    return DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
  }
}
