import 'package:uptodo/features/authentication/data/models/user_info_model.dart';

/// contract for session repo
abstract class SessionRepo {
  /// this method will be called to check the session from db
  Future<bool> isSessionValid();

  /// this will be used to clear the session
  Future<void> clearSession();

  /// this will be used to create a session
  Future<void> createSession(UserInfoModel userInfo);
}
