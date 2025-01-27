import 'package:uptodo/core/offline_datasource/object_box_database/object_box_repository.dart';
import 'package:uptodo/data/entities/user_preference.dart';

/// this is the app_session offline datasource class
class AppSessionOfflineDatasource extends ObjectBoxRepository<UserPreference> {
  AppSessionOfflineDatasource(super.store, super.box);
}
