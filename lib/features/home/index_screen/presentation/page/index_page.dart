import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uptodo/core/localizations/app_localizations.dart';
import 'package:uptodo/features/home/index_screen/presentation/bloc/index_bloc.dart';
import 'package:uptodo/features/home/index_screen/presentation/bloc/state/index_state.dart';
import 'package:uptodo/features/home/index_screen/presentation/widget/search_bar_widget.dart';
import 'package:uptodo/features/home/index_screen/presentation/widget/task/dropdown_task_widget.dart';
import 'package:uptodo/features/home/index_screen/presentation/widget/task/other_task_list_widget.dart';
import 'package:uptodo/features/home/index_screen/presentation/widget/task/pending_task_list_widget.dart';
import 'package:uptodo/shared/model/shred_enums.dart';
import 'package:uptodo/shared/widgets/task/no_task_found_widget.dart';

/// this widget is used to show index page
class IndexPage extends StatefulWidget {
  /// constructor for IndexPage
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndexBloc, IndexState>(
      bloc: context.read<IndexBloc>(),
      buildWhen: (previous, current) =>
          current is LoadingState ||
          current is NoSummaryFoundState ||
          current is SummaryFoundState,
      builder: (context, state) {
        return state.maybeWhen(
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          noSummaryFound: () {
            return NoTaskFoundWidget(
              message:
                  AppLocalizations.of(context)!.what_do_you_want_to_do_today,
              subtitle: AppLocalizations.of(context)!.tap_to_add_tasks,
            );
          },
          summaryFound: () {
            return SingleChildScrollView(
              child: Column(
                children: [
                  /// searchbar
                  SearchBarWidget(
                    onSearch: (String value) {},
                  ),

                  /// pending task list
                  DropdownTaskWidget<DayFilterType>(
                    dropdownMenuEntries: [
                      DropdownMenuEntry(
                        value: DayFilterType.today,
                        label: AppLocalizations.of(context)!.today,
                      ),
                      DropdownMenuEntry(
                        value: DayFilterType.tomorrow,
                        label: AppLocalizations.of(context)!.tomorrow,
                      ),
                      DropdownMenuEntry(
                        value: DayFilterType.yesterday,
                        label: AppLocalizations.of(context)!.yesterday,
                      ),
                    ],
                    initialSelection: DayFilterType.today,
                    onSelected: (DayFilterType? type) {},
                  ),
                  const PendingTaskListWidget(),

                  /// completed task
                  DropdownTaskWidget<TaskStatus>(
                    dropdownMenuEntries: [
                      DropdownMenuEntry(
                        value: TaskStatus.completed,
                        label: AppLocalizations.of(context)!.completed,
                      ),
                      DropdownMenuEntry(
                        value: TaskStatus.overdue,
                        label: AppLocalizations.of(context)!.overdue,
                      ),
                    ],
                    initialSelection: TaskStatus.completed,
                    onSelected: (TaskStatus? type) {},
                  ),
                  const OtherTaskListWidget(),
                ],
              ),
            );
          },
          orElse: () {
            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
