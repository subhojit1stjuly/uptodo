import 'package:flutter/material.dart';
import 'package:uptodo/core/constants/assets.gen.dart';

/// this widget is used to show empty task list
class NoTaskFoundWidget extends StatelessWidget {
  /// constructor for EmptyTaskListWidget
  const NoTaskFoundWidget({
    required this.message,
    required this.subtitle,
    super.key,
  });

  /// message to show
  final String message;

  /// subtitle to show
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Assets.icons.checkList.svg(
          height: 227,
          width: 227,
        ),
        Text(
          message,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}
