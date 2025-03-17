import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uptodo/shared/model/shred_enums.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

/// TaskModel
@freezed
class TaskModel with _$TaskModel {
  /// factory constructor for TaskModel
  const factory TaskModel({
    required String title,
    required String description,
    required int priorityId,
    required DateTime taskTime,
    required int categoryId,
    String? taskId,
    String? subTaskId,
    @Default(Status.todo) Status status,
  }) = _TaskModel;

  /// fromJson
  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}
