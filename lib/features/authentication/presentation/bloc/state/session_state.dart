import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_state.freezed.dart';

/// This is the state class for the SessionBloc
@freezed
class SessionState with _$SessionState {
  /// this state is emitted when the session is initial
  const factory SessionState.initial() = SessionStateInitial;

  /// this state is emitted when the session is loading
  const factory SessionState.loading() = SessionLoadingState;

  /// this state is emitted when the session is valid
  const factory SessionState.sessionValid() = SessionValidState;

  /// this state is emitted when the session is invalid
  const factory SessionState.sessionInvalid({required bool hasSeenOnboarding}) =
      SessionInvalidState;
}
