import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uptodo/core/constants/assets.gen.dart';
import 'package:uptodo/core/localizations/app_localizations.dart';
import 'package:uptodo/features/home/presentation/index_screen/bloc/index_bloc.dart';
import 'package:uptodo/features/home/presentation/index_screen/bloc/state/index_state.dart';
import 'package:uptodo/features/task_details/presentation/widget/pending_task_widget.dart';
import 'package:uptodo/shared/model/shred_enums.dart';
import 'package:uptodo/shared/widgets/task/no_task_found_widget.dart';

/// IndexTaskListWidget
class PendingTaskListWidget extends StatefulWidget {
  /// IndexTaskListWidget constructor
  const PendingTaskListWidget({super.key});

  @override
  State<PendingTaskListWidget> createState() => _PendingTaskListWidgetState();
}

class _PendingTaskListWidgetState extends State<PendingTaskListWidget> {
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
            return pendingTasks.isNotEmpty
                ? ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: pendingTasks.length,
                    itemBuilder: (context, index) {
                      return PendingTaskWidget(
                        taskModel: pendingTasks[index],
                        dayFilterType: currentDayFilter,
                      )
                          .animate(delay: Duration(milliseconds: 50 * index))
                          .fadeIn(duration: 300.ms)
                          .slideX(
                            begin: 0.2,
                            end: 0,
                            duration: 400.ms,
                            curve: Curves.easeOutQuad,
                          );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 8,
                      );
                    },
                  )
                : NoTaskFoundWidget(
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
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
