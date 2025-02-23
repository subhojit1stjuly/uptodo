import 'package:uptodo/features/authentication/data/models/user_info_model.dart';
import 'package:uptodo/features/authentication/domain/entities/auth_provider.dart';
import 'package:uptodo/features/authentication/domain/value_objects/auth_result.dart';

/// email based authentication repository
abstract class IEmailAuthRepository {
  /// Sign in with email and password
  Future<AuthResult> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Create account with email and password
  Future<AuthResult> createAccountWithEmailAndPassword({
    required String email,
    required String password,
  });
}

/// this is the base auth repo
abstract class AuthRepository implements IEmailAuthRepository {
  /// we are getting the auth status changes
  Stream<UserInfoModel?> get authStateChanges;

  /// a common signOut method
  Future<AuthResult> signOut();

  /// sign in with provider like google, phone, apple, facebook, etc.
  Future<AuthResult> signInWithProvider(AuthProvider provider);

  /// to get the current user.
  UserInfoModel? getCurrentUser();

  /// status holding the auth status.
  /// true if the user is authenticated, false otherwise.
  bool get isAuthenticated;
}
