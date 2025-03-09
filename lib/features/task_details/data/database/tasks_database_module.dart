import 'package:drift/drift.dart';
import 'package:uptodo/core/storage/database/config/app_database.dart';
import 'package:uptodo/features/home/index_screen/domain/entities/tasks_entity.dart';

part 'tasks_database_module.g.dart';

@DriftAccessor(tables: [TasksEntity])
class TasksDatabaseModule extends DatabaseAccessor<AppDatabase>
    with _$TasksDatabaseModuleMixin {
  TasksDatabaseModule(super.attachedDatabase);

  // Get all tasks
  Future<List<TasksEntityData>> getAllTasks() => select(tasksEntity).get();

  // Get task by id
  Future<TasksEntityData> getTaskById(int id) {
    return (select(tasksEntity)..where((t) => t.taskId.equals(id))).getSingle();
  }

  // Insert task
  Future<int> insertTask(TasksEntityCompanion task) {
    return into(tasksEntity).insert(task);
  }

  // Update task
  Future<bool> updateTask(TasksEntityCompanion task) {
    return update(tasksEntity).replace(task);
  }

  // Delete task
  Future<int> deleteTask(int id) {
    return (delete(tasksEntity)..where((t) => t.taskId.equals(id))).go();
  }
}
