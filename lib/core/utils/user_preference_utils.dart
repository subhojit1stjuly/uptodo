import 'package:uptodo/core/utils/theme_mode_extaintion.dart';
import 'package:uptodo/features/authentication/data/models/user_prefs_model.dart';
import 'package:uptodo/features/settings/domain/enums/language.dart';

/// UserPreferenceUtils
class UserPreferenceUtils {
  /// This method converts the UserPreferenceModel to a dynamic value
  static dynamic getPreferenceValue(UserPreferenceModel preference) {
    switch (preference.type) {
      case 'String':
        return preference.value;
      case 'int':
        return int.tryParse(preference.value);
      case 'bool':
        return preference.value.toLowerCase() == 'true';
      case 'Locale':
        return Language.fromString(preference.value).locale;
      case 'ThemeMode':
        return ThemeModeExtension.fromString(preference.value);
      default:
        return preference.value;
    }
  }

  /// This method converts the dynamic value to a UserPreferenceModel
  static UserPreferenceModel createPreference(String key, dynamic value) {
    String type;
    String stringValue;

    if (value is String) {
      type = 'String';
      stringValue = value;
    } else if (value is int) {
      type = 'int';
      stringValue = value.toString();
    } else if (value is bool) {
      type = 'bool';
      stringValue = value.toString();
    } else if (value is Language) {
      type = 'Locale';
      stringValue = value.code;
    } else {
      throw ArgumentError('Unsupported preference type');
    }

    return UserPreferenceModel(key: key, value: stringValue, type: type);
  }
}
