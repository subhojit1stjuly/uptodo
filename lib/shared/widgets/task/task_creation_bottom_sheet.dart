import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/core/constants/assets.gen.dart';
import 'package:uptodo/core/di/injector.dart';
import 'package:uptodo/core/localizations/app_localizations.dart';
import 'package:uptodo/features/category/presentation/widget/choose_category_widget.dart';
import 'package:uptodo/features/onboarding/presentation/bloc/event_type.dart';
import 'package:uptodo/features/task_details/presentation/bloc/event/task_event.dart';
import 'package:uptodo/features/task_details/presentation/bloc/state/task_state.dart';
import 'package:uptodo/features/task_details/presentation/bloc/task_bloc.dart';
import 'package:uptodo/shared/widgets/buttons/image_button.dart';
import 'package:uptodo/shared/widgets/pickers/date_time_picker.dart';
import 'package:uptodo/shared/widgets/texts/custom_textfield.dart';

/// TaskCreationBottomSheet
class TaskCreationBottomSheet extends StatefulWidget {
  /// TaskCreationBottomSheet constructor
  const TaskCreationBottomSheet({super.key});

  @override
  State<TaskCreationBottomSheet> createState() =>
      _TaskCreationBottomSheetState();
}

class _TaskCreationBottomSheetState extends State<TaskCreationBottomSheet> {
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();

  @override
  void dispose() {
    _taskNameController.dispose();
    _taskDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaskBloc>();
    return BlocListener<TaskBloc, TaskState>(
      bloc: bloc,
      listener: (context, state) {
        state.maybeWhen(
          taskCreated: () {
            getIt<GoRouter>().pop();
          },
          pickerOpen: (type, _) async {
            if (type == TaskPropertyEvents.timePicker) {
              // Open date picker
              await DateTimePicker.show(
                context: context,
                initialDate: DateTime.now(),
              );
            } else if (type == TaskPropertyEvents.categoryPicker) {
              // Open category picker
            } else {
              // Show the category picker dialog
              /// Shows category selection dialog
              await showDialog<CategoryItem>(
                context: context,
                builder: (BuildContext context) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    // Adjust blur intensity
                    child: Dialog(
                      insetPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24,
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: ChooseCategoryWidget(),
                      ),
                    ),
                  );
                },
              );
            }
          },
          orElse: () {},
        );
      },
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).shadowColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            spacing: 25,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.add_task,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              CustomTextField(
                hintText: AppLocalizations.of(context)!.add_task_title,
                controller: _taskNameController,
              ),
              CustomTextField(
                hintText: AppLocalizations.of(context)!.description,
                controller: _taskDescriptionController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      spacing: 25,
                      children: [
                        ImageButton(
                          icon: Assets.icons.clock.svg(
                            height: 24,
                            width: 24,
                          ),
                          onTap: () {
                            bloc.add(
                              const TaskEvent.openPicker(
                                TaskPropertyEvents.timePicker,
                              ),
                            );
                          },
                        ),
                        ImageButton(
                          icon: Assets.icons.tag.svg(
                            height: 24,
                            width: 24,
                          ),
                          onTap: () {
                            bloc.add(
                              const TaskEvent.openPicker(
                                TaskPropertyEvents.priorityPicker,
                              ),
                            );
                          },
                        ),
                        ImageButton(
                          icon: Assets.icons.flag.svg(
                            height: 24,
                            width: 24,
                          ),
                          onTap: () {
                            bloc.add(
                              const TaskEvent.openPicker(
                                TaskPropertyEvents.categoryPicker,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  ImageButton(
                    icon: Assets.icons.send.svg(
                      height: 24,
                      width: 24,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
