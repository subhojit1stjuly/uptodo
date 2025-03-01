import 'package:flutter/material.dart';
import 'package:uptodo/features/home/index_screen/presentation/widget/index_task_list_widget.dart';

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
    return const IndexTaskListWidget();
  }
}
