import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uptodo/features/home/index_screen/presentation/bloc/event/index_event.dart';
import 'package:uptodo/features/home/index_screen/presentation/bloc/state/index_state.dart';

class IndexBloc extends Bloc<IndexEvent, IndexState> {
  IndexBloc() : super(const IndexState.initial()) {
    on<LoadAllTaskEvent>(_onLoadAllTask);
    on<MarkDoneEvent>(_onMarkDone);
    on<NavigateToTaskDetailsEvent>(_onNavigateToTaskDetails);
    on<ChangeDaysFilterEvent>(_onChangeDaysFilter);
    on<ChangeStatusFilterEvent>(_onChangeStatusFilter);
    on<SearchedEvent>(_onSearched);
  }

  void _onLoadAllTask(LoadAllTaskEvent event, Emitter<IndexState> emit) {
    // Implementation will be added later
    emit(const IndexState.loading());
    // Fetch tasks and emit loaded state
  }

  void _onMarkDone(MarkDoneEvent event, Emitter<IndexState> emit) {
    // Implementation will be added later
  }

  void _onNavigateToTaskDetails(
      NavigateToTaskDetailsEvent event, Emitter<IndexState> emit) {
    // Implementation will be added later
  }

  void _onChangeDaysFilter(
      ChangeDaysFilterEvent event, Emitter<IndexState> emit) {
    // Implementation will be added later
    // After filtering by day, emit ChangeDaysFilterState with filtered tasks
  }

  void _onChangeStatusFilter(
      ChangeStatusFilterEvent event, Emitter<IndexState> emit) {
    // Implementation will be added later
    // After filtering by status, emit ChangedStatusFilterState with filtered tasks
  }

  void _onSearched(SearchedEvent event, Emitter<IndexState> emit) {
    // Implementation will be added later
    // Search tasks by the provided text
  }
}
