import 'package:flutter/material.dart';
import 'package:uptodo/features/task_details/data/model/task_model/task_model.dart';
import 'package:uptodo/features/task_details/presentation/widget/task_card.dart';
import 'package:uptodo/shared/model/shred_enums.dart';

/// TaskCard
class PendingTaskWidget extends StatelessWidget {
  /// TaskCard constructor
  const PendingTaskWidget({
    required this.taskModel,
    required this.dayFilterType,
    required this.formatter,
    super.key,
  });

  /// TaskModel
  final TaskModel taskModel;

  /// DayFilterType
  final DayFilterType dayFilterType;

  /// Optional formatter function to convert the value to a displayable string.
  ///
  /// If not provided, [toString] will be called on the value.
  final String Function(TimeOfDay? value) formatter;

  @override
  Widget build(BuildContext context) {
    return TaskListTileCard(
      taskTitle: taskModel.title,
      taskTime: formatter.call(taskModel.taskTime),
      taskCategory: taskModel.category,
      priority: taskModel.priorityId,
      timeOfTheWeek: dayFilterType.value(context),
    );
  }
}
