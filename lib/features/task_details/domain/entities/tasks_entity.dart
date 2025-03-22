import 'package:drift/drift.dart';
import 'package:uptodo/features/category/domain/entities/category_entity.dart';
import 'package:uptodo/shared/model/shred_enums.dart';

/// TasksEntity
class TasksEntity extends Table {
  /// Primary key
  IntColumn get taskId => integer().autoIncrement()();

  /// Task title
  TextColumn get title => text()();

  /// Task description
  TextColumn get description => text()();

  /// Sub task id
  TextColumn get subTaskId => text().nullable()();

  /// Priority id
  IntColumn get priorityId => integer()();

  /// Task time
  DateTimeColumn get taskTime => dateTime()();

  /// Category id
  IntColumn get categoryId => integer().references(CategoryEntity, #id)();

  /// Task status
  IntColumn get status => intEnum<TaskStatus>()();
}
