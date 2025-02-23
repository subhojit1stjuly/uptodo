import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:injectable/injectable.dart';
import 'package:uptodo/features/authentication/data/models/user_info_model.dart';

@injectable
class UserMapper {
  /// Maps a Firebase User to our domain UserInfoModel
  /// Returns null if the Firebase User is null
  UserInfoModel? toDomain(firebase.User? user) {
    if (user == null) return null;

    return UserInfoModel(
      id: user.uid,
      email: user.email,
      name: user.displayName,
      phoneNumber: user.phoneNumber,
      avatarUrl: user.photoURL ?? '',
      emailVerified: user.emailVerified,
      // Add any additional fields you need to map
    );
  }
}
