import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/core/di/injector.dart';
import 'package:uptodo/core/localizations/app_localizations.dart';
import 'package:uptodo/features/category/data/model/category_model.dart';
import 'package:uptodo/features/category/presentation/bloc/category_bloc.dart';
import 'package:uptodo/features/category/presentation/bloc/state/category_state.dart';
import 'package:uptodo/features/category/presentation/widget/loading_category_widget.dart';

/// A widget to choose a category
class ChooseCategoryWidget extends StatefulWidget {
  /// ChooseCategoryWidget constructor
  const ChooseCategoryWidget({required this.onCategorySelected, super.key});

  /// Callback when category is selected
  final void Function(CategoryItem value) onCategorySelected;

  @override
  State<ChooseCategoryWidget> createState() => _ChooseCategoryWidgetState();
}

class _ChooseCategoryWidgetState extends State<ChooseCategoryWidget> {
  int? _selectedCategoryIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      bloc: context.read<CategoryBloc>(),
      buildWhen: (previous, current) =>
          current is LoadingState || current is LoadedState,
      builder: (context, state) {
        return state.when(
          loading: () => const Center(child: LoadingCategoryWidget()),
          loaded: (categories) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              spacing: 30,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    AppLocalizations.of(context)!.choose_category,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: categories.length,
                  // Categories + add button
                  itemBuilder: (context, index) {
                    if (index < categories.length) {
                      return _buildCategoryItem(index, categories);
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle create new category button tap
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.create_new_category,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          error: (message) => Center(child: Text(message)),
          empty: () => const Center(child: Text('No categories')),
        );
      },
    );
  }

  Widget _buildCategoryItem(int index, List<CategoryItem> categories) {
    final category = categories[index];
    final isSelected = _selectedCategoryIndex == index;

    return InkWell(
      onTap: () {
        widget.onCategorySelected(category);
        getIt<GoRouter>().pop();
        // Report selected category
      },
      child: Container(
        decoration: BoxDecoration(
          color: category.color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              category.icon,
              color: category.color,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              category.name,
              style: TextStyle(
                color: category.color,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
