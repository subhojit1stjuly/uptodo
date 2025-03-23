import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/core/utils/theme_mode_extaintion.dart';
import 'package:uptodo/features/authentication/data/datasources/user_preference_datasource.dart';
import 'package:uptodo/features/authentication/data/models/user_prefs_model.dart';
import 'package:uptodo/features/authentication/domain/entities/user_preference.dart';
import 'package:uptodo/features/authentication/domain/repositories/preferences_repo.dart';
import 'package:uptodo/features/settings/domain/enums/language.dart';
import 'package:uptodo/shared/model/user_preference_type.dart';

/// [PreferencesRepoImpl] is a class that implements
/// the [PreferencesRepo] abstract class
@Injectable(as: PreferencesRepo)
class PreferencesRepoImpl implements PreferencesRepo {
  /// Constructor for the [PreferencesRepoImpl]
  const PreferencesRepoImpl(this.datasource);

  /// [UserPreferenceOfflineDatasource] is the datasource
  final UserPreferenceOfflineDatasource datasource;

  @override
  Future<UserPreferenceModel?> getPreferenceByKey(String key) async {
    final prefs = await datasource.getUserPreferenceByKey(key);
    return prefs.fold(
      (failure) => null,
      (preference) => preference,
    );
  }

  @override
  Future<void> setPreference(UserPreferenceModel userPreference) async {
    datasource.updateItem(
      UserPreference(
        key: userPreference.key,
        value: userPreference.value,
        type: userPreference.type,
      ),
    );
  }

  @override
  Future<List<UserPreferenceModel>> getOrSetDefaultPreferences() async {
    final defaultPrefs = [
      UserPreference(
        key: UserPreferenceType.hasSeenOnboarding.key,
        value: 'false',
        type: 'bool',
      ),
      UserPreference(
        key: UserPreferenceType.language.key,
        value: Language.english.code,
        type: 'Locale',
      ),
      UserPreference(
        key: UserPreferenceType.themeMode.key,
        value: ThemeMode.light.value,
        type: 'ThemeMode',
      ),
      UserPreference(
        key: UserPreferenceType.syncEmail.key,
        value: 'false',
        type: 'bool',
      ),
    ];

    final prefs = await datasource.getUserPreferences();
    return prefs.fold(
      (failure) {
        datasource.addItems(defaultPrefs);
        return defaultPrefs.map(UserPreferenceModel.fromEntity).toList();
      },
      (preferences) => preferences,
    );
  }
}
