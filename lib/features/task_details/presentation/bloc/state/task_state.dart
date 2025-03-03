import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uptodo/features/onboarding/presentation/bloc/event_type.dart';

part 'task_state.freezed.dart';

/// Task states
@freezed
class TaskState with _$TaskState {
  /// Initial state
  const factory TaskState.initial() = _Initial;

  /// State when a picker is opened with specific type
  const factory TaskState.pickerOpen(TaskPropertyEvents type, int time) =
      PickerOpenState;

  /// State when a task has been created
  const factory TaskState.taskCreated() = TaskCreatedState;

  /// State when a task has been edited
  const factory TaskState.taskEdited() = TaskEditedState;
}
