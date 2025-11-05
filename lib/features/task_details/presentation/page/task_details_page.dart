import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/core/constants/assets.gen.dart';
import 'package:uptodo/core/di/injector.dart';
import 'package:uptodo/core/localizations/app_localizations.dart';
import 'package:uptodo/core/utils/common_extainsions.dart';
import 'package:uptodo/features/category/presentation/widget/categor_widget.dart';
import 'package:uptodo/features/task_details/data/model/task_model/task_model.dart';
import 'package:uptodo/shared/widgets/task/priority_widget.dart';

/// A Screen to display task details
class TaskDetailsPage extends StatelessWidget {
  /// TaskDetailsPage constructor
  const TaskDetailsPage({
    required this.taskModel,
    required this.timeOfTheWeek,
    super.key,
  });

  /// Task Model
  final TaskModel taskModel;

  /// timeOfTheWeek
  final String timeOfTheWeek;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          child: const Icon(Icons.close),
          onPressed: () => getIt<GoRouter>().pop(),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Assets.icons.repeat.svg(
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              ListTile(
                leading: Radio(
                  value: true,
                  groupValue: null,
                  onChanged: (value) {
                    // Handle radio button selection
                  },
                  activeColor: Colors.white,
                ),
                title: Text(
                  taskModel.title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                subtitle: Text(
                  taskModel.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
                trailing: TextButton(
                  onPressed: () {},
                  child: Assets.icons.edit.svg(
                    width: 24,
                    height: 24,
                  ),
                ),
              ),

              /// task time
              _buildTaskRow(
                icon: Assets.icons.clock.svg(
                  width: 24,
                  height: 24,
                ),
                text: Text(
                  AppLocalizations.of(context)!.task_time,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: TextButton(
                  onPressed: () {},
                  child: decorateItem(
                    context: context,
                    child: Text(
                      '$timeOfTheWeek At '
                          '${taskModel.taskTime.convertTimeOfDayToString()}',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium,
                    ),
                  ),
                ),
              ),

              /// task date
              _buildTaskRow(
                icon: Assets.icons.calendar.svg(
                  width: 24,
                  height: 24,
                ),
                text: Text(
                  AppLocalizations.of(context)!.task_date,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium,
                ),
                value: TextButton(
                  onPressed: () {},
                  child: decorateItem(
                    context: context,
                    child: Text(
                      '$timeOfTheWeek At '
                          '${taskModel.taskTime.convertTimeOfDayToString()}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),

              /// task category
              _buildTaskRow(
                icon: Assets.icons.tag.svg(
                  width: 24,
                  height: 24,
                ),
                text: Text(
                  AppLocalizations.of(context)!.task_category,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: TextButton(
                  onPressed: () {},
                  child: CategoryWidget(
                    doesMarqueeRequired: false,
                    taskCategory: taskModel.category,
                  ),
                ),
              ),

              /// task priority
              _buildTaskRow(
                icon: Assets.icons.flag.svg(
                  width: 24,
                  height: 24,
                ),
                text: Text(
                  AppLocalizations.of(context)!.task_priority,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: TextButton(
                  onPressed: () {},
                  child: PriorityWidget(
                    priority: taskModel.priorityId.toString(),
                  ),
                ),
              ),

              /// sub task link
              _buildTaskRow(
                icon: Assets.icons.hierarchy.svg(
                  width: 24,
                  height: 24,
                ),
                text: Text(
                  AppLocalizations.of(context)!.sub_task,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: TextButton(
                  onPressed: () {},
                  child: decorateItem(
                    context: context,
                    child: Text(
                      taskModel.subTaskId != null
                          ? taskModel.childTask!.title
                          : AppLocalizations.of(context)!.add_task,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),

              /// delete
              TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 4,
                  children: [
                    Assets.icons.trash.svg(
                      width: 24,
                      height: 24,
                    ),
                    Text(
                      AppLocalizations.of(context)!.delete_task,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.red,
                          ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskRow({
    required Widget icon,
    required Widget text,
    required Widget value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 4,
            children: [
              icon,
              text,
            ],
          ),
          value,
        ],
      ),
    );
  }

  Widget decorateItem({required Widget child, required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).shadowColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: child,
    );
  }
}
