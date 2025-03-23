import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uptodo/features/category/data/model/category_model.dart';

part 'category_state.freezed.dart';

/// CategoryState is a class that will be used to
/// manage the states of the category page and dialog.
@freezed
class CategoryState with _$CategoryState {
  /// LoadingState is a state that will be used to
  /// show a loading state.
  const factory CategoryState.loading() = LoadingState;

  /// LoadedState is a state that will be used to
  /// show a loaded state.
  const factory CategoryState.loaded(List<CategoryItem> categories) =
      LoadedState;

  /// ErrorState is a state that will be used to
  /// show an error state.
  const factory CategoryState.error(String message) = ErrorState;

  /// EmptyState is a state that will be used to
  /// show an empty state.
  const factory CategoryState.empty() = EmptyState;
}
