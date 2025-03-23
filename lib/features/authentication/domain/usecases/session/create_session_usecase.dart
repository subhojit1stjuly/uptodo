import 'package:injectable/injectable.dart';
import 'package:uptodo/core/utils/use_case.dart';
import 'package:uptodo/features/authentication/data/models/user_info_model.dart';
import 'package:uptodo/features/authentication/domain/repositories/session_repo.dart';

/// CreateSessionUsecase is a class that will be creating the session
@injectable
class CreateSessionUsecase extends UseCase<bool, UserInfoModel> {
  /// constructor
  CreateSessionUsecase(this.sessionRepo);

  /// session repo
  final SessionRepo sessionRepo;

  @override
  Future<bool> run(UserInfoModel params) async {
    try {
      final result = await sessionRepo.createSession(params);
      return result;
    } catch (e) {
      return false;
    }
  }
}
