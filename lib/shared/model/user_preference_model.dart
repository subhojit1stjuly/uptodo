import 'package:uptodo/features/authentication/domain/entities/user_preference.dart';
import 'package:uptodo/shared/model/user_preference_type.dart';

/// This class represents the UserPreferenceModel
class UserPreferenceModel {
  /// Constructor for the UserPreferenceModel
  UserPreferenceModel({
    required this.key,
    required this.value,
    required this.type,
  });

  /// This method converts the UserPreferenceModel to a UserPreference entity
  factory UserPreferenceModel.fromEntity(UserPreference entity) {
    return UserPreferenceModel(
      key: entity.key,
      value: entity.value,
      type: UserPreferenceTypeExtension.fromString(entity.type),
    );
  }

  /// The key for the preference
  final String key;

  /// The value of the preference stored as a string
  final String value;

  /// The type of the preference (e.g., "ThemeMode", "Language", "syncURL")
  final UserPreferenceType type;

  /// This method converts the UserPreferenceModel to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
      'type': type.value,
    };
  }
}
