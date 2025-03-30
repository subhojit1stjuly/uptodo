import 'dart:ui';

import 'package:flutter/material.dart';

/// holding the common dialog design for the application
class CommonDialogWidget extends StatelessWidget {
  /// constructor for CommonDialogWidget
  const CommonDialogWidget({required this.child, super.key});

  /// child of the dialog
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      // Adjust blur intensity
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).shadowColor, width: 5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}
