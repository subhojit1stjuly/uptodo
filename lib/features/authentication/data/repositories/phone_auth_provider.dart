import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:injectable/injectable.dart';
import 'package:uptodo/features/authentication/data/mappers/user_mapper.dart';
import 'package:uptodo/features/authentication/data/models/auth_error_handler%20.dart';
import 'package:uptodo/features/authentication/domain/repositories/auth_provider_strategy.dart';
import 'package:uptodo/features/authentication/domain/value_objects/auth_result.dart';

/// Repository for phone number authentication
@injectable
class PhoneAuthenticationProvider implements AuthProviderStrategy {
  /// Constructor
  PhoneAuthenticationProvider(
    this._errorHandler,
    this._userMapper,
  ) : _firebaseAuth = firebase.FirebaseAuth.instance;
  final firebase.FirebaseAuth _firebaseAuth;
  final AuthErrorHandler _errorHandler;
  final UserMapper _userMapper;

  @override
  Future<AuthResult> signIn(Map<String, String> credentials) async {
    try {
      final result = await _initiatePhoneAuth(
        phoneNumber: credentials['phoneNumber'] ?? '',
        onCodeSent: (String verificationCode) {},
      );
      return result;
    } on firebase.FirebaseAuthException catch (error) {
      return _errorHandler.handleError(error);
    }
  }

  /// Initiate phone number authentication
  Future<AuthResult> _initiatePhoneAuth({
    required String phoneNumber,
    required void Function(String verificationCode) onCodeSent,
  }) async {
    try {
      final completer = Completer<AuthResult>();

      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (firebase.PhoneAuthCredential credential) async {
          try {
            final userCredential =
                await _firebaseAuth.signInWithCredential(credential);
            completer.complete(
              AuthResult.success(
                user: _userMapper.toDomain(userCredential.user),
              ),
            );
          } catch (e) {
            completer.complete(
              _errorHandler.handleError(e as firebase.FirebaseAuthException),
            );
          }
        },
        verificationFailed: (firebase.FirebaseAuthException e) {
          completer.complete(_errorHandler.handleError(e));
        },
        codeSent: (String verificationId, int? resendToken) {
          onCodeSent(verificationId);
          if (!completer.isCompleted) {
            completer.complete(const AuthResult(success: true));
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          if (!completer.isCompleted) {
            completer.complete(
              AuthResult.failure(
                message: 'Phone number verification timed out',
              ),
            );
          }
        },
      );

      return await completer.future;
    } on firebase.FirebaseAuthException catch (error) {
      return _errorHandler.handleError(error);
    }
  }

  /// Complete phone number authentication
  Future<AuthResult> _completePhoneAuth({
    required String verificationId,
    required String code,
  }) async {
    try {
      final credential = firebase.PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: code,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return AuthResult.success(
        user: _userMapper.toDomain(userCredential.user),
      );
    } on firebase.FirebaseAuthException catch (error) {
      return _errorHandler.handleError(error);
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
