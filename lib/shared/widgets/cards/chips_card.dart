import 'package:flutter/material.dart';

/// ChipsCard widget
class ChipsCard extends StatelessWidget {
  /// ChipsCard constructor
  const ChipsCard({
    required this.onTap,
    required this.isSelected,
    required this.text,
    super.key,
  });

  /// The text to display inside the chip
  final String text;

  /// Whether the chip is selected
  final bool isSelected;

  /// Callback when the chip is tapped
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColorDark
              : Theme.of(context).shadowColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
