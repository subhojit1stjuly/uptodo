import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uptodo/core/localizations/app_localizations.dart';
import 'package:uptodo/features/home/presentation/index_screen/bloc/index_bloc.dart';
import 'package:uptodo/features/home/presentation/index_screen/bloc/state/index_state.dart';
import 'package:uptodo/features/task_details/presentation/widget/completed_task_widget.dart';

/// OtherTaskListWidget
class OtherTaskListWidget extends StatefulWidget {
  /// OtherTaskListWidget constructor
  const OtherTaskListWidget({super.key});

  @override
  State<OtherTaskListWidget> createState() => _OtherTaskListWidgetState();
}

class _OtherTaskListWidgetState extends State<OtherTaskListWidget> {
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
            return completedTasks.isNotEmpty
                ? Column(
                    spacing: 12,
                    children: [
                      Card(
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.completed,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: completedTasks.length,
                        itemBuilder: (context, index) {
                          return CompletedTaskWidget(
                            taskModel: completedTasks[index],
                          );
                        },
                      ),
                    ],
                  )
                : const SizedBox.shrink();
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
