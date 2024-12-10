import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_event.freezed.dart';

@freezed
class SessionEvent with _$SessionEvent {
/*  const factory SessionEvent.emailChanged(String email) = EmailChangedEvent;
  const factory SessionEvent.passwordChanged(String password) = PasswordChangedEvent;
  const factory SessionEvent.loginSubmitted() = LoginSubmittedEvent;
  const factory SessionEvent.signupSubmitted() = SignupSubmittedEvent;
  const factory SessionEvent.loginWithGoogle() = LoginWithGoogleEvent;
  const factory SessionEvent.loginWithFacebook() = LoginWithFacebookEvent;
  const factory SessionEvent.loginWithApple() = LoginWithAppleEvent;
  const factory SessionEvent.logoutRequested() = LogoutRequestedEvent;
  const factory SessionEvent.resetPasswordRequested() = ResetPasswordRequestedEvent;*/
  const factory SessionEvent.sessionCheck() = SessionCheckEvent;
  const factory SessionEvent.sessionExpired() = SessionExpiredEvent;
}
