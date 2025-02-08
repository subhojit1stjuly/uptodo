import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_session_event.freezed.dart';

/// This is the event class for the SessionBloc
@freezed
class UserSessionEvent with _$UserSessionEvent {
  /// event to load userPreferences
  const factory UserSessionEvent.loadUserPreferences() =
      LoadUserPreferencesEvent;

  /// event to check the session status
  const factory UserSessionEvent.sessionCheck() = SessionCheckEvent;

  /// event to notify UI that session is expired
  const factory UserSessionEvent.sessionExpired() = SessionExpiredEvent;

  /// event to notify UI that language has been changed
  const factory UserSessionEvent.localChanges({required Locale local}) =
      LocalChangesEvent;
}
