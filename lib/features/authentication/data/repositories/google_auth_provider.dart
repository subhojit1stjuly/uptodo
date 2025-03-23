import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/features/authentication/data/mappers/user_mapper.dart';
import 'package:uptodo/features/authentication/domain/repositories/auth_provider_strategy.dart';
import 'package:uptodo/features/authentication/domain/value_objects/auth_result.dart';

/// Google provider strategy
@injectable
class GoogleAuthenticationProvider implements AuthProviderStrategy {
  /// Google sign in instance
  GoogleAuthenticationProvider(this._userMapper)
      : _googleSignIn = GoogleSignIn(),
        _auth = firebase.FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn;
  final firebase.FirebaseAuth _auth;
  final UserMapper _userMapper;

  @override
  Future<AuthResult> signIn(_) async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return AuthResult.failure(message: 'Sign in cancelled');
    }

    final googleAuth = await googleUser.authentication;
    final credential = firebase.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    return AuthResult.success(
      user: _userMapper.toDomain(userCredential.user),
    );
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
