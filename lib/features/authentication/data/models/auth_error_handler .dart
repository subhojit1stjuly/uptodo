import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/features/authentication/domain/entities/auth_error.dart';
import 'package:uptodo/features/authentication/domain/value_objects/auth_result.dart';

/// Auth error handler
@injectable
class AuthErrorHandler {
  /// constructor
  const AuthErrorHandler();

  /// handle error
  AuthResult handleError(Object error) {
    final authError = _mapToAuthError(error);
    return AuthResult(
      success: false,
      error: authError.message,
    );
  }

  AuthError _mapToAuthError(Object error) {
    if (error is! FirebaseAuthException) {
      return const AuthError.unexpected();
    }

    switch (error.code) {
      case 'user-not-found':
        return const AuthError.userNotFound();
      case 'wrong-password':
        return const AuthError.wrongPassword();
      case 'email-already-in-use':
        return const AuthError.emailAlreadyInUse();
      case 'invalid-email':
        return const AuthError.invalidEmail();
      case 'weak-password':
        return const AuthError.weakPassword();
      case 'user-disabled':
        return const AuthError.userDisabled();
      case 'too-many-requests':
        return const AuthError.tooManyRequests();
      case 'operation-not-allowed':
        return const AuthError.operationNotAllowed();
      case 'network-request-failed':
        return const AuthError.networkError();
      case 'internal-error':
        return const AuthError.serverError();
      default:
        return AuthError.custom(error.message ?? 'Unknown error occurred');
    }
  }
}
