import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.emailChanged(String email) = AuthEmailChangedEvent;
  const factory AuthEvent.passwordChanged(String password) = AuthPasswordChangedEvent;
  const factory AuthEvent.loginSubmitted() = AuthLoginSubmittedEvent;
  const factory AuthEvent.signupSubmitted() = AuthSignupSubmittedEvent;
  const factory AuthEvent.loginWithGoogle() = AuthLoginWithGoogleEvent;
  const factory AuthEvent.loginWithFacebook() = AuthLoginWithFacebookEvent;
  const factory AuthEvent.loginWithApple() = AuthLoginWithAppleEvent;
  const factory AuthEvent.logoutRequested() = AuthLogoutRequestedEvent;
  const factory AuthEvent.resetPasswordRequested() = AuthResetPasswordRequestedEvent;
  const factory AuthEvent.sessionCheck() = AuthSessionCheckEvent;
}
