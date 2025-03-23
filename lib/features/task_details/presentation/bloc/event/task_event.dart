import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uptodo/features/category/data/model/category_model.dart';
import 'package:uptodo/features/onboarding/presentation/bloc/event_type.dart';
import 'package:uptodo/features/task_details/data/model/task_model/task_model.dart';
import 'package:uptodo/shared/model/shred_enums.dart';

part 'task_event.freezed.dart';

/// Task events
@freezed
class TaskEvent with _$TaskEvent {
  /// Event to open a picker with specified type
  const factory TaskEvent.openPicker(TaskPropertyEvents type) = OpenPickerEvent;

  /// Event to update the task date
  const factory TaskEvent.updateDate(DateTime date) = UpdateDateEvent;

  /// Event to update the task priority
  const factory TaskEvent.updatePriority(int priority) = UpdatePriorityEvent;

  /// Event to update the task category
  const factory TaskEvent.updateCategory(CategoryItem category) =
      UpdateCategoryEvent;

  /// Event to update the task time
  const factory TaskEvent.updateTime(TimeOfDay time) = UpdateTimeEvent;

  /// Event to update the task status
  const factory TaskEvent.updateStatus(TaskStatus status) = UpdateStatusEvent;

  /// Event to create a new task
  const factory TaskEvent.create({
    required String title,
    required String desc,
  }) = CreateEvent;

  /// Event to update a task
  const factory TaskEvent.update({
    required TaskModel taskModel,
  }) = UpdateEvent;

  /// Event to delete a task
  const factory TaskEvent.delete({
    required TaskModel taskModel,
  }) = DeleteEvent;
}
