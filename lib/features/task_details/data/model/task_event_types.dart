import 'package:flutter/material.dart';
import 'package:uptodo/core/storage/database/config/app_database.dart';
import 'package:uptodo/features/task_details/data/model/task_model/task_model.dart';

/// Class to represent a task event
class TaskTableEvents {
  /// TaskEvent constructor
  TaskTableEvents(this.task, this.eventType);

  /// Task entity data
  final TasksEntityData task;

  /// Task event type
  final TaskTableEventType eventType;

  /// TaskModel getter
  TaskModel get taskModel => TaskModel(
        taskId: task.taskId.toString(),
        title: task.title,
        description: task.description,
        subTaskId: task.subTaskId,
        priorityId: task.priorityId,
        taskTime: TimeOfDay.fromDateTime(task.taskTime),
        categoryId: task.categoryId,
        status: task.status,
        taskDate: DateTime(
          task.taskTime.year,
          task.taskTime.month,
          task.taskTime.day,
        ),
      );
}

/// Enum for task event types
enum TaskTableEventType {
  /// Task created
  created,

  /// Task updated
  updated,

  /// Task deleted
  deleted
}
