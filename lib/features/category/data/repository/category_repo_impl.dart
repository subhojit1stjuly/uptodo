import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/features/category/data/database/category_database_module.dart';
import 'package:uptodo/features/category/data/model/category_model.dart';
import 'package:uptodo/features/category/domain/repository/category_repository.dart';

/// CategoryRepositoryImpl is a class that will be used to
/// manage the categories.
@Injectable(as: CategoryRepository)
class CategoryRepositoryImpl implements CategoryRepository {
  /// CategoryRepositoryImpl constructor
  CategoryRepositoryImpl(this._categoryDatabaseModule);

  final CategoryDatabaseModule _categoryDatabaseModule;

  @override
  Future<bool> addCategory(CategoryItem item) {
    // TODO: implement addCategory
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteCategory(int id) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<List<CategoryItem>> getAllCategories() async {
    final allCategories = await _categoryDatabaseModule.getAllCategories();
    return allCategories
        .map(
          (item) => CategoryItem(
            id: item.id,
            name: item.name,
            color: Color(int.parse(item.color.substring(2), radix: 16)),
            icon: _getIconFromCodePoint(item.icon),
          ),
        )
        .toList();
  }

  @override
  Future<bool> updateCategory(CategoryItem item) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }

  IconData _getIconFromCodePoint(String codePointString) {
    // Parse the codePoint string to an integer
    final codePoint = int.parse(codePointString);

    // Create an IconData with the codePoint and material icons font family
    return IconData(
      codePoint,
      fontFamily: 'MaterialIcons',
    );
  }
}
