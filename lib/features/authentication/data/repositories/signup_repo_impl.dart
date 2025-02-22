import 'package:injectable/injectable.dart';
import 'package:uptodo/features/authentication/domain/repositories/sign_up_repository.dart';

@Injectable(as: SignUpRepository)
class SignupRepoImpl extends SignUpRepository {
  @override
  Future<bool> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // TODO: implement registerWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<bool> registerWithGoogle() {
    // TODO: implement registerWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<bool> registerWithPhone() {
    // TODO: implement registerWithPhone
    throw UnimplementedError();
  }
}
