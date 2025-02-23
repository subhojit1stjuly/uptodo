import 'package:flutter/material.dart';

/// Custom toast for the entire application
class CustomToast {
  /// static show method
  static void show(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    final overlayState = Overlay.of(context);
    late final OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50,
        width: MediaQuery.of(context).size.width,
        child: ToastMessage(
          message: message,
          isError: isError,
          onDismiss: () {
            overlayEntry.remove();
          },
        ),
      ),
    );

    overlayState.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 2), () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}

/// ToastMessage widget for displaying the toast message
class ToastMessage extends StatelessWidget {
  /// constructor for ToastMessage
  const ToastMessage({
    required this.message,
    required this.isError,
    required this.onDismiss,
    super.key,
  });

  /// message that will be shown
  final String message;

  /// to determine the toast type
  final bool isError;

  /// to execute something when the toast is dismissed
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isError ? Colors.red.shade800 : Colors.green.shade800,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
