import 'package:injectable/injectable.dart';
import 'package:uptodo/core/utils/use_case.dart';
import 'package:uptodo/features/authentication/domain/repositories/auth_repo.dart';

/// useCase is a class that will be called to login with email/pass
@injectable
class LogInWithEmailUseCase extends UseCase<
    bool,
    ({
      String email,
      String password,
    })> {
  /// constructor
  LogInWithEmailUseCase(this.authRepo);

  /// authRepo is the repository that will be
  /// used to perform the login operation.
  final AuthRepository authRepo;

  @override
  Future<bool> run(({String email, String password}) params) async {
    final result = await authRepo.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
    return result.success;
  }
}
