import 'package:drift/drift.dart';

/// Category entity
class CategoryEntity extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Category name
  TextColumn get name => text()();

  /// Icon data or reference
  TextColumn get icon => text()(); // Store icon data or reference
  /// Hex color code
  TextColumn get color => text()(); // Store hex color code as string
}
