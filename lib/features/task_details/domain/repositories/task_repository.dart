import 'package:injectable/injectable.dart';
import 'package:uptodo/features/task_details/data/model/task_model/task_model.dart';

/// TaskRepository
@factoryMethod
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

  /// watch all tasks
  Stream<List<TaskModel>> watchAllTasks();
}
