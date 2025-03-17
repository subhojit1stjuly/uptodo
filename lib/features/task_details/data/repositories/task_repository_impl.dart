import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/core/storage/database/config/app_database.dart';
import 'package:uptodo/features/task_details/data/database/tasks_database_module.dart';
import 'package:uptodo/features/task_details/domain/repositories/task_repository.dart';

@Injectable(as: TaskRepository)
class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl(this._databaseModule);

  final TasksDatabaseModule _databaseModule;

  @override
  Future<int> createTask({
    required String title,
    String? description,
    DateTime? dueDate,
    int? categoryId,
    int? priority,
  }) {
    final task = TasksEntityCompanion(
      title: Value(title),
      description: Value(description!),
      categoryId: Value(categoryId!),
      priorityId: Value(priority!),
    );

    return _databaseModule.insertTask(task);
  }
}
