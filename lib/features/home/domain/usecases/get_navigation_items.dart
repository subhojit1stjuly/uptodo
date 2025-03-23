import 'package:injectable/injectable.dart';
import 'package:uptodo/core/utils/use_case.dart';
import 'package:uptodo/features/home/domain/entities/nav_item.dart';
import 'package:uptodo/features/home/domain/repositories/i_navigation_repository.dart';

/// GetNavigationItems.dart
@injectable
class GetNavigationItems extends UseCase<List<NavItem>, void> {
  /// Constructor
  GetNavigationItems(this.repository);

  /// Repository dependency
  final INavigationRepository repository;

  @override
  Future<List<NavItem>> run(void params) async {
    try {
      final items = repository.getNavigationItems();
      return items;
    } catch (e) {
      return [];
    }
  }
}
