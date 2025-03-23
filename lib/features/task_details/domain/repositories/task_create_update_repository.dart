import 'package:injectable/injectable.dart';
import 'package:uptodo/features/task_details/data/model/task_model/task_model.dart';

/// TaskRepository
@factoryMethod
abstract class TaskCreateUpdateRepository {
  /// create task
  Future<int> createTask(
    TaskModel taskModel,
  );

  /// update task
  Future<bool> updateTask(
    TaskModel taskModel,
  );

  /// delete task
  Future<void> deleteTask(
    int id,
  );
}
