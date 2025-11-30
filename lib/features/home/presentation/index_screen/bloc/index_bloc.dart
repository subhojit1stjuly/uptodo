import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/features/home/domain/usecases/get_all_task_by_date_use_case.dart';
import 'package:uptodo/features/home/domain/usecases/load_task_summary_use_case.dart';
import 'package:uptodo/features/home/domain/usecases/watch_tasks_changes_use_case.dart';
import 'package:uptodo/features/home/presentation/index_screen/bloc/event/index_event.dart';
import 'package:uptodo/features/home/presentation/index_screen/bloc/state/index_state.dart';
import 'package:uptodo/features/task_details/data/model/task_event_types.dart';
import 'package:uptodo/features/task_details/data/model/task_model/task_model.dart';
import 'package:uptodo/shared/model/shred_enums.dart';

/// IndexBloc is a class that will be used to
/// manage the state of the index page.
@injectable
class IndexBloc extends Bloc<IndexEvent, IndexState> {
  /// Constructor
  IndexBloc(
    this._getAllTaskByDateUseCase,
    this._loadTaskSummaryUseCase,
    this._watchTasksChangesStreamUseCase,
  ) : super(const IndexState.initial()) {
    on<LoadTaskSummaryEvent>(_onLoadTaskSummary);
    on<NavigateToTaskDetailsEvent>(_onNavigateToTaskDetails);
    on<LoadRecentTasksEvent>(_loadRecentTasks);
    on<ChangeDaysFilterEvent>(_onChangeDaysFilter);
    on<ChangeStatusFilterEvent>(_onChangeStatusFilter);
    on<SearchedEvent>(_onSearched);
    on<TaskTableEvent>(_onTaskTableEvent);
    add(const LoadTaskSummaryEvent());

    /// Listen to task changes
    _watchTasksChangesStreamUseCase().listen((TaskTableEvents event) {
      add(TaskTableEvent(event));
    });
  }

  final GetAllTaskByDateUseCase _getAllTaskByDateUseCase;
  final LoadTaskSummaryUseCase _loadTaskSummaryUseCase;
  final WatchTasksChangesStreamUseCase _watchTasksChangesStreamUseCase;

  Future<void> _onTaskTableEvent(
    TaskTableEvent event,
    Emitter<IndexState> emit,
  ) async {
    final currentState = state;
    if (currentState is TasksLoadedState) {
      final task = event.taskEvent.taskModel;
      // Get current date based on filter
      var date = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      );
      switch (currentState.currentDayFilter) {
        case DayFilterType.today:
          date = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          );
        case DayFilterType.tomorrow:
          date = date.add(const Duration(days: 1));
        case DayFilterType.yesterday:
          date = date.add(const Duration(days: -1));
      }
      switch (event.taskEvent.eventType) {
        case TaskTableEventType.created:
          if (task.taskDate.day != date.day ||
              task.taskDate.month != date.month ||
              task.taskDate.year != date.year) {
            return;
          }
          final updatedState = currentState.copyWith(
            pendingTasks: [...currentState.pendingTasks, task],
            completedTasks: currentState.completedTasks,
            currentDayFilter: currentState.currentDayFilter,
            currentStatusFilter: currentState.currentStatusFilter,
          );
          emit(
            IndexState.tasksLoaded(
              pendingTasks: updatedState.pendingTasks,
              completedTasks: updatedState.completedTasks,
              currentDayFilter: updatedState.currentDayFilter,
              currentStatusFilter: updatedState.currentStatusFilter,
            ),
          );
        case TaskTableEventType.updated:
          final pendingTaskIndex = currentState.pendingTasks.indexWhere(
            (element) => element.taskId == task.taskId,
          );
          final updatedPendingTasks =
              List<TaskModel>.from(currentState.pendingTasks);
          final updatedCompletedTasks =
              List<TaskModel>.from(currentState.completedTasks);
          if (pendingTaskIndex != -1) {
            updatedPendingTasks[pendingTaskIndex] = task;
          } else {
            final completedTaskIndex = currentState.completedTasks.indexWhere(
              (element) => element.taskId == task.taskId,
            );
            if (completedTaskIndex != -1) {
              updatedCompletedTasks[completedTaskIndex] = task;
            }
          }
          emit(
            IndexState.tasksLoaded(
              pendingTasks: updatedPendingTasks,
              completedTasks: updatedCompletedTasks,
              currentDayFilter: currentState.currentDayFilter,
              currentStatusFilter: currentState.currentStatusFilter,
            ),
          );
        case TaskTableEventType.deleted:
          final updatedPendingTasks =
              List<TaskModel>.from(currentState.pendingTasks);
          final updatedCompletedTasks =
              List<TaskModel>.from(currentState.completedTasks);
          if (!updatedPendingTasks.remove(task)) {
            updatedCompletedTasks.remove(task);
          }
          final updatedState = currentState.copyWith(
            pendingTasks: updatedPendingTasks,
            completedTasks: updatedCompletedTasks,
            currentDayFilter: currentState.currentDayFilter,
            currentStatusFilter: currentState.currentStatusFilter,
          );
          emit(
            IndexState.tasksLoaded(
              pendingTasks: updatedState.pendingTasks,
              completedTasks: updatedState.completedTasks,
              currentDayFilter: updatedState.currentDayFilter,
              currentStatusFilter: updatedState.currentStatusFilter,
            ),
          );
      }
    } else {
      add(const LoadRecentTasksEvent());
    }
  }

  Future<void> _onLoadTaskSummary(
    LoadTaskSummaryEvent event,
    Emitter<IndexState> emit,
  ) async {
    emit(const IndexState.loading());
    final hasTask = await _loadTaskSummaryUseCase.execute(DateTime.now());
    if (hasTask) {
      add(const IndexEvent.loadRecentTasks());
    } else {
      emit(const IndexState.noSummaryFound());
    }
  }

  Future<void> _loadRecentTasks(
    LoadRecentTasksEvent event,
    Emitter<IndexState> emit,
  ) async {
    final allTask = await _getAllTaskByDateUseCase.execute(
      DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
    );
    emit(const IndexState.summaryFound());
    emit(
      IndexState.tasksLoaded(
        pendingTasks:
            allTask.where((task) => task.status == TaskStatus.pending).toList(),
        completedTasks: allTask
            .where((task) => task.status == TaskStatus.completed)
            .toList(),
        currentDayFilter: DayFilterType.today,
        currentStatusFilter: TaskStatus.pending, // Default selected status
      ),
    );
  }

  Future<void> _onChangeDaysFilter(
    ChangeDaysFilterEvent event,
    Emitter<IndexState> emit,
  ) async {
    emit(const IndexState.loading());
    var date = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    switch (event.dayFilterType) {
      case DayFilterType.today:
        date = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        );
      case DayFilterType.tomorrow:
        date = date.add(const Duration(days: 1));
      case DayFilterType.yesterday:
        date = date.add(const Duration(days: -1));
    }
    final allTask = await _getAllTaskByDateUseCase.execute(date);
    final currentState = state;
    emit(const IndexState.summaryFound());
    emit(
      IndexState.tasksLoaded(
        pendingTasks:
            allTask.where((task) => task.status == TaskStatus.pending).toList(),
        completedTasks: allTask
            .where((task) => task.status == TaskStatus.completed)
            .toList(),
        currentDayFilter: event.dayFilterType,
        currentStatusFilter: currentState is TasksLoadedState
            ? currentState.currentStatusFilter
            : TaskStatus.pending,
      ),
    );
  }

  Future<void> _onChangeStatusFilter(
    ChangeStatusFilterEvent event,
    Emitter<IndexState> emit,
  ) async {
    final currentState = state;
    if (currentState is TasksLoadedState) {
      emit(
        IndexState.tasksLoaded(
          pendingTasks: currentState.pendingTasks,
          completedTasks: currentState.completedTasks,
          currentDayFilter: currentState.currentDayFilter,
          currentStatusFilter: event.status,
        ),
      );
    }
  }

  Future<void> _onSearched(
    SearchedEvent event,
    Emitter<IndexState> emit,
  ) async {
    // Implementation will be added later
    // Search tasks by the provided text
  }

  Future<void> _onNavigateToTaskDetails(
    NavigateToTaskDetailsEvent event,
    Emitter<IndexState> emit,
  ) async {
    // Implementation will be added later
  }
}
