import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// DynamicHyphenWidget is a widget that displays a dynamic number of hyphens
class DynamicHyphenWidget extends StatelessWidget {
  /// const constructor for DynamicHyphenWidget
  const DynamicHyphenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final textWidth = _getTextWidth(context, 'or');
        final hyphenWidth = _getTextWidth(context, '-');
        final hyphenCount =
            ((availableWidth - textWidth) / (2 * hyphenWidth)).floor();
        final hyphens = '-' * hyphenCount;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(hyphens),
            const SizedBox(width: 4),
            Text(
              AppLocalizations.of(context)!.or,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(width: 4),
            Text(hyphens),
          ],
        );
      },
    );
  }

  double _getTextWidth(BuildContext context, String text) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: DefaultTextStyle.of(context).style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size.width;
  }
}
