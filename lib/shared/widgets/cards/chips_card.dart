import 'package:flutter/material.dart';

/// ChipsCard widget
class ChipsCard extends StatelessWidget {
  /// ChipsCard constructor
  const ChipsCard({required this.isSelected, required this.text, super.key});

  /// The text to display inside the chip
  final String text;

  /// Whether the chip is selected
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? Theme
            .of(context)
            .primaryColorLight
            : Theme
            .of(context)
            .shadowColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
