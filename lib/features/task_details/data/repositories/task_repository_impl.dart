import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/core/storage/database/config/app_database.dart';
import 'package:uptodo/features/task_details/data/database/tasks_database_module.dart';
import 'package:uptodo/features/task_details/data/model/task_model/task_model.dart';
import 'package:uptodo/features/task_details/domain/repositories/task_create_update_repository.dart';

/// TaskRepositoryImpl
@Injectable(as: TaskCreateUpdateRepository)
class TaskRepositoryImpl implements TaskCreateUpdateRepository {
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
      taskTime: Value(
        DateTime(
          taskModel.taskDate.year,
          taskModel.taskDate.month,
          taskModel.taskDate.day,
          taskModel.taskTime.hour,
          taskModel.taskTime.minute,
        ).toUtc(),
      ),
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
        taskTime: Value(
          DateTime(
            taskModel.taskDate.year,
            taskModel.taskDate.month,
            taskModel.taskDate.day,
            taskModel.taskTime.hour,
            taskModel.taskTime.minute,
          ).toUtc(),
        ),
        categoryId: Value(taskModel.categoryId),
        status: Value(taskModel.status),
      ),
    );
  }

  @override
  Future<void> deleteTask(int id) async {
    return _databaseModule.deleteTask(id);
  }
}
