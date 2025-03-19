import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/core/storage/database/config/app_database.dart';
import 'package:uptodo/features/task_details/data/database/tasks_database_module.dart';
import 'package:uptodo/features/task_details/data/model/task_model.dart';
import 'package:uptodo/features/task_details/domain/repositories/task_repository.dart';

/// TaskRepositoryImpl
@Injectable(as: TaskRepository)
class TaskRepositoryImpl implements TaskRepository {
  /// TaskRepositoryImpl constructor
  TaskRepositoryImpl(this._databaseModule);

  final TasksDatabaseModule _databaseModule;

  @override
  Future<int> createTask(
    TaskModel taskModel,
  ) async {
    final task = TasksEntityCompanion(
      title: Value(taskModel.title),
      description: Value(taskModel.description),
      subTaskId: Value(taskModel.subTaskId),
      priorityId: Value(taskModel.priorityId),
      taskTime: Value(taskModel.taskTime),
      categoryId: Value(taskModel.categoryId),
      status: Value(taskModel.status),
    );

    return _databaseModule.insertTask(task);
  }

  @override
  Future<bool> updateTask(TaskModel taskModel) async {
    return _databaseModule.updateTask(
      TasksEntityCompanion(
        title: Value(taskModel.title),
        description: Value(taskModel.description),
        subTaskId: Value(taskModel.subTaskId),
        priorityId: Value(taskModel.priorityId),
        taskTime: Value(taskModel.taskTime),
        categoryId: Value(taskModel.categoryId),
        status: Value(taskModel.status),
      ),
    );
  }

  @override
  Future<bool> deleteTask(int id) {
    return _databaseModule.deleteTask(id).then((value) => value > 0);
  }

  @override
  Stream<List<TaskModel>> watchAllTasks() =>
      _databaseModule.watchAllTasks().map(
            (tasks) => tasks
                .map(
                  (task) => TaskModel(
                    taskId: task.taskId.toString(),
                    title: task.title,
                    description: task.description,
                    subTaskId: task.subTaskId,
                    priorityId: task.priorityId,
                    taskTime: task.taskTime,
                    categoryId: task.categoryId,
                    status: task.status,
                  ),
                )
                .toList(),
          );
}
