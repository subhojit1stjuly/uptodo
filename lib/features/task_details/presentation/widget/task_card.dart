import 'package:flutter/material.dart';
import 'package:uptodo/core/constants/assets.gen.dart';
import 'package:uptodo/features/category/data/model/category_model.dart';
import 'package:uptodo/shared/widgets/texts/marquee_text_widget.dart';

/// TaskListTileCard widget
class TaskListTileCard extends StatelessWidget {
  /// Constructor for TaskListTileCard
  const TaskListTileCard({
    required this.taskTitle,
    required this.taskTime,
    required this.taskCategory,
    required this.priority,
    required this.timeOfTheWeek,
    super.key,
  });

  /// task title
  final String taskTitle;

  /// task time
  final String taskTime;

  /// timeOfTheWeek (Today, Tomorrow, etc.)
  final String timeOfTheWeek;

  /// task category
  final CategoryItem? taskCategory;

  /// task priority
  final int priority;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Radio(
        value: true,
        groupValue: null,
        onChanged: (value) {
          // Handle radio button selection
        },
        activeColor: Colors.white,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(
            taskTitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox.shrink(),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            '$timeOfTheWeek At $taskTime',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 8,
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color:
                        taskCategory?.color ?? Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    spacing: 4,
                    children: <Widget>[
                      Icon(
                        taskCategory?.icon ?? Icons.category,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(
                        width: 40,
                        child: MarqueeTextAnimate(
                          text: taskCategory?.name ?? '',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                      ),
                      Text(
                        priority.toString(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
