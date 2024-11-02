import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitialState;
  const factory AuthState.loading() = AuthLoadingState;
  const factory AuthState.authenticated() = AuthenticatedState;
  const factory AuthState.unauthenticated() = UnauthenticatedState;
  const factory AuthState.loginFailure(String error) = LoginFailureState;
  const factory AuthState.signupFailure(String error) = SignupFailureState;
  const factory AuthState.emailInvalid() = EmailInvalidState;
  const factory AuthState.passwordInvalid() = PasswordInvalidState;
  const factory AuthState.formValid() = FormValidState;
  const factory AuthState.passwordResetSuccess() = PasswordResetSuccessState;
  const factory AuthState.passwordResetFailure(String error) = PasswordResetFailureState;
  const factory AuthState.sessionValid() = SessionValidState;
  const factory AuthState.sessionInvalid() = SessionInvalidState;
}
