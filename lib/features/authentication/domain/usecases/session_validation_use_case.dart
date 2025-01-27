import 'package:uptodo/core/utils/use_case.dart';
import 'package:uptodo/features/authentication/domain/repositories/session_repo.dart';

/// SessionValidationUseCase is a class that will be
/// used to check the session validation.
class SessionValidationUseCase extends UseCase<bool, void> {
  /// constructor for the SessionValidationUseCase
  SessionValidationUseCase(this.sessionRepo);

  /// the session repo
  final SessionRepo sessionRepo;

  @override
  Future<bool> run(void params) async {
    return await sessionRepo.isSessionValid();
  }
}
