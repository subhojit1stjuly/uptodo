import 'package:objectbox/objectbox.dart';

/// UserPreference is a class that represents a
/// user preference stored in the database
@Entity()
class UserPreference {
  /// constructor for the UserPreference class
  UserPreference({
    required this.key,
    required this.value,
    required this.type,
    this.id = 0,
  });

  /// The id of the preference
  int id;

  @Unique()

  /// The key for the preference
  String key;

  /// The value of the preference stored as a string
  String value;

  /// The type of the preference (e.g., "String", "int", "bool")
  String type;
}
