import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_error.freezed.dart';

/// Authentication error clas
@freezed
class AuthError with _$AuthError {
  /// when the user is not found
  const factory AuthError.userNotFound() = _UserNotFound;

  /// when password is wrong
  const factory AuthError.wrongPassword() = _WrongPassword;

  /// when email is already in use
  const factory AuthError.emailAlreadyInUse() = _EmailAlreadyInUse;

  /// when email is invalid
  const factory AuthError.invalidEmail() = _InvalidEmail;

  /// when password is too weak
  const factory AuthError.weakPassword() = _WeakPassword;

  /// when user is disabled
  const factory AuthError.userDisabled() = _UserDisabled;

  /// when too many requests are made
  const factory AuthError.tooManyRequests() = _TooManyRequests;

  /// when operation is not allowed
  const factory AuthError.operationNotAllowed() = _OperationNotAllowed;

  /// when network error occurs
  const factory AuthError.networkError() = _NetworkError;

  /// when server error occurs
  const factory AuthError.serverError() = _ServerError;

  /// when unexpected error occurs
  const factory AuthError.unexpected() = _Unexpected;

  /// when custom error occurs
  const factory AuthError.custom(String message) = _Custom;

  const AuthError._();

  /// get the message for the error
  String get message => when(
        userNotFound: () => 'User not found',
        wrongPassword: () => 'Invalid password',
        emailAlreadyInUse: () => 'Email is already in use',
        invalidEmail: () => 'Invalid email address',
        weakPassword: () => 'Password is too weak',
        userDisabled: () => 'This user has been disabled',
        tooManyRequests: () => 'Too many requests. Try again later',
        operationNotAllowed: () => 'Operation not allowed',
        networkError: () => 'Network error occurred',
        serverError: () => 'Server error occurred',
        unexpected: () => 'An unexpected error occurred',
        custom: (message) => message,
      );
}
