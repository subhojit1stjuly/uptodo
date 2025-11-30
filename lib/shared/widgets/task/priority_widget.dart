import 'package:flutter/material.dart';
import 'package:uptodo/core/constants/assets.gen.dart';

/// PriorityWidget widget
class PriorityWidget extends StatelessWidget {
  /// Constructor for PriorityWidget
  const PriorityWidget({required this.priority, super.key});

  /// task priority
  final String priority;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).shadowColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        spacing: 4,
        children: <Widget>[
          Assets.icons.flag.svg(
            height: 18,
            width: 18,
            colorFilter: ColorFilter.mode(
              Theme.of(context).iconTheme.color!,
              BlendMode.srcIn,
            ),
          ),
          Text(
            priority,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).iconTheme.color,
                ),
          ),
        ],
      ),
    );
  }
}
