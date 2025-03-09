import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uptodo/features/category/data/database/category_database_module.dart';
import 'package:uptodo/features/category/domain/entities/category_entity.dart';
import 'package:uptodo/features/home/index_screen/domain/entities/tasks_entity.dart';
import 'package:uptodo/features/priority/data/database/priority_database_module.dart';
import 'package:uptodo/features/priority/domain/entities/priority_entity.dart';
import 'package:uptodo/features/task_details/data/database/tasks_database_module.dart';

part 'app_database.g.dart';

/// The Drift database implementation
@DriftDatabase(
  tables: [TasksEntity, PriorityEntity, CategoryEntity],
  daos: [TasksDatabaseModule, CategoryDatabaseModule, PriorityDatabaseModule],
)
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  /// The schema version for the database
  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'drift-uptodo.sqlite',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }

  // Generated accessors
  late final TasksDatabaseModule tasksDatabaseModule =
      TasksDatabaseModule(this);
  late final CategoryDatabaseModule categoryDatabaseModule =
      CategoryDatabaseModule(this);
  late final PriorityDatabaseModule priorityDatabaseModule =
      PriorityDatabaseModule(this);
}
