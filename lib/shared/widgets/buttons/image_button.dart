import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// ImageButton
class ImageButton extends StatefulWidget {
  /// ImageButton constructor
  const ImageButton({
    required this.icon,
    required this.onTap,
    super.key,
  });

  /// icon
  final SvgPicture icon;

  /// on tap
  final void Function() onTap;

  @override
  State<ImageButton> createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: widget.icon,
    );
  }
}
