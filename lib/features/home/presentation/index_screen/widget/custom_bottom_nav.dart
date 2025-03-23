import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uptodo/core/constants/assets.gen.dart';
import 'package:uptodo/core/localizations/app_localizations.dart';
import 'package:uptodo/features/home/presentation/index_screen/bloc/event/home_event.dart';
import 'package:uptodo/features/home/presentation/index_screen/bloc/home_bloc.dart';

/// A custom bottom navigation bar.
class CustomBottomNavBar extends StatelessWidget {
  /// Creates a custom bottom navigation bar.
  const CustomBottomNavBar({
    required this.selectedIndex,
    required this.onTap,
    super.key,
  });

  /// The index of the selected item.
  final int selectedIndex;

  /// The callback when an item is tapped.
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 65,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _NavBarItem(
                          icon: Assets.icons.home.svg(
                            height: 24,
                            width: 24,
                          ),
                          label: AppLocalizations.of(context)!.index,
                          isSelected: selectedIndex == 0,
                          onTap: () => onTap(0),
                        ),
                        _NavBarItem(
                          icon: Assets.icons.calendar.svg(
                            height: 24,
                            width: 24,
                          ),
                          label: AppLocalizations.of(context)!.calendar,
                          isSelected: selectedIndex == 1,
                          onTap: () => onTap(1),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 70),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _NavBarItem(
                          icon: Assets.icons.clock.svg(
                            height: 24,
                            width: 24,
                          ),
                          label: AppLocalizations.of(context)!.focus,
                          isSelected: selectedIndex == 2,
                          onTap: () => onTap(2),
                        ),
                        _NavBarItem(
                          icon: Assets.icons.user.svg(
                            height: 24,
                            width: 24,
                          ),
                          label: AppLocalizations.of(context)!.profile,
                          isSelected: selectedIndex == 3,
                          onTap: () => onTap(3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () {
                context.read<HomeBloc>().add(
                      const HomeEvent.openTaskCreateDialog(),
                    );
              },
              child: Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColorLight,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withAlpha(1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  size: 28,
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final SvgPicture icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primaryContainer
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
