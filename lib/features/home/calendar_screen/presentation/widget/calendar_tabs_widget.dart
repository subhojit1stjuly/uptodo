import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uptodo/core/localizations/app_localizations.dart';

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
      child: CupertinoSegmentedControl<int>(
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
        pressedColor: Theme.of(context).primaryColorLight.withValues(
              alpha: 0.2,
            ),
      ),
    );
  }
}
