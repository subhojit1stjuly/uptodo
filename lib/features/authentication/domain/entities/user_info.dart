import 'package:objectbox/objectbox.dart';

/// UserPreference is a class that represents a
/// user preference stored in the database
@Entity()
class UserInfo {
  /// constructor for the UserPreference class
  UserInfo({
    required this.name,
    required this.email,
    required this.lastLogin,
    this.id = 0,
  });

  /// The id of the preference
  int id;

  @Unique()

  /// The name of user
  String name;

  /// The email of the user
  String email;

  /// last login
  String lastLogin;
}
