import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/core/errors/data_source_error.dart';
import 'package:uptodo/core/storage/objectbox/config/objectbox.g.dart';
import 'package:uptodo/core/storage/objectbox/object_box_repository.dart';
import 'package:uptodo/core/storage/objectbox/objectbox.dart';
import 'package:uptodo/features/authentication/data/models/user_prefs_model.dart';
import 'package:uptodo/features/authentication/domain/entities/user_preference.dart';

/// this is the app_session offline datasource class
@injectable
final class UserPreferenceOfflineDatasource
    extends ObjectBoxRepository<UserPreference> {
  /// Constructor for the app_session offline datasource
  UserPreferenceOfflineDatasource(
    this.objectBox,
  ) : super(objectBox.store, objectBox.getBox<UserPreference>());

  /// object box instance
  final ObjectBox objectBox;

  /// get all user preferences
  Future<Either<DataSourceError, List<UserPreferenceModel>>>
      getUserPreferences() async {
    return Either.tryCatch(
      () {
        final userInfoList = getAllItems();
        final userInfoModels = userInfoList.map((userInfo) {
          return UserPreferenceModel.fromEntity(userInfo);
        }).toList();
        return userInfoModels;
      },
      (e, s) => DataSourceError('Error: $e'),
    );
  }

  /// get a user preference by key
  Future<Either<DataSourceError, UserPreferenceModel>> getUserPreferenceByKey(
    String key,
  ) async {
    return Either.tryCatch(
      () {
        final userInfo =
            queryItem(box.query(UserPreference_.key.equals(key)).build());
        return UserPreferenceModel.fromEntity(userInfo!);
      },
      (e, s) => DataSourceError('Error: $e'),
    );
  }
}
