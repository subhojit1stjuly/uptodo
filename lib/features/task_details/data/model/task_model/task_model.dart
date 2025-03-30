import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uptodo/features/category/data/model/category_model.dart';
import 'package:uptodo/shared/json_converter/category_converter.dart';
import 'package:uptodo/shared/json_converter/time_of_day_converter.dart';
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
    required DateTime taskDate,
    @TimeOfDayConverter() required TimeOfDay taskTime,
    required int categoryId,
    String? taskId,
    String? subTaskId,
    @CategoryConverter() CategoryItem? category,
    @Default(TaskStatus.pending) TaskStatus status,
  }) = _TaskModel;

  /// fromJson
  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}
