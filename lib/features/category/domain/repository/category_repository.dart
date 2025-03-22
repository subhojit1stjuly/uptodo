import 'package:injectable/injectable.dart';
import 'package:uptodo/features/category/data/model/category_model.dart';

/// CategoryRepo is an abstract class that will be used to
/// manage the categories.
@factoryMethod
abstract class CategoryRepository {
  /// getAllCategories is a method that will be used to
  /// get all categories.
  Future<List<CategoryItem>> getAllCategories();

  /// addCategory is a method that will be used to
  /// add a category.
  Future<bool> addCategory(CategoryItem item);

  /// updateCategory is a method that will be used to
  /// update a category.
  Future<bool> updateCategory(CategoryItem item);

  /// deleteCategory is a method that will be used to
  /// delete a category.
  Future<bool> deleteCategory(int id);
}
