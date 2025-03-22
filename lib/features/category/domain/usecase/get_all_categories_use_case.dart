import 'package:injectable/injectable.dart';
import 'package:uptodo/core/utils/use_case.dart';
import 'package:uptodo/features/category/data/model/category_model.dart';
import 'package:uptodo/features/category/domain/repository/category_repository.dart';

/// GetAllCategoriesUseCase is a class that will be used to
/// get all categories.
@injectable
class GetAllCategoriesUseCase extends UseCase<List<CategoryItem>, void> {
  /// GetAllCategoriesUseCase constructor
  GetAllCategoriesUseCase(this.categoryRepo);

  /// CategoryRepo instance
  final CategoryRepository categoryRepo;

  @override
  Future<List<CategoryItem>> run(void params) async {
    return categoryRepo.getAllCategories();
  }
}
