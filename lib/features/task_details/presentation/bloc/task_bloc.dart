import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/features/task_details/data/model/task_model/task_model.dart';
import 'package:uptodo/features/task_details/domain/usecase/create_task_use_case.dart';
import 'package:uptodo/features/task_details/domain/usecase/delete_task_use_case.dart';
import 'package:uptodo/features/task_details/domain/usecase/update_task_use_case.dart';
import 'package:uptodo/features/task_details/presentation/bloc/event/task_event.dart';
import 'package:uptodo/features/task_details/presentation/bloc/state/task_state.dart';

/// TaskBloc handles task-related operations
@injectable
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  /// Initialize TaskBloc with initial state
  TaskBloc(
    this.createTaskUseCase,
    this.updateTaskUseCase,
    this.deleteTaskUseCase,
  ) : super(const TaskState.initial()) {
    on<OpenPickerEvent>(_onOpenPicker);
    on<CreateEvent>(_onCreateTask);
    on<UpdateDateEvent>(_onUpdateDate);
    on<UpdatePriorityEvent>(_onUpdatePriority);
    on<UpdateCategoryEvent>(_onUpdateCategory);
    on<UpdateTimeEvent>(_onUpdateTime);
    on<UpdateEvent>(_onUpdateTask);
    on<DeleteEvent>(_onDeleteTask);
    on<UpdateStatusEvent>(_onUpdateStatus);
  }

  /// TaskModel instance
  TaskModel _taskModel = TaskModel(
    title: '',
    description: '',
    priorityId: 0,
    taskDate: DateTime.now(),
    taskTime: TimeOfDay.now(),
    categoryId: 0,
  );

  /// UseCase for creating a new task
  final CreateTaskUseCase createTaskUseCase;

  /// UseCase for updating a task
  final UpdateTaskUseCase updateTaskUseCase;

  /// UseCase for deleting a task
  final DeleteTaskUseCase deleteTaskUseCase;

  void _onOpenPicker(OpenPickerEvent event, Emitter<TaskState> emit) {
    emit(
      TaskState.pickerOpen(event.type, DateTime.now().millisecondsSinceEpoch),
    );
  }

  Future<void> _onCreateTask(
    CreateEvent event,
    Emitter<TaskState> emit,
  ) async {
    _taskModel = _taskModel.copyWith(
      title: event.title,
      description: event.desc,
    );
    await createTaskUseCase.execute(_taskModel);
    emit(const TaskState.taskCreated());
  }

  Future<void> _onUpdateDate(
    UpdateDateEvent event,
    Emitter<TaskState> emit,
  ) async {
    _taskModel = _taskModel.copyWith(taskDate: event.date);
    emit(TaskState.dateUpdated(event.date));
  }

  Future<void> _onUpdatePriority(
    UpdatePriorityEvent event,
    Emitter<TaskState> emit,
  ) async {
    _taskModel = _taskModel.copyWith(priorityId: event.priority);

    emit(TaskState.priorityUpdated(event.priority));
  }

  Future<void> _onUpdateCategory(
    UpdateCategoryEvent event,
    Emitter<TaskState> emit,
  ) async {
    _taskModel = _taskModel.copyWith(categoryId: event.category.id);

    emit(TaskState.categoryUpdated(event.category));
  }

  Future<void> _onUpdateTime(
    UpdateTimeEvent event,
    Emitter<TaskState> emit,
  ) async {
    _taskModel = _taskModel.copyWith(taskTime: event.time);
    emit(TaskState.timeUpdated(event.time));
  }

  Future<void> _onUpdateStatus(
    UpdateStatusEvent event,
    Emitter<TaskState> emit,
  ) async {
    _taskModel = _taskModel.copyWith(status: event.status);

    emit(TaskState.statusUpdated(event.status));
  }

  Future<void> _onUpdateTask(
    UpdateEvent event,
    Emitter<TaskState> emit,
  ) async {
    await updateTaskUseCase.execute(event.taskModel);
    emit(const TaskState.taskUpdated());
  }

  Future<void> _onDeleteTask(
    DeleteEvent event,
    Emitter<TaskState> emit,
  ) async {
    await deleteTaskUseCase.execute(int.parse(event.taskModel.taskId!));
    emit(const TaskState.taskDeleted());
  }
}
