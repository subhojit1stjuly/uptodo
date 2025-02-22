import 'package:injectable/injectable.dart';
import 'package:uptodo/core/utils/use_case.dart';
import 'package:uptodo/features/authentication/domain/repositories/login_repository.dart';

@injectable
class LoginWithPhone extends UseCase<bool, void> {
  final LoginRepository loginRepository;

  LoginWithPhone({required this.loginRepository});

  @override
  Future<bool> run(void params) async {
    return loginRepository.loginWithPhone();
  }
}
