import 'package:injectable/injectable.dart';
import 'package:uptodo/core/utils/use_case.dart';
import 'package:uptodo/features/authentication/data/models/user_prefs_model.dart';
import 'package:uptodo/features/authentication/domain/repositories/preferences_repo.dart';
import 'package:uptodo/shared/model/user_preference_type.dart';

/// This use case will be used to get the preference by type
@injectable
class GetPreferenceByTypeUseCase
    extends UseCase<UserPreferenceModel, UserPreferenceType> {
  /// Constructor for the [GetPreferenceByTypeUseCase]
  GetPreferenceByTypeUseCase(this.preferencesRepo);

  /// [preferencesRepo] is the repository
  final PreferencesRepo preferencesRepo;

  @override
  Future<UserPreferenceModel> run(UserPreferenceType params) async {
    return await preferencesRepo.getPreferenceByKey(params.key) ??
        UserPreferenceModel(key: params.key, type: params.type, value: '');
  }
}
