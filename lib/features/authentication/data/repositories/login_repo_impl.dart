import 'package:injectable/injectable.dart';
import 'package:uptodo/features/authentication/domain/repositories/login_repository.dart';

@Injectable(as: LoginRepository)
class LoginRepoImpl extends LoginRepository {
  @override
  Future<bool> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<bool> loginWithGoogle() {
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<bool> loginWithPhone() {
    // TODO: implement loginWithPhone
    throw UnimplementedError();
  }
}
