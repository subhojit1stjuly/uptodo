import 'package:uptodo/core/storage/objectbox/object_box_repository.dart';
import 'package:uptodo/features/authentication/domain/entities/user_preference.dart';

/// this is the app_session offline datasource class
class AppSessionOfflineDatasource extends ObjectBoxRepository<UserPreference> {
  AppSessionOfflineDatasource(super.store, super.box);
}
