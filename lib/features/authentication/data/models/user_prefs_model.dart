import 'package:json_annotation/json_annotation.dart';
import 'package:uptodo/features/authentication/domain/entities/user_preference.dart';

part 'user_prefs_model.g.dart';

///`UserPreferenceModel`
@JsonSerializable()
class UserPreferenceModel {
  /// constructor for the UserPreferenceModel
  UserPreferenceModel({
    required this.key,
    required this.value,
    required this.type,
    this.id = 0,
  });

  /// This method converts the UserPreferenceModel to a UserPreference entity
  factory UserPreferenceModel.fromEntity(UserPreference entity) {
    return UserPreferenceModel(
      key: entity.key,
      value: entity.value,
      type: entity.type,
      id: entity.id ?? 0,
    );
  }

  /// This method converts the JSON object to a UserPreferenceModel
  factory UserPreferenceModel.fromJson(Map<String, dynamic> json) =>
      _$UserPreferenceModelFromJson(json);

  /// This method converts the UserPreferenceModel to a JSON object
  Map<String, dynamic> toJson() => _$UserPreferenceModelToJson(this);

  /// The id of the user preference
  final int id;

  /// The key of the user preference
  final String key;

  /// The value of the user preference
  final String value;

  /// The type of the user preference
  final String type;
}
