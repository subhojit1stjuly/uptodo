import 'package:flutter/material.dart';
import 'package:uptodo/core/storage/database/config/app_database.dart';
import 'package:uptodo/core/utils/common_extainsions.dart';
import 'package:uptodo/features/category/data/model/category_model.dart';
import 'package:uptodo/features/task_details/data/model/task_model/task_model.dart';
import 'package:uptodo/features/task_details/data/model/task_with_category.dart';

/// Class to represent a task event
class TaskTableEvents {
  /// TaskEvent constructor
  TaskTableEvents(this.taskWithCategory, this.eventType);

  /// Task entity data
  final TaskWithCategory taskWithCategory;

  /// Task event type
  final TaskTableEventType eventType;

  /// getter for task entity data
  TasksEntityData get task => taskWithCategory.task;

  /// getter for category data
  CategoryEntityData get category => taskWithCategory.category;

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
        category: CategoryItem(
          id: category.id,
          name: category.name,
          color: Color(int.parse(category.color)),
          icon: category.icon.getIconFromCodePoint(),
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
