import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_session_state.freezed.dart';

/// This is the state class for the SessionBloc
@freezed
class UserSessionState with _$UserSessionState {
  /// this state is emitted when the session is initial
  const factory UserSessionState.initial() = SessionStateInitial;

  /// this state is emitted when the session is valid
  const factory UserSessionState.sessionValid() = SessionValidState;

  /// this state is emitted when the session is invalid
  const factory UserSessionState.sessionInvalid({
    required bool hasSeenOnboarding,
  }) = SessionInvalidState;

  /// this state is emitted when the preferences is changed
  const factory UserSessionState.preferencesChanged({
    required ({ThemeMode themeMode, Locale local}) preferences,
  }) = PreferencesChangedState;
}
