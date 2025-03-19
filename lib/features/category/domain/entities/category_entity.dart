import 'package:drift/drift.dart';

class CategoryEntity extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get icon => text()(); // Store icon data or reference
  TextColumn get color => text()(); // Store hex color code as string
}
