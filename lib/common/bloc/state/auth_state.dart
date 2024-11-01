import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitialState;
  const factory AuthState.loading() = AuthLoadingState;
  const factory AuthState.authenticated() = AuthAuthenticatedState;
  const factory AuthState.unauthenticated() = AuthUnauthenticatedState;
  const factory AuthState.loginFailure(String error) = AuthLoginFailureState;
  const factory AuthState.signupFailure(String error) = AuthSignupFailureState;
  const factory AuthState.emailInvalid() = AuthEmailInvalidState;
  const factory AuthState.passwordInvalid() = AuthPasswordInvalidState;
  const factory AuthState.formValid() = AuthFormValidState;
  const factory AuthState.passwordResetSuccess() = AuthPasswordResetSuccessState;
  const factory AuthState.passwordResetFailure(String error) = AuthPasswordResetFailureState;
  const factory AuthState.sessionValid() = AuthSessionValidState;
  const factory AuthState.sessionInvalid() = AuthSessionInvalidState;
}
