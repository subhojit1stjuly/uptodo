import 'package:injectable/injectable.dart';
import 'package:uptodo/features/authentication/data/repositories/google_auth_provider.dart';
import 'package:uptodo/features/authentication/data/repositories/phone_auth_provider.dart';
import 'package:uptodo/features/authentication/domain/entities/auth_provider.dart';
import 'package:uptodo/features/authentication/domain/value_objects/auth_result.dart';

/// Base interface for authentication provider strategies
abstract class AuthProviderStrategy {
  /// Sign in with provider account
  Future<AuthResult> signIn(Map<String, String> credentials);

  /// Sign out from provider account
  Future<void> signOut();
}

/// Injectable class to manage authentication providers

@injectable
class AuthProviderManager {
  /// Constructor
  AuthProviderManager(
    GoogleAuthenticationProvider googleAuthProvider,
    PhoneAuthenticationProvider phoneAuthProvider,
  ) : providers = {
          AuthProvider.google: googleAuthProvider,
          AuthProvider.phone: phoneAuthProvider,
          // Add other providers here
        };

  /// Map of providers and their strategies
  final Map<AuthProvider, AuthProviderStrategy> providers;

  /// Get the strategy for a specific provider
  AuthProviderStrategy? getProviderStrategy(AuthProvider provider) {
    return providers[provider];
  }
}
