import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uptodo/features/task_details/presentation/bloc/event/task_event.dart';
import 'package:uptodo/features/task_details/presentation/bloc/state/task_state.dart';

/// TaskBloc handles task-related operations
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  /// Initialize TaskBloc with initial state
  TaskBloc() : super(const TaskState.initial()) {
    on<OpenPickerEvent>(_onOpenPicker);
    on<CreateEvent>(_onCreateTask);
  }

  void _onOpenPicker(OpenPickerEvent event, Emitter<TaskState> emit) {
    emit(
      TaskState.pickerOpen(event.type, DateTime.now().millisecondsSinceEpoch),
    );
  }

  void _onCreateTask(CreateEvent event, Emitter<TaskState> emit) {
    // Implement task creation logic here
    emit(const TaskState.taskCreated());
  }
}
