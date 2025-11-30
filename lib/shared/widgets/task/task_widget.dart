import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/core/di/injector.dart';
import 'package:uptodo/core/routing/route_constants.dart';
import 'package:uptodo/core/utils/common_extainsions.dart';
import 'package:uptodo/features/category/presentation/widget/categor_widget.dart';
import 'package:uptodo/features/home/presentation/index_screen/bloc/event/home_event.dart';
import 'package:uptodo/features/home/presentation/index_screen/bloc/home_bloc.dart';
import 'package:uptodo/features/task_details/data/model/task_model/task_model.dart';
import 'package:uptodo/shared/model/shred_enums.dart';
import 'package:uptodo/shared/widgets/task/priority_widget.dart';

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
    return ListTile(
      leading: Checkbox(
        value: taskModel.status == TaskStatus.completed,
        onChanged: taskModel.status == TaskStatus.completed
            ? null
            : (value) {
                context.read<HomeBloc>().add(
                      HomeEvent.markTaskAsCompleted(
                        taskModel.copyWith(status: TaskStatus.completed),
                      ),
                    );
              },
      ),
      onTap: () {
        getIt<GoRouter>().pushNamed(
          RouteConstants.taskDetails,
          extra: (taskModel, dayFilterType.value(context)),
        ).then((_) => onEditCompleted());
      },
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(
            taskModel.title,
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
            '${dayFilterType.value(context)} At ${taskModel.taskTime.convertTimeOfDayToString()}',
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
                  taskCategory: taskModel.category,
                ),
                PriorityWidget(
                  priority: taskModel.priorityId.toString(),
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
