import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/features/task_details/domain/usecase/create_task_use_case.dart';
import 'package:uptodo/features/task_details/domain/usecase/update_task_use_case.dart';
import 'package:uptodo/features/task_details/presentation/bloc/event/task_event.dart';
import 'package:uptodo/features/task_details/presentation/bloc/state/task_state.dart';

/// TaskBloc handles task-related operations
@injectable
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  /// Initialize TaskBloc with initial state
  TaskBloc(this.createTaskUseCase, this.updateTaskUseCase)
      : super(const TaskState.initial()) {
    on<OpenPickerEvent>(_onOpenPicker);
    on<CreateEvent>(_onCreateTask);
  }

  /// UseCase for creating a new task
  final CreateTaskUseCase createTaskUseCase;

  /// UseCase for updating a task
  final UpdateTaskUseCase updateTaskUseCase;

  void _onOpenPicker(OpenPickerEvent event, Emitter<TaskState> emit) {
    emit(
      TaskState.pickerOpen(event.type, DateTime.now().millisecondsSinceEpoch),
    );
  }

  Future<void> _onCreateTask(CreateEvent event, Emitter<TaskState> emit) async {
    await createTaskUseCase.execute(event.taskModel);
    // Implement task creation logic here
    emit(const TaskState.taskCreated());
  }
}
