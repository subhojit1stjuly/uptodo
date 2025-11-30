import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/core/di/injector.dart';
import 'package:uptodo/core/routing/route_constants.dart';
import 'package:uptodo/core/utils/common_extainsions.dart';
import 'package:uptodo/features/task_details/data/model/task_model/task_model.dart';
import 'package:uptodo/features/task_details/presentation/widget/task_card.dart';
import 'package:uptodo/shared/model/shred_enums.dart';

/// TaskCard
class TaskWidget extends StatelessWidget {
  /// TaskCard constructor
  const TaskWidget({
    required this.onEditCompleted,
    required this.taskModel,
    required this.dayFilterType,
    super.key,
  });

  /// TaskModel
  final TaskModel taskModel;

  /// DayFilterType
  final DayFilterType dayFilterType;

  /// onEditCompleted callback
  final VoidCallback onEditCompleted;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        getIt<GoRouter>().pushNamed(
          RouteConstants.taskDetails,
          extra: (taskModel, dayFilterType.value(context)),
        ).then((_) => onEditCompleted());
      },
      child: TaskListTileCard(
        taskTitle: taskModel.title,
        taskTime: taskModel.taskTime.convertTimeOfDayToString(),
        taskCategory: taskModel.category,
        priority: taskModel.priorityId,
        timeOfTheWeek: dayFilterType.value(context),
      ),
    );
  }
}
