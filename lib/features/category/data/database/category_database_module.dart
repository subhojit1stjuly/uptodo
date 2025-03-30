import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/core/storage/database/config/app_database.dart';
import 'package:uptodo/features/category/domain/entities/category_entity.dart';

part 'category_database_module.g.dart';

/// CategoryDatabaseModule
@injectable
@DriftAccessor(tables: [CategoryEntity])
class CategoryDatabaseModule extends DatabaseAccessor<AppDatabase>
    with _$CategoryDatabaseModuleMixin {
  /// CategoryDatabaseModule constructor
  CategoryDatabaseModule(super.attachedDatabase);

  /// Get all categories
  Future<List<CategoryEntityData>> getAllCategories() =>
      select(categoryEntity).get();

  /// Get category by id
  Future<CategoryEntityData> getCategoryById(int id) {
    return (select(categoryEntity)..where((c) => c.id.equals(id))).getSingle();
  }

  /// Insert category
  Future<int> insertCategory(CategoryEntityCompanion category) {
    return into(categoryEntity).insert(category);
  }

  /// Insert default categories
  Future<bool> defaultBatchInsert() async {
    try {
      // Insert default categories
      await batch((batch) {
        batch.insertAll(categoryEntity, [
          CategoryEntityCompanion.insert(
            name: 'Work',
            color: Colors.blue.toARGB32().toString(),
            icon: Icons.work.codePoint.toString(),
          ),
          CategoryEntityCompanion.insert(
            name: 'Study',
            color: Colors.green.toARGB32().toString(),
            icon: Icons.school.codePoint.toString(),
          ),
          CategoryEntityCompanion.insert(
            name: 'Personal',
            color: Colors.orange.toARGB32().toString(),
            icon: Icons.person.codePoint.toString(),
          ),
          CategoryEntityCompanion.insert(
            name: 'Shopping',
            color: Colors.purple.toARGB32().toString(),
            icon: Icons.shopping_cart.codePoint.toString(),
          ),
          CategoryEntityCompanion.insert(
            name: 'Health',
            color: Colors.red.toARGB32().toString(),
            icon: Icons.favorite.codePoint.toString(),
          ),
          CategoryEntityCompanion.insert(
            name: 'Finance',
            color: Colors.indigo.toARGB32().toString(),
            icon: Icons.attach_money.codePoint.toString(),
          ),
          CategoryEntityCompanion.insert(
            name: 'Home',
            color: Colors.brown.toARGB32().toString(),
            icon: Icons.home.codePoint.toString(),
          ),
          CategoryEntityCompanion.insert(
            name: 'Entertainment',
            color: Colors.pink.toARGB32().toString(),
            icon: Icons.movie.codePoint.toString(),
          ),
          CategoryEntityCompanion.insert(
            name: 'Family',
            color: Colors.grey.toARGB32().toString(),
            icon: Icons.family_restroom.codePoint.toString(),
          ),
        ]);
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Update category
  Future<bool> updateCategory(CategoryEntityCompanion category) {
    return update(categoryEntity).replace(category);
  }

  /// Delete category
  Future<int> deleteCategory(int id) {
    return (delete(categoryEntity)..where((c) => c.id.equals(id))).go();
  }
}
