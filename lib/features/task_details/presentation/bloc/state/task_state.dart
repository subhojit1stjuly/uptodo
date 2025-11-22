import 'package:equatable/equatable.dart';
import 'package:uptodo/features/task_details/data/model/task_model/task_model.dart';

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
class TaskState extends Equatable {
  /// Constructor for TaskState
  const TaskState({
    this.taskModel,
    this.editingStatus = TaskEditingStatus.initial,
    this.errorMessage,
  });

  /// The current task model being edited
  final TaskModel? taskModel;

  /// The current status of task editing
  final TaskEditingStatus editingStatus;

  /// An optional error message
  final String? errorMessage;

  /// Creates a copy of the current TaskState with optional new values
  TaskState copyWith({
    TaskModel? taskModel,
    TaskEditingStatus? editingStatus,
    String? errorMessage,
  }) {
    return TaskState(
      taskModel: taskModel ?? this.taskModel,
      editingStatus: editingStatus ?? this.editingStatus,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [taskModel, editingStatus, errorMessage];
}
