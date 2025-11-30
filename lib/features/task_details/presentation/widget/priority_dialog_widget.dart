// A reusable Priority Dialog widget that can be shown via showDialog
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/core/constants/assets.gen.dart';
import 'package:uptodo/core/di/injector.dart';
import 'package:uptodo/core/localizations/app_localizations.dart';

/// PriorityDialog
class PriorityDialog extends StatelessWidget {
  /// Constructor for PriorityDialog
  const PriorityDialog({
    required this.onPrioritySelected,
    super.key,
  });

  /// Callback when priority is selected
  final void Function(int value) onPrioritySelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      spacing: 15,
      children: [
        // Header Section
        Text(
          AppLocalizations.of(context)!.task_priority,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        const Divider(),
        // Content Section - Grid View
        SizedBox(
          height: 250, // Adjust height as needed
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // 5x2 grid
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 10, // Total 10 items as requested
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  onPrioritySelected(index + 1);
                  getIt<GoRouter>().pop();
                },
                child: Card(
                  elevation: 3,
                  child: Column(
                    spacing: 4,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.icons.flag.svg(
                        height: 24,
                        width: 24,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).iconTheme.color!,
                          BlendMode.srcIn,
                        ),
                      ),
                      Text(
                        '${index + 1}',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const Divider(),
        // Button Section
        TextButton(
          onPressed: () => getIt<GoRouter>().pop(),
          child: Text(
            AppLocalizations.of(context)!.cancel,
            style: TextTheme.of(context).bodyMedium,
          ),
        ),
      ],
    );
  }
}
