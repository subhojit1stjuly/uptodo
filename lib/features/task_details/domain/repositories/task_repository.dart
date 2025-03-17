import 'package:uptodo/features/task_details/data/model/task_model.dart';

/// TaskRepository
abstract class TaskRepository {
  /// create task
  Future<int> createTask(
    TaskModel taskModel,
  );

  /// update task
  Future<bool> updateTask(
    TaskModel taskModel,
  );

  /// delete task
  Future<bool> deleteTask(
    int id,
  );
}
