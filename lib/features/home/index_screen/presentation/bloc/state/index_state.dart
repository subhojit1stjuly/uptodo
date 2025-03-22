import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uptodo/features/task_details/data/model/task_model/task_model.dart';

part 'index_state.freezed.dart';

/// Index state
@freezed
class IndexState with _$IndexState {
  /// initial state
  const factory IndexState.initial() = InitialState;

  /// loading state
  const factory IndexState.loading() = LoadingState;

  /// no summary found state
  const factory IndexState.noSummaryFound() = NoSummaryFoundState;

  /// no data found state
  const factory IndexState.noDataFound() = NoDataFoundState;

  /// summary found state
  const factory IndexState.summaryFound() = SummaryFoundState;

  /// data found state
  const factory IndexState.error(String message) = ErrorState;

  /// data found state
  const factory IndexState.changeDaysFilter(List<TaskModel> tasks) =
      ChangeDaysFilterState;

  /// data found state
  const factory IndexState.changedStatusFilter(List<TaskModel> tasks) =
      ChangedStatusFilterState;
}
