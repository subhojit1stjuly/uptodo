import 'package:flutter/material.dart';
import 'package:uptodo/features/category/data/model/category_model.dart';
import 'package:uptodo/features/category/presentation/widget/categor_widget.dart';
import 'package:uptodo/shared/widgets/task/priority_widget.dart';

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
                CategoryWidget(
                  taskCategory: taskCategory,
                ),
                PriorityWidget(
                  priority: priority.toString(),
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
