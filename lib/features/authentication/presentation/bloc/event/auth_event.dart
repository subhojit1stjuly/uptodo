import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

/// This is the event class for the SessionBloc
@freezed
class AuthEvent with _$AuthEvent {
  /// event to login with google
  const factory AuthEvent.loginWithGoogle() = LoginWithGoogleEvent;

  /// event to login with phone
  const factory AuthEvent.loginWithPhone() = LoginWithPhoneEvent;

  /// event to login with email
  const factory AuthEvent.loginWithEmail() = LoginWithEmailEvent;

  /// event to login with google
  const factory AuthEvent.registerWithGoogle() = RegisterWithGoogleEvent;

  /// event to register with phone
  const factory AuthEvent.registerWithPhone() = RegisterWithPhoneEvent;

  /// event to register with email
  const factory AuthEvent.registerWithEmail() = RegisterWithEmailEvent;
}
