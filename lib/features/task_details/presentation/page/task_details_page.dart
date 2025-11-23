import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/core/constants/assets.gen.dart';
import 'package:uptodo/core/di/injector.dart';
import 'package:uptodo/core/localizations/app_localizations.dart';
import 'package:uptodo/core/utils/common_extainsions.dart';
import 'package:uptodo/features/category/presentation/widget/categor_widget.dart';
import 'package:uptodo/features/task_details/presentation/bloc/event/task_event.dart';
import 'package:uptodo/features/task_details/presentation/bloc/state/task_state.dart';
import 'package:uptodo/features/task_details/presentation/bloc/task_bloc.dart';
import 'package:uptodo/shared/widgets/pickers/date_time_picker.dart';
import 'package:uptodo/shared/widgets/pickers/property_picker.dart';
import 'package:uptodo/shared/widgets/task/priority_widget.dart';

/// A Screen to display task details
class TaskDetailsPage extends StatelessWidget {
  /// TaskDetailsPage constructor
  const TaskDetailsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaskBloc>();
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
      body: BlocListener<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state.editingStatus == TaskEditingStatus.deleted ||
              state.editingStatus == TaskEditingStatus.updated) {
            getIt<GoRouter>().pop();
          }
          if (state.editingStatus == TaskEditingStatus.errored) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage ?? '',
                ),
              ),
            );
          }
        },
        child: SingleChildScrollView(
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
                  title: BlocBuilder<TaskBloc, TaskState>(
                    buildWhen: (previous, current) =>
                        previous.taskModel?.title != current.taskModel?.title,
                    builder: (context, state) {
                      return Text(
                        state.taskModel!.title,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      );
                    },
                  ),
                  subtitle: BlocBuilder<TaskBloc, TaskState>(
                    buildWhen: (previous, current) =>
                        previous.taskModel?.description !=
                        current.taskModel?.description,
                    builder: (context, state) {
                      return Text(
                        state.taskModel!.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                      );
                    },
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
                  caption: Text(
                    AppLocalizations.of(context)!.task_time,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  value: TextButton(
                    onPressed: () {
                      DateTimePicker.showTime(
                        context: context,
                        initialDate: DateTime.now(),
                      ).then((time) {
                        if (time != null) {
                          bloc.add(TaskEvent.updateTime(time));
                        }
                      });
                    },
                    child: _decorateItem(
                      context: context,
                      child: BlocBuilder<TaskBloc, TaskState>(
                        buildWhen: (previous, current) =>
                            previous.taskModel?.taskTime !=
                            current.taskModel?.taskTime,
                        builder: (context, state) {
                          return Text(
                            state.taskModel!.taskTime
                                .convertTimeOfDayToString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          );
                        },
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
                  caption: Text(
                    AppLocalizations.of(context)!.task_date,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  value: TextButton(
                    onPressed: () {
                      // Open date picker
                      DateTimePicker.showDates(
                        context: context,
                      ).then((date) {
                        if (date != null) {
                          bloc.add(TaskEvent.updateDate(date));
                        }
                      });
                    },
                    child: _decorateItem(
                      context: context,
                      child: BlocBuilder<TaskBloc, TaskState>(
                        buildWhen: (previous, current) =>
                            previous.taskModel?.taskDate !=
                            current.taskModel?.taskDate,
                        builder: (context, state) {
                          return Text(
                            state.taskModel!.taskDate.toFormattedDate(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          );
                        },
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
                  caption: Text(
                    AppLocalizations.of(context)!.task_category,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  value: BlocBuilder<TaskBloc, TaskState>(
                    buildWhen: (previous, current) =>
                        previous.taskModel?.category !=
                        current.taskModel?.category,
                    builder: (context, state) {
                      return TextButton(
                        onPressed: () {
                          PropertyPicker.pickCategory(
                            context: context,
                            bloc: bloc,
                          );
                        },
                        child: CategoryWidget(
                          doesMarqueeRequired: false,
                          taskCategory: state.taskModel!.category,
                        ),
                      );
                    },
                  ),
                ),

                /// task priority
                _buildTaskRow(
                  icon: Assets.icons.flag.svg(
                    width: 24,
                    height: 24,
                  ),
                  caption: Text(
                    AppLocalizations.of(context)!.task_priority,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  value: BlocBuilder<TaskBloc, TaskState>(
                    buildWhen: (previous, current) =>
                        previous.taskModel?.priorityId !=
                        current.taskModel?.priorityId,
                    builder: (context, state) {
                      return TextButton(
                        onPressed: () {
                          PropertyPicker.pickPriority(
                            context: context,
                            bloc: bloc,
                          );
                        },
                        child: PriorityWidget(
                          priority: state.taskModel!.priorityId.toString(),
                        ),
                      );
                    },
                  ),
                ),

                /// sub task link
                // TODO(Subhojit): redesing this section later
                /*_buildTaskRow(
                icon: Assets.icons.hierarchy.svg(
                  width: 24,
                  height: 24,
                ),
                caption: Text(
                  AppLocalizations.of(context)!.sub_task,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: TextButton(
                  onPressed: () {},
                  child: _decorateItem(
                    context: context,
                    child: Text(
                      taskModel.subTaskId != null
                          ? taskModel.childTask!.title
                          : AppLocalizations.of(context)!.add_task,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),*/

                /// delete
                TextButton(
                  onPressed: () {
                    bloc.add(const TaskEvent.delete());
                  },
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
      ),
    );
  }

  Widget _buildTaskRow({
    required Widget icon,
    required Widget caption,
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
              caption,
            ],
          ),
          value,
        ],
      ),
    );
  }

  Widget _decorateItem({required Widget child, required BuildContext context}) {
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
