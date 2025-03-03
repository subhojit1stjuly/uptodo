import 'package:flutter/material.dart';
import 'package:uptodo/core/localizations/app_localizations.dart';

/// A widget to choose a category
class ChooseCategoryWidget extends StatefulWidget {
  /// ChooseCategoryWidget constructor
  const ChooseCategoryWidget({super.key});

  @override
  State<ChooseCategoryWidget> createState() => _ChooseCategoryWidgetState();
}

class _ChooseCategoryWidgetState extends State<ChooseCategoryWidget> {
  int? _selectedCategoryIndex;

  // Mock categories - replace with your actual data source
  final List<CategoryItem> _categories = [
    CategoryItem(name: 'Work', color: Colors.blue, icon: Icons.work),
    CategoryItem(name: 'Study', color: Colors.green, icon: Icons.school),
    CategoryItem(name: 'Personal', color: Colors.orange, icon: Icons.person),
    CategoryItem(
      name: 'Shopping',
      color: Colors.purple,
      icon: Icons.shopping_cart,
    ),
    CategoryItem(name: 'Health', color: Colors.red, icon: Icons.favorite),
    CategoryItem(
      name: 'Finance',
      color: Colors.indigo,
      icon: Icons.attach_money,
    ),
    CategoryItem(name: 'Home', color: Colors.brown, icon: Icons.home),
    CategoryItem(name: 'Entertainment', color: Colors.pink, icon: Icons.movie),
    CategoryItem(
      name: 'Family',
      color: Colors.teal,
      icon: Icons.family_restroom,
    ),
    CategoryItem(name: 'Other', color: Colors.grey, icon: Icons.more_horiz),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            AppLocalizations.of(context)?.choose_category ?? 'Choose Category',
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
          itemCount: _categories.length + 1,
          // Categories + add button
          itemBuilder: (context, index) {
            if (index < _categories.length) {
              return _buildCategoryItem(index);
            } else {
              return _buildAddCategoryItem();
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
  }

  Widget _buildCategoryItem(int index) {
    final category = _categories[index];
    final isSelected = _selectedCategoryIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedCategoryIndex = index;
        });
        // Report selected category
      },
      child: Container(
        decoration: BoxDecoration(
          color: category.color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
          border:
              isSelected ? Border.all(color: category.color, width: 2) : null,
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

  Widget _buildAddCategoryItem() {
    return InkWell(
      onTap: () {
        // Handle add category item tap
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: Colors.grey,
              size: 32,
            ),
            SizedBox(height: 8),
            Text(
              'Add New',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

/// Category item model
class CategoryItem {
  /// Constructor for CategoryItem
  CategoryItem({
    required this.name,
    required this.color,
    required this.icon,
  });

  /// Category name
  final String name;

  /// Category color
  final Color color;

  /// Category icon
  final IconData icon;
}
