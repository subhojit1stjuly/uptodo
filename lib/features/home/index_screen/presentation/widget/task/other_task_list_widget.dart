import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uptodo/core/localizations/app_localizations.dart';
import 'package:uptodo/features/home/index_screen/presentation/bloc/index_bloc.dart';
import 'package:uptodo/features/home/index_screen/presentation/bloc/state/index_state.dart';
import 'package:uptodo/features/task_details/presentation/widget/completed_task_widget.dart';
import 'package:uptodo/shared/widgets/task/no_task_found_widget.dart';

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
      buildWhen: (prev, cur) => cur is ChangedStatusFilterState,
      builder: (context, state) {
        return state.maybeWhen(
          changedStatusFilter: (taskList) {
            return taskList.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: taskList.length,
                    itemBuilder: (context, index) {
                      return CompletedTaskWidget(
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
