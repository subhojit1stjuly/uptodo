import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uptodo/features/task_details/data/model/task_model/task_model.dart';

part 'task_state.freezed.dart';

/// this enum represents the status of task editing
enum TaskEditingStatus {
  /// initial state
  initial,

  /// loading
  loading,

  /// task created successfully
  created,

  /// task updated successfully
  updated,

  /// task deleted successfully
  deleted,

  /// error state
  errored
}

/// Task states
@freezed
abstract class TaskState with _$TaskState {
  /// factory constructor for TaskState
  const factory TaskState({
    TaskModel? taskModel,
    @Default(TaskEditingStatus.initial) TaskEditingStatus editingStatus,
    String? errorMessage,
  }) = _TaskState;
}
