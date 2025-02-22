import 'package:injectable/injectable.dart';
import 'package:uptodo/core/utils/use_case.dart';
import 'package:uptodo/features/authentication/domain/repositories/sign_up_repository.dart';

@injectable
class RegisterWithGoogleUseCase extends UseCase<bool, void> {
  final SignUpRepository signUpRepository;

  RegisterWithGoogleUseCase({required this.signUpRepository});

  @override
  Future<bool> run(void params) async {
    return signUpRepository.registerWithGoogle();
  }
}
