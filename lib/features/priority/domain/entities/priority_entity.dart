import 'package:drift/drift.dart';

class PriorityEntity extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  IntColumn get level => integer()();

  TextColumn get color => text()(); // Store hex color code as string
}
