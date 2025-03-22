import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uptodo/features/task_details/data/model/task_model/task_model.dart';
import 'package:uptodo/shared/model/shred_enums.dart';

part 'index_event.freezed.dart';

/// IndexEvent is a class that will be used to
/// manage the events of the index page.
@freezed
class IndexEvent with _$IndexEvent {
  /// LoadAllTaskEvent is an event that will be used to
  /// load all tasks.
  const factory IndexEvent.loadTaskSummary() = LoadTaskSummaryEvent;

  /// MarkDoneEvent is an event that will be used to
  /// mark a task as done.
  const factory IndexEvent.navigateToTaskDetails(TaskModel task) =
      NavigateToTaskDetailsEvent;

  /// ChangeDaysFilterEvent is an event that will be used to
  /// change the days filter.
  const factory IndexEvent.changeDaysFilter(DayFilterType dayFilterType) =
      ChangeDaysFilterEvent;

  /// ChangeStatusFilterEvent is an event that will be used to
  /// change the status filter.
  const factory IndexEvent.changeStatusFilter(TaskStatus status) =
      ChangeStatusFilterEvent;

  /// SearchedEvent is an event that will be used to
  /// search tasks.
  const factory IndexEvent.searched(String text) = SearchedEvent;
}
