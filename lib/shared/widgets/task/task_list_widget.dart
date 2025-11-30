import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uptodo/core/constants/assets.gen.dart';
import 'package:uptodo/core/localizations/app_localizations.dart';
import 'package:uptodo/features/home/presentation/index_screen/bloc/index_bloc.dart';
import 'package:uptodo/features/home/presentation/index_screen/bloc/state/index_state.dart';
import 'package:uptodo/shared/model/shred_enums.dart';
import 'package:uptodo/shared/widgets/task/no_task_found_widget.dart';
import 'package:uptodo/shared/widgets/task/task_widget.dart';

/// IndexTaskListWidget
class TaskListWidget extends StatelessWidget {
  /// IndexTaskListWidget constructor
  const TaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<IndexBloc>();
    return BlocBuilder<IndexBloc, IndexState>(
      bloc: bloc,
      buildWhen: (prev, cur) => cur is TasksLoadedState,
      builder: (context, state) {
        return state.maybeWhen(
          tasksLoaded: (
            pendingTasks,
            completedTasks,
            currentDayFilter,
            currentStatusFilter,
          ) {
            if ((currentStatusFilter == TaskStatus.completed &&
                    completedTasks.isEmpty) ||
                (currentStatusFilter == TaskStatus.pending &&
                    pendingTasks.isEmpty)) {
              return NoTaskFoundWidget(
                message: (currentDayFilter == DayFilterType.today &&
                        completedTasks.isNotEmpty)
                    ? AppLocalizations.of(context)!.done_for_the_day
                    : currentDayFilter != DayFilterType.today
                        ? AppLocalizations.of(context)!.no_task_was_planned
                        : AppLocalizations.of(context)!
                            .what_do_you_want_to_do_today,
                subtitle: AppLocalizations.of(context)!.tap_to_add_tasks,
                iconToShow: Assets.icons.noPlansToday.svg(
                  height: 227,
                  width: 227,
                ),
              )
                  .animate(delay: const Duration(milliseconds: 50))
                  .fadeIn(duration: 300.ms)
                  .slideX(
                    begin: 0.2,
                    end: 0,
                    duration: 400.ms,
                    curve: Curves.easeOutQuad,
                  );
            }
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: currentStatusFilter == TaskStatus.completed
                  ? completedTasks.length
                  : pendingTasks.length,
              itemBuilder: (context, index) {
                return TaskWidget(
                  taskModel: currentStatusFilter == TaskStatus.completed
                      ? completedTasks[index]
                      : pendingTasks[index],
                  dayFilterType: currentDayFilter,
                )
                    .animate(delay: Duration(milliseconds: 50 * index))
                    .fadeIn(duration: 300.ms)
                    .slideX(
                      begin: 0.2,
                      end: 0,
                      duration: 400.ms,
                      curve: Curves.easeIn,
                    );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 8,
                );
              },
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
