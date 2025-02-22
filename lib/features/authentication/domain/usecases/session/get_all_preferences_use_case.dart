import 'package:injectable/injectable.dart';
import 'package:uptodo/core/utils/use_case.dart';
import 'package:uptodo/features/authentication/data/models/user_prefs_model.dart';
import 'package:uptodo/features/authentication/domain/repositories/preferences_repo.dart';

/// This use case will be used to get all the preferences of the user
@injectable
class GetAllPreferencesUseCase
    extends UseCase<List<UserPreferenceModel>, void> {
  /// Constructor for the [GetAllPreferencesUseCase]
  GetAllPreferencesUseCase(this.preferencesRepo);

  /// [preferencesRepo] is the repository
  final PreferencesRepo preferencesRepo;

  @override
  Future<List<UserPreferenceModel>> run(void params) async {
    return preferencesRepo.getOrSetDefaultPreferences();
  }
}
