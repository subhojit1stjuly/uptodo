import 'package:drift/drift.dart';
import 'package:uptodo/core/storage/database/config/app_database.dart';
import 'package:uptodo/features/category/domain/entities/category_entity.dart';

part 'category_database_module.g.dart';

@DriftAccessor(tables: [CategoryEntity])
class CategoryDatabaseModule extends DatabaseAccessor<AppDatabase>
    with _$CategoryDatabaseModuleMixin {
  CategoryDatabaseModule(super.attachedDatabase);

  // Get all categories
  Future<List<CategoryEntityData>> getAllCategories() =>
      select(categoryEntity).get();

  // Get category by id
  Future<CategoryEntityData> getCategoryById(int id) {
    return (select(categoryEntity)..where((c) => c.id.equals(id))).getSingle();
  }

  // Insert category
  Future<int> insertCategory(CategoryEntityCompanion category) {
    return into(categoryEntity).insert(category);
  }

  // Update category
  Future<bool> updateCategory(CategoryEntityCompanion category) {
    return update(categoryEntity).replace(category);
  }

  // Delete category
  Future<int> deleteCategory(int id) {
    return (delete(categoryEntity)..where((c) => c.id.equals(id))).go();
  }
}
