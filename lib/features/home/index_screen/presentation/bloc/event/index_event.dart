import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uptodo/features/task_details/data/model/task_model.dart';
import 'package:uptodo/shared/model/shred_enums.dart';

part 'index_event.freezed.dart';

@freezed
class IndexEvent with _$IndexEvent {
  const factory IndexEvent.loadAllTask() = LoadAllTaskEvent;

  const factory IndexEvent.markDone(TaskModel task) = MarkDoneEvent;

  const factory IndexEvent.navigateToTaskDetails(TaskModel task) =
      NavigateToTaskDetailsEvent;

  const factory IndexEvent.changeDaysFilter(DayFilterType dayFilterType) =
      ChangeDaysFilterEvent;

  const factory IndexEvent.changeStatusFilter(Status status) =
      ChangeStatusFilterEvent;

  const factory IndexEvent.searched(String text) = SearchedEvent;
}
