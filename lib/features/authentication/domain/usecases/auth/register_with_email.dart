import 'package:injectable/injectable.dart';
import 'package:uptodo/core/utils/use_case.dart';
import 'package:uptodo/features/authentication/domain/repositories/auth_repo.dart';

/// useCase is a class that will be called to register with email/pass
@injectable
class RegisterWithEmailUseCase extends UseCase<
    bool,
    ({
      String email,
      String password,
    })> {
  /// constructor
  RegisterWithEmailUseCase(this.authRepo);

  /// authRepo is the repository that will be
  /// used to perform the login operation.
  final AuthRepository authRepo;

  @override
  Future<bool> run(({String email, String password}) params) async {
    final result = await authRepo.createAccountWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
    return result.success;
  }
}
