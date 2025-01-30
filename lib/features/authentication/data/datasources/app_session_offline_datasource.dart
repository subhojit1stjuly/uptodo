import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/core/errors/data_source_error.dart';
import 'package:uptodo/core/storage/objectbox/object_box_repository.dart';
import 'package:uptodo/core/storage/objectbox/objectbox.dart';
import 'package:uptodo/features/authentication/data/models/user_info_model.dart';
import 'package:uptodo/features/authentication/domain/entities/user_info.dart';

/// this is the app_session offline datasource class
@injectable
final class AppSessionOfflineDatasource extends ObjectBoxRepository<UserInfo> {
  /// Constructor for the app_session offline datasource
  AppSessionOfflineDatasource(
    ObjectBox objectBox,
  ) : super(objectBox.store, objectBox.getBox<UserInfo>());

  /// get all user preferences
  Future<Either<DataSourceError, List<UserInfoModel>>> getUserInfo() async {
    return Either.tryCatch(
      () {
        final userInfoList = getAllItems();
        final userInfoModels = userInfoList.map((userInfo) {
          return UserInfoModel.fromEntity(userInfo);
        }).toList();
        return userInfoModels;
      },
      (e, s) => DataSourceError('Error: $e'),
    );
  }
}
