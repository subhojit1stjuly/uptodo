/// sign up repo
abstract class SignUpRepository {
  /// register with email and password
  Future<bool> registerWithEmailAndPassword(
      {required String email, required String password});

  /// register with phone
  Future<bool> registerWithPhone();

  /// register with google
  Future<bool> registerWithGoogle();
}
