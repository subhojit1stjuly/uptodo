import 'package:injectable/injectable.dart';
import 'package:uptodo/core/routing/route_constants.dart';
import 'package:uptodo/features/home/domain/entities/nav_item.dart';
import 'package:uptodo/features/home/domain/repositories/i_navigation_repository.dart';

/// NavigationRepositoryImpl
@Injectable(as: INavigationRepository)
class NavigationRepositoryImpl implements INavigationRepository {
  @override
  List<NavItem> getNavigationItems() {
    return [
      const NavItem(
        title: 'Index',
        routePath: RouteConstants.index,
      ),
      const NavItem(
        title: 'Calendar',
        routePath: RouteConstants.calendar,
      ),
      const NavItem(
        title: 'Focus',
        routePath: RouteConstants.focus,
      ),
      const NavItem(
        title: 'Profile',
        routePath: RouteConstants.profile,
      ),
    ];
  }

  @override
  Future<bool> handleLogout() async {
    // Implement logout logic
    return true;
  }
}
