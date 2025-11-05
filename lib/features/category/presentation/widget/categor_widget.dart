import 'package:flutter/material.dart';
import 'package:uptodo/features/category/data/model/category_model.dart';
import 'package:uptodo/shared/widgets/texts/marquee_text_widget.dart';

/// CategoryWidget widget
class CategoryWidget extends StatelessWidget {
  /// Constructor for CategoryWidget
  const CategoryWidget({
    super.key,
    this.taskCategory,
    this.doesMarqueeRequired = true,
  });

  /// task category
  final CategoryItem? taskCategory;

  /// Whether the marquee is required
  final bool doesMarqueeRequired;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: taskCategory?.color ?? Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        spacing: 4,
        children: <Widget>[
          Icon(
            taskCategory?.icon ?? Icons.category,
            color: Colors.white,
            size: 16,
          ),
          SizedBox(
            width: doesMarqueeRequired ? 40 : null,
            child: MarqueeTextAnimate(
              text: taskCategory?.name ?? '',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
