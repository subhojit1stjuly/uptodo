import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/features/category/domain/usecase/get_all_categories_use_case.dart';
import 'package:uptodo/features/category/presentation/bloc/event/category_event.dart';
import 'package:uptodo/features/category/presentation/bloc/state/category_state.dart';

/// CategoryBloc is a class that will be used to
/// manage the events of the category page and dialog.
@injectable
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  /// CategoryBloc constructor
  CategoryBloc(this.getAllCategoriesUseCase)
      : super(const CategoryState.loading()) {
    on<LoadAllCategoryEvent>(_onLoadAllCategory);
  }

  /// getAllCategoriesUseCase instance
  final GetAllCategoriesUseCase getAllCategoriesUseCase;

  Future<void> _onLoadAllCategory(
    LoadAllCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    final categories = await getAllCategoriesUseCase.run(null);
    if (categories.isEmpty) {
      emit(const CategoryState.empty());
    } else {
      emit(CategoryState.loaded(categories));
    }
  }
}
