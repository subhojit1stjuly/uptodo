import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uptodo/core/di/injector.dart';
import 'package:uptodo/features/category/data/model/category_model.dart';
import 'package:uptodo/features/category/presentation/bloc/category_bloc.dart';
import 'package:uptodo/features/category/presentation/bloc/event/category_event.dart';
import 'package:uptodo/features/category/presentation/widget/choose_category_widget.dart';
import 'package:uptodo/features/task_details/presentation/bloc/event/task_event.dart';
import 'package:uptodo/features/task_details/presentation/bloc/task_bloc.dart';
import 'package:uptodo/features/task_details/presentation/widget/priority_dialog_widget.dart';
import 'package:uptodo/shared/widgets/dialogs/common_dialog_widget.dart';

/// A reusable property picker component that can be used anywhere in the app
class PropertyPicker {
  PropertyPicker._();

  /// Shows category picker dialog
  static void pickCategory({
    required BuildContext context,
    required TaskBloc bloc,
  }) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, _, __) {
        return CommonDialogWidget(
          child: BlocProvider(
            create: (context) => getIt<CategoryBloc>()
              ..add(
                const CategoryEvent.loadAllCategory(),
              ),
            child: ChooseCategoryWidget(
              onCategorySelected: (CategoryItem value) {
                bloc.add(
                  TaskEvent.updateCategory(value),
                );
              },
            ),
          ),
        );
      },
      transitionBuilder: _buildSlideTransition,
    );
  }

  /// Shows priority picker dialog
  static void pickPriority({
    required BuildContext context,
    required TaskBloc bloc,
  }) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, _, __) {
        return CommonDialogWidget(
          child: PriorityDialog(
            onPrioritySelected: (int value) {
              bloc.add(
                TaskEvent.updatePriority(value),
              );
            },
          ),
        );
      },
      transitionBuilder: _buildSlideTransition,
    );
  }

  static SlideTransition _buildSlideTransition(
    BuildContext context,
    Animation<double> primary,
    Animation<double> secondary,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: primary,
          curve: Curves.easeOutCubic,
        ),
      ),
      child: child,
    );
  }
}
