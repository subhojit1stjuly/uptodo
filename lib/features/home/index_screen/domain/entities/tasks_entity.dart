import 'package:drift/drift.dart';
import 'package:uptodo/features/category/domain/entities/category_entity.dart';
import 'package:uptodo/features/priority/domain/entities/priority_entity.dart';
import 'package:uptodo/shared/model/shred_enums.dart';

class TasksEntity extends Table {
  IntColumn get taskId => integer().autoIncrement()();

  TextColumn get title => text()();

  TextColumn get description => text()();

  TextColumn get subTaskId => text().nullable()();

  IntColumn get priorityId => integer().references(PriorityEntity, #id)();

  DateTimeColumn get taskTime => dateTime()();

  IntColumn get categoryId => integer().references(CategoryEntity, #id)();

  IntColumn get status => intEnum<Status>()();
}
