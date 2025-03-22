import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uptodo/core/localizations/app_localizations.dart';
import 'package:uptodo/features/home/index_screen/presentation/bloc/index_bloc.dart';
import 'package:uptodo/features/home/index_screen/presentation/bloc/state/index_state.dart';
import 'package:uptodo/features/task_details/presentation/widget/pending_task_widget.dart';
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
      buildWhen: (prev, cur) => cur is ChangeDaysFilterState,
      builder: (context, state) {
        return state.maybeWhen(
          changeDaysFilter: (taskList) {
            return taskList.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: taskList.length,
                    itemBuilder: (context, index) {
                      return PendingTaskWidget(
                        taskModel: taskList[index],
                      );
                    },
                  )
                : NoTaskFoundWidget(
                    message: AppLocalizations.of(context)!
                        .what_do_you_want_to_do_today,
                    subtitle: AppLocalizations.of(context)!.tap_to_add_tasks,
                  );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
