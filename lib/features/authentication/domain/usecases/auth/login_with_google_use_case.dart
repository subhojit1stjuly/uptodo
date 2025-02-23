import 'package:injectable/injectable.dart';
import 'package:uptodo/core/utils/use_case.dart';
import 'package:uptodo/features/authentication/domain/entities/auth_provider.dart';
import 'package:uptodo/features/authentication/domain/repositories/auth_repo.dart';

/// usecase to make the login with google
@injectable
class LoginWithGoogleUseCase extends UseCase<bool, void> {
  /// constructor
  LoginWithGoogleUseCase({required this.authRepo});

  /// authRepo is the repository that will be
  /// used to perform the login operation.
  final AuthRepository authRepo;

  @override
  Future<bool> run(void params) async {
    final result = await authRepo.signInWithProvider(
      AuthProvider.google,
    );
    return result.success;
  }
}
