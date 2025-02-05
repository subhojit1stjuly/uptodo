import 'package:injectable/injectable.dart';
import 'package:uptodo/core/utils/use_case.dart';
import 'package:uptodo/features/authentication/domain/repositories/session_repo.dart';

/// CheckOnboardingStatusUseCase is a class that will be
/// used to check the onboarding status.
@injectable
class CheckOnboardingStatusUseCase extends UseCase<bool, void> {
  /// constructor for the CheckOnboardingStatusUseCase
  CheckOnboardingStatusUseCase(this.sessionRepo);

  /// the session repo
  final SessionRepo sessionRepo;

  @override
  Future<bool> run(void params) async {
    return sessionRepo.isSessionValid();
  }
}
