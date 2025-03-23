import 'package:injectable/injectable.dart';
import 'package:uptodo/features/authentication/data/datasources/app_session_offline_datasource.dart';
import 'package:uptodo/features/authentication/data/models/user_info_model.dart';
import 'package:uptodo/features/authentication/domain/entities/user_info.dart';
import 'package:uptodo/features/authentication/domain/repositories/session_repo.dart';

/// SessionRepoImpl is the implementation of SessionRepo
@Injectable(as: SessionRepo)
class SessionRepoImpl implements SessionRepo {
  /// constructor for the SessionRepoImpl
  SessionRepoImpl(this.datasource);

  /// the app session offline datasource
  final AppSessionOfflineDatasource datasource;

  @override
  Future<void> clearSession() async {
    datasource.clearAllItems();
  }

  @override
  Future<bool> isSessionValid() async {
    final userInfo = await datasource.getUserInfo();
    return userInfo.fold(
      (l) => false,
      (r) => r.isNotEmpty,
    );
  }

  @override
  Future<bool> createSession(UserInfoModel userInfo) async {
    final result = datasource.addItem(
      UserInfo(
        lastLogin: userInfo.lastLogin,
        emailVerified: userInfo.emailVerified,
        pID: userInfo.id,
        name: userInfo.name,
        email: userInfo.email,
        phoneNumber: userInfo.phoneNumber,
        avatarUrl: userInfo.avatarUrl,
      ),
    );
    return result > 0;
  }
}
