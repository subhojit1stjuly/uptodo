import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.freezed.dart';

/// HomeEvent
@freezed
class HomeEvent with _$HomeEvent {
  /// Event to open task creation dialog
  const factory HomeEvent.openTaskCreateDialog() = OpenTaskCreateDialogEvent;

  /// even to logout
  const factory HomeEvent.logout() = LogoutEvent;

  /// event to set navigation index
  const factory HomeEvent.setIndex(int index) = SetIndexEvent;
}
