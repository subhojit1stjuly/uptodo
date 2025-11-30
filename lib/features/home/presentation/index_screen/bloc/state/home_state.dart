import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uptodo/features/task_details/data/model/task_model/task_model.dart';

part 'home_state.freezed.dart';

/// HomeState
@freezed
class HomeState with _$HomeState {
  /// Initial loading state
  const factory HomeState.initial() = initiaHomeState;

  /// State when task dialog is open
  const factory HomeState.openTaskDialog(int time) = OpenTaskDialogState;

  /// Error state
  const factory HomeState.error(String message) = ErrorState;

  /// navigation change state
  const factory HomeState.navigationChange(int index) = NavigationChangeState;

  /// logout state
  const factory HomeState.logout() = LogoutState;

  /// task marked as completed state
  const factory HomeState.taskMarkedAsCompleted(TaskModel task) =
      TaskMarkedAsCompletedState;
}
