import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uptodo/core/localizations/app_localizations.dart';
import 'package:uptodo/features/home/calendar_screen/presentation/widget/calendar_list_widget.dart';

/// CalendarTabsWidget
class CalendarTabsWidget extends StatefulWidget {
  /// CalendarTabsWidget constructor
  const CalendarTabsWidget({super.key});

  @override
  State<CalendarTabsWidget> createState() => _CalendarTabsWidgetState();
}

class _CalendarTabsWidgetState extends State<CalendarTabsWidget> {
  int _selectedIndex = 0;

  Map<int, Widget> _getTabs(BuildContext context) => <int, Widget>{
        0: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            AppLocalizations.of(context)!.today,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        1: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            AppLocalizations.of(context)!.completed,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CupertinoSegmentedControl<int>(
            children: _getTabs(context),
            onValueChanged: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            groupValue: _selectedIndex,
            selectedColor: Theme.of(context).primaryColorLight,
            unselectedColor: Theme.of(context).scaffoldBackgroundColor,
            borderColor: Theme.of(context).primaryColorLight,
            pressedColor: Theme.of(context).primaryColorLight.withOpacity(0.2),
          ),
          // Content area that changes based on selected tab
          _buildTabContent(),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    return const CalendarListWidget();
  }
}
