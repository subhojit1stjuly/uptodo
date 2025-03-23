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
            color: '0x2196F3FF',
            icon: Icons.work.codePoint.toString(),
          ),
          CategoryEntityCompanion.insert(
            name: 'Study',
            color: '0x4CAF50FF',
            icon: Icons.school.codePoint.toString(),
          ),
          CategoryEntityCompanion.insert(
            name: 'Personal',
            color: '0xFF9800FF',
            icon: Icons.person.codePoint.toString(),
          ),
          CategoryEntityCompanion.insert(
            name: 'Shopping',
            color: '0x9C27B0FF',
            icon: Icons.shopping_cart.codePoint.toString(),
          ),
          CategoryEntityCompanion.insert(
            name: 'Health',
            color: '0xF44336FF',
            icon: Icons.favorite.codePoint.toString(),
          ),
          CategoryEntityCompanion.insert(
            name: 'Finance',
            color: '0x3F51B5FF',
            icon: Icons.attach_money.codePoint.toString(),
          ),
          CategoryEntityCompanion.insert(
            name: 'Home',
            color: '0x795548FF',
            icon: Icons.home.codePoint.toString(),
          ),
          CategoryEntityCompanion.insert(
            name: 'Entertainment',
            color: '0xE91E63FF',
            icon: Icons.movie.codePoint.toString(),
          ),
          CategoryEntityCompanion.insert(
            name: 'Family',
            color: '0x009688FF',
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
