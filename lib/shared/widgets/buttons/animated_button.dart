import 'package:flutter/material.dart';
import 'package:uptodo/shared/widgets/texts/marquee_text_widget.dart';

/// An animated button that can optionally display a value alongside an icon.
///
/// This widget provides a clickable button that animates between two states:
/// 1. Icon-only state when [value] is null
/// 2. Icon with text state when [value] is provided
///
/// The transition between these states is automatically animated when the
/// [value] property changes.
class AnimatedValueButton<T> extends StatefulWidget {
  /// Creates an animated button with optional value display.
  ///
  /// The [icon] and [onTap] parameters are required.
  /// When [value] is provided, it will be displayed next to the icon.
  /// The [formatter] can be used to customize how the value
  /// is displayed as text.
  const AnimatedValueButton({
    required this.icon,
    required this.onTap,
    super.key,
    this.value,
    this.formatter,
    this.backgroundColor,
    this.itemWidth,
  });

  /// The value to display alongside the icon.
  ///
  /// When null, only the icon is shown.
  /// When non-null, both icon and formatted value text are shown.
  final T? value;

  /// The icon widget to display in the button.
  final Widget icon;

  /// Optional formatter function to convert the value to a displayable string.
  ///
  /// If not provided, [toString] will be called on the value.
  final String Function(T? value)? formatter;

  /// Callback function invoked when the button is tapped.
  final VoidCallback onTap;

  /// Optional background color for the button.
  ///
  /// If not specified, a semi-transparent version of the theme's
  /// surfaceContainerHighest color will be used.
  final Color? backgroundColor;

  /// The width of the button item.
  final double? itemWidth;

  @override
  State<AnimatedValueButton<T>> createState() => _AnimatedValueButtonState<T>();
}

/// The state class for the AnimatedValueButton.
///
/// Manages animations for transitioning between value states.
class _AnimatedValueButtonState<T> extends State<AnimatedValueButton<T>>
    with SingleTickerProviderStateMixin {
  /// Animation controller to manage the state transition animations.
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize animation controller for handling transitions
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    // Set initial controller value based on widget state
    if (widget.value != null) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(AnimatedValueButton<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update animation controller when value changes
    if (oldWidget.value == null && widget.value != null) {
      _controller.forward();
    } else if (oldWidget.value != null && widget.value == null) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build the button UI with appropriate animations based on value state
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 40,
        padding: EdgeInsets.symmetric(
          horizontal: widget.value != null ? 4 : 10,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: widget.value != null
              ? Theme.of(context).colorScheme.surfaceContainerLow
              : widget.backgroundColor ??
                  Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest
                      .withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(8),
          border: widget.value != null
              ? Border.all(
                  color: Theme.of(context).primaryColorDark,
                )
              : null,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: widget.value == null
              ? widget.icon
              : Row(
                  spacing: 1,
                  children: [
                    SizedBox(
                      height: 15,
                      width: 15,
                      child: widget.icon,
                    ),
                    if (widget.itemWidth != null)
                      SizedBox(
                        width: widget.itemWidth,
                        child: buildMarqueeText(),
                      )
                    else
                      buildMarqueeText(),
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildMarqueeText() {
    return MarqueeTextAnimate(
      text: widget.formatter != null
          ? widget.formatter!(widget.value as T)
          : widget.value.toString(),
      style: Theme.of(context).textTheme.labelSmall!.copyWith(
            fontWeight: FontWeight.w500,
          ),
    );
  }
}
