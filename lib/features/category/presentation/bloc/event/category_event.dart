import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uptodo/features/category/data/model/category_model.dart';

part 'category_event.freezed.dart';

/// CategoryEvent is a class that will be used to
/// manage the events of the category page.
@freezed
class CategoryEvent with _$CategoryEvent {
  /// LoadAllCategoryEvent is an event that will be used to
  /// load all categories.
  const factory CategoryEvent.loadAllCategory() = LoadAllCategoryEvent;

  /// NavigateToCategoryDetailsEvent is an event that will be used to
  /// navigate to the category details page.
  const factory CategoryEvent.navigateToCategoryDetails(CategoryItem category) =
      NavigateToCategoryDetailsEvent;

  /// SearchedEvent is an event that will be used to
  /// search categories.
  const factory CategoryEvent.searched(String text) = SearchedEvent;
}
