import 'package:flutter/material.dart';
import 'package:uptodo/features/home/calendar_screen/presentation/widget/calendar_tabs_widget.dart';
import 'package:uptodo/features/home/calendar_screen/presentation/widget/calendar_widgets/calendar_widget.dart';

/// CalendarPage
class CalendarPage extends StatefulWidget {
  /// CalendarPage constructor
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: const [
        CalendarWidget(),
        CalendarTabsWidget(),
      ],
    );
  }
}
