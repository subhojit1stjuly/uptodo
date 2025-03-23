import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uptodo/features/category/data/model/category_model.dart';
import 'package:uptodo/features/onboarding/presentation/bloc/event_type.dart';
import 'package:uptodo/shared/model/shred_enums.dart';

part 'task_state.freezed.dart';

/// Task states
@freezed
class TaskState with _$TaskState {
  /// Initial state
  const factory TaskState.initial() = _Initial;

  /// State when a picker is opened with specific type
  const factory TaskState.pickerOpen(TaskPropertyEvents type, int time) =
      PickerOpenState;

  /// State when date is updated
  const factory TaskState.dateUpdated(DateTime date) = DateUpdatedState;

  /// State when priority is updated
  const factory TaskState.priorityUpdated(int priority) = PriorityUpdatedState;

  /// State when category is updated
  const factory TaskState.categoryUpdated(CategoryItem category) =
      CategoryUpdatedState;

  /// State when time is updated
  const factory TaskState.timeUpdated(TimeOfDay time) = TimeUpdatedState;

  /// State when status is updated
  const factory TaskState.statusUpdated(TaskStatus status) = StatusUpdatedState;

  /// State when a task has been created
  const factory TaskState.taskCreated() = TaskCreatedState;

  /// State when a task has been edited
  const factory TaskState.taskUpdated() = TaskUpdatedState;

  /// State when a task has been deleted
  const factory TaskState.taskDeleted() = TaskDeletedState;
}
