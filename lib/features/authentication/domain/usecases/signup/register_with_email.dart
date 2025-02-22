import 'package:injectable/injectable.dart';
import 'package:uptodo/core/utils/use_case.dart';
import 'package:uptodo/features/authentication/domain/repositories/sign_up_repository.dart';

@injectable
class RegisterWithEmailUseCase extends UseCase<
    void,
    (
      String email,
      String password,
    )> {
  final SignUpRepository signUpRepository;

  RegisterWithEmailUseCase(this.signUpRepository);

  @override
  Future<void> run((String, String) params) async {
    final (String email, String password) = params;
    await signUpRepository.registerWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
