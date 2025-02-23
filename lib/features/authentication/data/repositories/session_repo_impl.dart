import 'package:injectable/injectable.dart';
import 'package:uptodo/features/authentication/data/datasources/app_session_offline_datasource.dart';
import 'package:uptodo/features/authentication/data/models/user_info_model.dart';
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
  Future<void> createSession(UserInfoModel userInfo) {
    // TODO(Subhojit): implement createSession when login is being implemented
    throw UnimplementedError();
  }
}
