import 'package:flutter/material.dart';
import 'package:uptodo/core/constants/assets.gen.dart';
import 'package:uptodo/shared/widgets/task/no_task_found_widget.dart';

/// CalendarListWidget
class CalendarListWidget extends StatefulWidget {
  /// CalendarListWidget constructor
  const CalendarListWidget({super.key});

  @override
  State<CalendarListWidget> createState() => _CalendarListWidgetState();
}

class _CalendarListWidgetState extends State<CalendarListWidget> {
  @override
  Widget build(BuildContext context) {
    return NoTaskFoundWidget(
      message: 'all done for today',
      subtitle: '',
      iconToShow: Assets.icons.checkList.svg(
        height: 227,
        width: 227,
      ),
    );
  }
}
