import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uptodo/shared/model/shred_enums.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String taskId,
    required String title,
    required String description,
    String? subTaskId,
    required int priorityId,
    required DateTime taskTime,
    required int categoryId,
    @Default(Status.todo) Status status,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}
