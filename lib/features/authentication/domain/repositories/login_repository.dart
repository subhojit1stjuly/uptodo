/// login repository interface
abstract class LoginRepository {
  /// login with email and password
  Future<bool> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// log in with google
  Future<bool> loginWithGoogle();

  /// login with phone number
  Future<bool> loginWithPhone();
}
