import 'package:objectbox/objectbox.dart';

/// UserPreference is a class that represents a
/// user preference stored in the database
@Entity()
class UserInfo {
  /// constructor for the UserPreference class
  UserInfo({
    required this.lastLogin,
    required this.emailVerified,
    required this.pID,
    this.name,
    this.email,
    this.phoneNumber,
    this.id = 0,
    this.avatarUrl = '',
  });

  /// The id of the preference

  int id;
  @Unique()

  /// server ID
  String pID;

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
