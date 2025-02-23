import 'package:json_annotation/json_annotation.dart';
import 'package:uptodo/features/authentication/domain/entities/user_info.dart';

part 'user_info_model.g.dart';

/// UserInfoModel
@JsonSerializable()
class UserInfoModel {
  /// constructor for the UserInfoModel
  UserInfoModel({
    required this.id,
    this.name,
    this.lastLogin,
    this.email,
    this.phoneNumber,
    this.emailVerified = false,
    this.avatarUrl = '',
  });

  /// This method converts the UserInfoModel to a UserPreference entity
  factory UserInfoModel.fromEntity(UserInfo entity) {
    return UserInfoModel(
      id: entity.pID,
      phoneNumber: entity.phoneNumber,
      emailVerified: entity.emailVerified,
      name: entity.name,
      email: entity.email,
      lastLogin: entity.lastLogin,
      avatarUrl: entity.avatarUrl,
    );
  }

  /// This method converts the JSON object to a UserInfoModel
  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);

  /// This method converts the UserInfoModel to a JSON object
  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);

  /// The id of the user
  final String id;

  /// The name of user
  final String? name;

  /// The email of the user
  final String? email;

  /// last login
  final String? lastLogin;

  /// phone number
  final String? phoneNumber;

  /// is email verified
  final bool emailVerified;

  /// avatar url
  final String avatarUrl;
}
