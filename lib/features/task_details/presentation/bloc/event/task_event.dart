import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uptodo/features/onboarding/presentation/bloc/event_type.dart';
import 'package:uptodo/features/task_details/data/model/task_model.dart';

part 'task_event.freezed.dart';

/// Task events
@freezed
class TaskEvent with _$TaskEvent {
  /// Event to open a picker with specified type
  const factory TaskEvent.openPicker(TaskPropertyEvents type) = OpenPickerEvent;

  /// Event to create a new task
  const factory TaskEvent.create(TaskModel taskModel) = CreateEvent;
}
