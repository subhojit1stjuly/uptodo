import 'package:injectable/injectable.dart';
import 'package:uptodo/features/authentication/data/models/user_prefs_model.dart';

/// [PreferencesRepo] is an abstract class that
/// will be used to get and set the
/// theme mode, language, and other preferences\
@factoryMethod
abstract class PreferencesRepo {
  /// This method will be used to set the user preference
  Future<UserPreferenceModel?> getPreferenceByKey(String key);

  /// This method will be used to set the user preference
  Future<void> setPreference(UserPreferenceModel userPreference);

  /// This method will be used to set the user preference
  Future<List<UserPreferenceModel>> getOrSetDefaultPreferences();
}
