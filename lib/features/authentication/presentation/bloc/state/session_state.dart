import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_state.freezed.dart';

/// This is the state class for the SessionBloc
@freezed
class SessionState with _$SessionState {
  /// this state is emitted when the session is initial
  const factory SessionState.initial() = SessionStateInitial;

  /// this state is emitted when the session is loading
  const factory SessionState.loading() = SessionLoadingState;

  /*const factory SessionState.authenticated() = AuthenticatedState;
  const factory SessionState.unauthenticated() = UnauthenticatedState;
  const factory SessionState.loginFailure(String error) = LoginFailureState;
  const factory SessionState.signupFailure(String error) = SignupFailureState;
  const factory SessionState.emailInvalid() = EmailInvalidState;
  const factory SessionState.passwordInvalid() = PasswordInvalidState;
  const factory SessionState.formValid() = FormValidState;
  const factory SessionState.passwordResetSuccess() = PasswordResetSuccessState;
  const factory SessionState.passwordResetFailure(String error) = PasswordResetFailureState;*/

  /// this state is emitted when the session is valid
  const factory SessionState.sessionValid() = SessionValidState;

  /// this state is emitted when the session is invalid
  const factory SessionState.sessionInvalid() = SessionInvalidState;
}
