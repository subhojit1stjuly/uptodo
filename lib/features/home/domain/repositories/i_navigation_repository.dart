import 'package:uptodo/features/home/domain/entities/nav_item.dart';

/// Repository for navigation items
abstract class INavigationRepository {
  /// Get all navigation items
  List<NavItem> getNavigationItems();

  /// Handle logout
  Future<bool> handleLogout();
}
