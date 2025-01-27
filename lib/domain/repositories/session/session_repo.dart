/// contract for session repo
abstract class SessionRepo {
  /// this method will be called to check the session from db
  Future<bool> isSessionValid();

  /// this will be used to clear the session
  Future<void> clearSession();
}
