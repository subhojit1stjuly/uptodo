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
    @factoryParam TaskModel? initialTaskModel,
  ) : super(
          TaskState(
            taskModel: initialTaskModel ??
                TaskModel(
                  title: '',
                  description: '',
                  priorityId: 1,
                  taskDate: DateTime.now(),
                  taskTime: TimeOfDay.now(),
                  categoryId: 1,
                ),
          ),
        ) {
    on<CreateEvent>(_onCreateTask);
    on<UpdateDateEvent>(_onUpdateDate);
    on<UpdatePriorityEvent>(_onUpdatePriority);
    on<UpdateCategoryEvent>(_onUpdateCategory);
    on<UpdateTimeEvent>(_onUpdateTime);
    on<UpdateEvent>(_onUpdateTask);
    on<DeleteEvent>(_onDeleteTask);
    on<UpdateStatusEvent>(_onUpdateStatus);
    on<UpdateTitleEvent>(_onUpdateTitle);
    on<UpdateDescriptionEvent>(_onUpdateDescription);
  }

  /// UseCase for creating a new task
  final CreateTaskUseCase createTaskUseCase;

  /// UseCase for updating a task
  final UpdateTaskUseCase updateTaskUseCase;

  /// UseCase for deleting a task
  final DeleteTaskUseCase deleteTaskUseCase;

  Future<void> _onCreateTask(
    CreateEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {
      emit(state.copyWith(editingStatus: TaskEditingStatus.loading));
      await createTaskUseCase.execute(
        state.taskModel!.copyWith(
          title: event.title,
          description: event.desc,
        ),
      );
      emit(state.copyWith(editingStatus: TaskEditingStatus.created));
    } catch (e) {
      emit(
        state.copyWith(
          editingStatus: TaskEditingStatus.errored,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onUpdateDate(
    UpdateDateEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(
      state.copyWith(
        taskModel: state.taskModel!.copyWith(taskDate: event.date),
      ),
    );
  }

  Future<void> _onUpdatePriority(
    UpdatePriorityEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(
      state.copyWith(
        taskModel: state.taskModel!.copyWith(priorityId: event.priority),
      ),
    );
  }

  Future<void> _onUpdateCategory(
    UpdateCategoryEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(
      state.copyWith(
        taskModel: state.taskModel!.copyWith(category: event.category),
      ),
    );
  }

  Future<void> _onUpdateTime(
    UpdateTimeEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(
      state.copyWith(
        taskModel: state.taskModel!.copyWith(taskTime: event.time),
      ),
    );
  }

  Future<void> _onUpdateStatus(
    UpdateStatusEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(
      state.copyWith(
        taskModel: state.taskModel!.copyWith(status: event.status),
      ),
    );
  }

  Future<void> _onUpdateTask(
    UpdateEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {
      emit(state.copyWith(editingStatus: TaskEditingStatus.loading));
      await updateTaskUseCase.execute(
        state.taskModel!,
      );
      emit(
        state.copyWith(
          editingStatus: TaskEditingStatus.updated,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          editingStatus: TaskEditingStatus.errored,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onUpdateTitle(
    UpdateTitleEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(
      state.copyWith(
        taskModel: state.taskModel!.copyWith(title: event.title),
      ),
    );
  }

  Future<void> _onUpdateDescription(
    UpdateDescriptionEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(
      state.copyWith(
        taskModel: state.taskModel!.copyWith(description: event.desc),
      ),
    );
  }

  Future<void> _onDeleteTask(
    DeleteEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {
      emit(state.copyWith(editingStatus: TaskEditingStatus.loading));
      await deleteTaskUseCase.execute(int.parse(state.taskModel!.taskId!));
      emit(
        state.copyWith(
          editingStatus: TaskEditingStatus.deleted,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          editingStatus: TaskEditingStatus.errored,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
