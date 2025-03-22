import 'package:flutter/material.dart';
import 'package:uptodo/features/task_details/data/model/task_model/task_model.dart';

/// TaskCard
class PendingTaskWidget extends StatelessWidget {
  /// TaskCard constructor
  const PendingTaskWidget({
    required this.taskModel,
    super.key,
  });

  /// TaskModel
  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(taskModel.title),
        subtitle: Text(taskModel.description),
        trailing: Text(taskModel.taskTime.toString()),
      ),
    );
  }
}
