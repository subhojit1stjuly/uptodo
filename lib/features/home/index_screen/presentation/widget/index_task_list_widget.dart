import 'package:flutter/material.dart';
import 'package:uptodo/core/localizations/app_localizations.dart';
import 'package:uptodo/shared/widgets/task/no_task_found_widget.dart';

/// IndexTaskListWidget
class IndexTaskListWidget extends StatefulWidget {
  /// IndexTaskListWidget constructor
  const IndexTaskListWidget({super.key});

  @override
  State<IndexTaskListWidget> createState() => _IndexTaskListWidgetState();
}

class _IndexTaskListWidgetState extends State<IndexTaskListWidget> {
  @override
  Widget build(BuildContext context) {
    return NoTaskFoundWidget(
      message: AppLocalizations.of(context)!.what_do_you_want_to_do_today,
      subtitle: AppLocalizations.of(context)!.tap_to_add_tasks,
    );
  }
}
