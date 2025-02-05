import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_event.freezed.dart';

/// This is the event class for the SessionBloc
@freezed
class SessionEvent with _$SessionEvent {
  /// event to check the session status
  const factory SessionEvent.sessionCheck() = SessionCheckEvent;

  /// event to notify UI that session is expired
  const factory SessionEvent.sessionExpired() = SessionExpiredEvent;
}
