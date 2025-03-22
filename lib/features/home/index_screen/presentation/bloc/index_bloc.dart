import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/features/home/index_screen/presentation/bloc/event/index_event.dart';
import 'package:uptodo/features/home/index_screen/presentation/bloc/state/index_state.dart';
import 'package:uptodo/features/task_details/data/model/task_model/task_model.dart';
import 'package:uptodo/features/task_details/domain/usecase/get_all_task_by_date_use_case.dart';
import 'package:uptodo/shared/model/shred_enums.dart';

/// IndexBloc is a class that will be used to
/// manage the state of the index page.
@injectable
class IndexBloc extends Bloc<IndexEvent, IndexState> {
  /// Constructor
  IndexBloc(this._getAllTaskByDateUseCase) : super(const IndexState.initial()) {
    on<LoadTaskSummaryEvent>(_onLoadTaskSummary);
    on<NavigateToTaskDetailsEvent>(_onNavigateToTaskDetails);
    on<ChangeDaysFilterEvent>(_onChangeDaysFilter);
    on<ChangeStatusFilterEvent>(_onChangeStatusFilter);
    on<SearchedEvent>(_onSearched);
    add(const LoadTaskSummaryEvent());
  }

  final GetAllTaskByDateUseCase _getAllTaskByDateUseCase;

  /// List of task models
  final List<TaskModel> taskModels = [];

  Future<void> _onLoadTaskSummary(
    LoadTaskSummaryEvent event,
    Emitter<IndexState> emit,
  ) async {
    emit(const IndexState.loading());
    emit(const IndexState.noSummaryFound());
    // emit(const IndexState.summaryFound());
  }

  Future<void> _onNavigateToTaskDetails(
    NavigateToTaskDetailsEvent event,
    Emitter<IndexState> emit,
  ) async {
    // Implementation will be added later
  }

  Future<void> _onChangeDaysFilter(
    ChangeDaysFilterEvent event,
    Emitter<IndexState> emit,
  ) async {
    emit(const IndexState.loading());
    var date = DateTime.now();
    switch (event.dayFilterType) {
      case DayFilterType.today:
        date = DateTime.now();
      case DayFilterType.tomorrow:
        date = DateTime.now().add(const Duration(days: 1));
      case DayFilterType.yesterday:
        date = DateTime.now().add(const Duration(days: -1));
    }
    final allTask = await _getAllTaskByDateUseCase.execute(date);
    taskModels
      ..clear()
      ..addAll(allTask);
    emit(
      ChangeDaysFilterState(
        taskModels.where((task) => task.status == TaskStatus.pending).toList(),
      ),
    );
    emit(
      ChangedStatusFilterState(
        taskModels
            .where((task) => task.status == TaskStatus.completed)
            .toList(),
      ),
    );
  }

  Future<void> _onChangeStatusFilter(
    ChangeStatusFilterEvent event,
    Emitter<IndexState> emit,
  ) async {
    emit(
      ChangedStatusFilterState(
        taskModels.where((task) => task.status == event.status).toList(),
      ),
    );
  }

  Future<void> _onSearched(
    SearchedEvent event,
    Emitter<IndexState> emit,
  ) async {
    // Implementation will be added later
    // Search tasks by the provided text
  }
}
