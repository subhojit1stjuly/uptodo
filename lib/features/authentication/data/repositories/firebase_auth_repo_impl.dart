import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:injectable/injectable.dart';
import 'package:uptodo/features/authentication/data/mappers/user_mapper.dart';
import 'package:uptodo/features/authentication/data/models/auth_error_handler%20.dart';
import 'package:uptodo/features/authentication/data/models/user_info_model.dart';
import 'package:uptodo/features/authentication/domain/entities/auth_provider.dart';
import 'package:uptodo/features/authentication/domain/repositories/auth_provider_strategy.dart';
import 'package:uptodo/features/authentication/domain/repositories/auth_repo.dart';
import 'package:uptodo/features/authentication/domain/value_objects/auth_result.dart';

/// FirebaseAuthRepository implements IBaseAuthRepository {
@Injectable(as: AuthRepository)
class FirebaseAuthRepository implements AuthRepository {
  /// FirebaseAuthRepository implements IBaseAuthRepository {
  FirebaseAuthRepository({
    required AuthProviderManager manager,
    required AuthErrorHandler errorHandler,
    required UserMapper userMapper,
  })  : _auth = firebase.FirebaseAuth.instance,
        _manager = manager,
        _errorHandler = errorHandler,
        _userMapper = userMapper;

  final firebase.FirebaseAuth _auth;
  final AuthProviderManager _manager;
  final AuthErrorHandler _errorHandler;
  final UserMapper _userMapper;

  @override
  Stream<UserInfoModel?> get authStateChanges =>
      _auth.authStateChanges().map(_userMapper.toDomain);

  @override
  Future<AuthResult> createAccountWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return AuthResult.success(
        user: _userMapper.toDomain(userCredential.user),
      );
    } on firebase.FirebaseAuthException catch (error) {
      return _errorHandler.handleError(error);
    }
  }

  @override
  Future<AuthResult> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return AuthResult.success(
        user: _userMapper.toDomain(userCredential.user),
      );
    } on firebase.FirebaseAuthException catch (error) {
      return _errorHandler.handleError(error);
    }
  }

  @override
  Future<AuthResult> signInWithProvider(AuthProvider provider) async {
    try {
      final providerStrategy = _manager.providers[provider];
      if (providerStrategy == null) {
        return AuthResult.failure(
          message: 'Unsupported provider: ${provider.name}',
        );
      }
      return await providerStrategy.signIn({});
    } on firebase.FirebaseAuthException catch (error) {
      return _errorHandler.handleError(error);
    }
  }

  @override
  Future<AuthResult> signOut() async {
    try {
      // Sign out from all providers
      for (final provider in _manager.providers.values) {
        await provider.signOut();
      }
      await _auth.signOut();
      return const AuthResult(success: true);
    } on firebase.FirebaseAuthException catch (error) {
      return _errorHandler.handleError(error);
    }
  }

  @override
  UserInfoModel? getCurrentUser() {
    return _userMapper.toDomain(_auth.currentUser);
  }

  @override
  bool get isAuthenticated => _auth.currentUser != null;
}
