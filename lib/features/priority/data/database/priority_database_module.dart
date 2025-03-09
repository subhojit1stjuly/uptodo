import 'package:drift/drift.dart';
import 'package:uptodo/core/storage/database/config/app_database.dart';
import 'package:uptodo/features/priority/domain/entities/priority_entity.dart';

part 'priority_database_module.g.dart';

@DriftAccessor(tables: [PriorityEntity])
class PriorityDatabaseModule extends DatabaseAccessor<AppDatabase>
    with _$PriorityDatabaseModuleMixin {
  PriorityDatabaseModule(super.attachedDatabase);

  // Get all priorities
  Future<List<PriorityEntityData>> getAllPriorities() =>
      select(priorityEntity).get();

  // Get priority by id
  Future<PriorityEntityData> getPriorityById(int id) {
    return (select(priorityEntity)..where((p) => p.id.equals(id))).getSingle();
  }

  // Insert priority
  Future<int> insertPriority(PriorityEntityCompanion priority) {
    return into(priorityEntity).insert(priority);
  }

  // Update priority
  Future<bool> updatePriority(PriorityEntityCompanion priority) {
    return update(priorityEntity).replace(priority);
  }

  // Delete priority
  Future<int> deletePriority(int id) {
    return (delete(priorityEntity)..where((p) => p.id.equals(id))).go();
  }
}
