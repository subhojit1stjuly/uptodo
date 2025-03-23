import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/core/utils/use_case.dart';
import 'package:uptodo/features/authentication/domain/entities/auth_provider.dart';
import 'package:uptodo/features/authentication/domain/repositories/auth_repo.dart';
import 'package:uptodo/features/authentication/domain/usecases/session/create_session_usecase.dart';

/// usecase to make the login with google
@injectable
class LoginWithGoogleUseCase extends UseCase<bool, void> {
  /// constructor
  LoginWithGoogleUseCase({
    required this.authRepo,
    required this.createSessionUseCase,
  });

  /// authRepo is the repository that will be
  /// used to perform the login operation.
  final AuthRepository authRepo;

  /// createSessionUseCase is the repository that will be
  /// used to create the session after the login operation.
  final CreateSessionUsecase createSessionUseCase;

  @override
  Future<bool> run(void params) async {
    try {
      final result = await authRepo.signInWithProvider(
        AuthProvider.google,
      );
      //  save the user to the database
      final isSessionCreated = await createSessionUseCase.execute(result.user!);
      return result.success && isSessionCreated;
    } on Exception catch (_) {
      return false;
    }
  }
}
