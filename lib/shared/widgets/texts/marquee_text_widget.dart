import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// A widget that creates a scrolling marquee effect for text that
/// overflows its container, refactored using flutter_animate.
class MarqueeTextAnimate extends StatefulWidget {
  /// Creates a MarqueeTextAnimate widget.
  const MarqueeTextAnimate({
    required this.text,
    super.key,
    this.style,
    this.scrollAxis = Axis.horizontal,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.blankSpace = 20.0,
    this.velocity = 50.0,
    this.startAfter = const Duration(seconds: 1),
    this.pauseAfterRound = const Duration(seconds: 1),
    this.showFadingOnEdges = true,
    this.fadingEdgeStartFraction = 0.1,
    this.fadingEdgeEndFraction = 0.1,
    this.numberOfRounds,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.maxWidth,
  });

  /// The text to be displayed in the marquee.
  final String text;

  /// The style of the text.
  final TextStyle? style;

  /// The axis along which the text will scroll.
  final Axis scrollAxis;

  /// The alignment of the text along the cross axis.
  final CrossAxisAlignment crossAxisAlignment;

  /// The space between the end of the text and the start of the next round.
  final double blankSpace;

  /// The speed of the scrolling text in pixels per second.
  final double velocity;

  /// The duration to wait before starting the marquee animation.
  final Duration startAfter;

  /// The duration to pause after each round of scrolling.
  final Duration pauseAfterRound;

  /// Whether to show fading effects on the edges of the text.
  final bool showFadingOnEdges;

  /// The fraction of the text width to apply fading at the start.
  final double fadingEdgeStartFraction;

  /// The fraction of the text width to apply fading at the end.
  final double fadingEdgeEndFraction;

  /// The number of rounds to scroll the text.
  final int? numberOfRounds;

  /// The direction of the text.
  final TextDirection? textDirection;

  /// The alignment of the text within its container.
  final TextAlign textAlign;

  /// The maximum width of the container for the text.
  final double? maxWidth;

  @override
  State<MarqueeTextAnimate> createState() => _MarqueeTextAnimateState();
}

class _MarqueeTextAnimateState extends State<MarqueeTextAnimate> {
  double _textWidth = 0;
  double _containerWidth = 0;
  int _completedRounds = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateTextAndContainerWidth();
    });
  }

  void _calculateTextAndContainerWidth() {
    final containerBox = context.findRenderObject() as RenderBox?;
    if (containerBox == null) return;

    _containerWidth = containerBox.size.width;

    final textPainter = TextPainter(
      text: TextSpan(text: widget.text, style: widget.style),
      maxLines: 1,
      textDirection: widget.textDirection ?? TextDirection.ltr,
    )..layout();

    _textWidth = textPainter.width;

    if (_textWidth > _containerWidth && _containerWidth > 0) {
      setState(() {}); // Trigger rebuild for animation setup
    }
  }

  @override
  void didUpdateWidget(MarqueeTextAnimate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text != oldWidget.text ||
        widget.velocity != oldWidget.velocity ||
        widget.style != oldWidget.style) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _calculateTextAndContainerWidth();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_textWidth <= _containerWidth || _textWidth == 0.0) {
      return Text(
        widget.text,
        style: widget.style,
        textAlign: widget.textAlign,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    final scrollDistance = _textWidth + widget.blankSpace;
    final duration = scrollDistance / widget.velocity;

    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: widget.showFadingOnEdges
              ? [
                  Colors.transparent,
                  Colors.white,
                  Colors.white,
                  Colors.transparent,
                ]
              : [Colors.white, Colors.white],
          stops: widget.showFadingOnEdges
              ? [
                  0.0,
                  widget.fadingEdgeStartFraction,
                  1.0 - widget.fadingEdgeEndFraction,
                  1.0,
                ]
              : [0.0, 1.0],
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: SingleChildScrollView(
        scrollDirection: widget.scrollAxis,
        physics: const NeverScrollableScrollPhysics(),
        child: Row(
          crossAxisAlignment: widget.crossAxisAlignment,
          children: [
            Text(widget.text, style: widget.style, textAlign: widget.textAlign),
            SizedBox(width: widget.blankSpace),
            Text(widget.text, style: widget.style, textAlign: widget.textAlign),
          ],
        ).animate(
          onPlay: (controller) async {
            await Future<void>.delayed(widget.startAfter);
            while (widget.numberOfRounds == null ||
                _completedRounds < widget.numberOfRounds!) {
              await controller.forward(from: 0);
              await controller.forward().then((_) async {
                _completedRounds++;
                if (widget.numberOfRounds != null &&
                    _completedRounds >= widget.numberOfRounds!) {
                  controller.stop();
                } else {
                  await Future<void>.delayed(widget.pauseAfterRound);
                }
              });
            }
          },
        ).slideX(
          begin: 0,
          end: -1,
          duration: Duration(milliseconds: (duration * 1000 * 2).toInt()),
          curve: Curves.linear,
        ),
      ),
    );
  }
}
