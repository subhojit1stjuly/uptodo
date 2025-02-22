import 'package:injectable/injectable.dart';
import 'package:uptodo/core/utils/use_case.dart';
import 'package:uptodo/features/authentication/domain/repositories/login_repository.dart';

@injectable
class LogInWithEmailUseCase extends UseCase<
    void,
    (
      String email,
      String password,
    )> {
  final LoginRepository loginRepository;

  LogInWithEmailUseCase(this.loginRepository);

  @override
  Future<void> run((String, String) params) async {
    final (String email, String password) = params;
    await loginRepository.loginWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
