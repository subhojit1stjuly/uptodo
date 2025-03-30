import 'package:uptodo/core/storage/database/config/app_database.dart';

/// TaskWithCategory
class TaskWithCategory {
  /// TaskWithCategory constructor
  TaskWithCategory({required this.task, required this.category});

  /// task
  final TasksEntityData task;

  /// category
  final CategoryEntityData category;
}
