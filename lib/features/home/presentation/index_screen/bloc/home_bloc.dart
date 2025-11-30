import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/features/home/domain/entities/nav_item.dart';
import 'package:uptodo/features/home/domain/usecases/get_navigation_items.dart';
import 'package:uptodo/features/home/domain/usecases/handle_logout.dart';
import 'package:uptodo/features/home/presentation/index_screen/bloc/event/home_event.dart';
import 'package:uptodo/features/home/presentation/index_screen/bloc/state/home_state.dart';
import 'package:uptodo/features/task_details/domain/usecase/update_task_use_case.dart';

/// HomeBloc
@lazySingleton
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  /// HomeBloc constructor
  HomeBloc(
    this._handleLogout,
    this._router,
    this._getNavigationItems,
    this.updateTaskUseCase,
  ) : super(const HomeState.initial()) {
    on<OpenTaskCreateDialogEvent>(_onOpenTaskCreateDialog);
    on<SetIndexEvent>(_onChangeNavigationIndex);
    on<LogoutEvent>(_onLogout);
    _loadNavigationItems();
    on<MarkTaskAsCompletedEvent>(_onMarkTaskAsCompleted);
  }

  /// Navigation items
  List<NavItem> _navigationItems = [];

  /// UseCase for updating a task
  final UpdateTaskUseCase updateTaskUseCase;

  /// Getter for navigation items
  List<NavItem> get navigationItems => _navigationItems;
  final GoRouter _router;
  final HandleLogout _handleLogout;
  final GetNavigationItems _getNavigationItems;

  Future<void> _loadNavigationItems() async {
    final items = await _getNavigationItems.execute(null);
    _navigationItems = items;
    add(const HomeEvent.setIndex(0));
  }

  FutureOr<void> _onOpenTaskCreateDialog(
    OpenTaskCreateDialogEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeState.openTaskDialog(DateTime.now().millisecondsSinceEpoch));
  }

  FutureOr<void> _onChangeNavigationIndex(
    SetIndexEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeState.navigationChange(event.index));
    _router.refresh();
  }

  FutureOr<void> _onLogout(
    LogoutEvent event,
    Emitter<HomeState> emit,
  ) async {
    final result = await _handleLogout.execute(null);
    if (result) {
      emit(const HomeState.logout());
      _router.refresh();
    }
  }

  FutureOr<void> _onMarkTaskAsCompleted(
    MarkTaskAsCompletedEvent event,
    Emitter<HomeState> emit,
  ) async {
    await updateTaskUseCase.execute(
      event.task,
    );
    emit(HomeState.taskMarkedAsCompleted(event.task));
  }
}
