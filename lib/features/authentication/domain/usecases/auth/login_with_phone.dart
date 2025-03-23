import 'package:injectable/injectable.dart';
import 'package:uptodo/core/utils/use_case.dart';
import 'package:uptodo/features/authentication/domain/entities/auth_provider.dart';
import 'package:uptodo/features/authentication/domain/repositories/auth_repo.dart';

/// usecase is a class that will be called to login with phone
@injectable
class LoginWithPhone extends UseCase<bool, void> {
  /// constructor
  LoginWithPhone({required this.authRepo});

  /// authRepo is the repository that will be
  /// used to perform the login operation.
  final AuthRepository authRepo;

  @override
  Future<bool> run(void params) async {
    final result = await authRepo.signInWithProvider(AuthProvider.phone);
    return result.success;
  }
}
