import 'package:equatable/equatable.dart';
import 'package:uptodo/features/home/index_screen/domain/entities/nav_item.dart';

/// Navigation state
class NavigationState extends Equatable {
  /// Current selected index of the navigation bar
  const NavigationState({
    required this.selectedIndex,
    required this.items,
    this.isLoading = false,
    this.error,
  });

  /// Current selected index of the navigation bar
  final int selectedIndex;

  /// List of navigation items
  final List<NavItem> items;

  /// Loading state of the navigation bar
  final bool isLoading;

  /// Error state of the navigation bar
  final String? error;

  /// Helper method to find current item
  NavItem get currentItem => items[selectedIndex];

  @override
  List<Object?> get props => [selectedIndex, items, isLoading, error];
}
