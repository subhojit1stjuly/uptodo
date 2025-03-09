import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uptodo/features/home/index_screen/data/model/task_model.dart';

part 'index_state.freezed.dart';

@freezed
class IndexState with _$IndexState {
  const factory IndexState.initial() = InitialState;

  const factory IndexState.loading() = LoadingState;

  const factory IndexState.loaded(List<TaskModel> tasks) = LoadedState;

  const factory IndexState.error(String message) = ErrorState;

  const factory IndexState.changeDaysFilter(List<TaskModel> tasks) =
      ChangeDaysFilterState;

  const factory IndexState.changedStatusFilter(List<TaskModel> tasks) =
      ChangedStatusFilterState;
}
