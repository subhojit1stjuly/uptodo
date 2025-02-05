import 'package:uptodo/features/authentication/domain/entities/user_info.dart';

/// UserInfoModel
class UserInfoModel {
  /// User Info Model
  UserInfoModel({
    required this.name,
    required this.email,
    required this.lastLogin,
  });

  /// This method converts the UserInfoModel to a UserPreference entity
  factory UserInfoModel.fromEntity(UserInfo entity) {
    return UserInfoModel(
      name: entity.name,
      email: entity.email,
      lastLogin: entity.lastLogin,
    );
  }

  /// The name of user
  String name;

  /// The email of the user
  String email;

  /// last login
  String lastLogin;

  /// This method converts the UserInfoModel to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'lastLogin': lastLogin,
    };
  }
}
