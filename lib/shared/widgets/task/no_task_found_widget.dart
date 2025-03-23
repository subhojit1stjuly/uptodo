import 'package:flutter/material.dart';

/// this widget is used to show empty task list
class NoTaskFoundWidget extends StatelessWidget {
  /// constructor for EmptyTaskListWidget
  const NoTaskFoundWidget({
    required this.message,
    required this.subtitle,
    required this.iconToShow,
    super.key,
  });

  /// message to show
  final String message;

  /// subtitle to show
  final String subtitle;

  /// icon to show
  final Widget iconToShow;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        iconToShow,
        Text(
          textAlign: TextAlign.center,
          message,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        Text(
          textAlign: TextAlign.center,
          subtitle,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}
