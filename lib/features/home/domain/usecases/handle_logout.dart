import 'package:injectable/injectable.dart';
import 'package:uptodo/core/utils/use_case.dart';
import 'package:uptodo/features/home/domain/repositories/i_navigation_repository.dart';

/// HandleLogout.dart
@injectable
class HandleLogout extends UseCase<bool, void> {
  /// constructor
  HandleLogout(this.repository);

  /// repository
  final INavigationRepository repository;

  @override
  Future<bool> run(_) async {
    return repository.handleLogout();
  }
}
