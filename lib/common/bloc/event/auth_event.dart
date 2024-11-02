import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.emailChanged(String email) = EmailChangedEvent;
  const factory AuthEvent.passwordChanged(String password) = PasswordChangedEvent;
  const factory AuthEvent.loginSubmitted() = LoginSubmittedEvent;
  const factory AuthEvent.signupSubmitted() = SignupSubmittedEvent;
  const factory AuthEvent.loginWithGoogle() = LoginWithGoogleEvent;
  const factory AuthEvent.loginWithFacebook() = LoginWithFacebookEvent;
  const factory AuthEvent.loginWithApple() = LoginWithAppleEvent;
  const factory AuthEvent.logoutRequested() = LogoutRequestedEvent;
  const factory AuthEvent.resetPasswordRequested() = ResetPasswordRequestedEvent;
  const factory AuthEvent.sessionCheck() = SessionCheckEvent;
  const factory AuthEvent.sessionExpired() = SessionExpiredEvent;
}
