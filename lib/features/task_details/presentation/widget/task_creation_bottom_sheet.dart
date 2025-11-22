import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uptodo/core/constants/assets.gen.dart';
import 'package:uptodo/core/constants/useful_constants.dart';
import 'package:uptodo/core/di/injector.dart';
import 'package:uptodo/core/localizations/app_localizations.dart';
import 'package:uptodo/features/category/data/model/category_model.dart';
import 'package:uptodo/features/category/presentation/bloc/category_bloc.dart';
import 'package:uptodo/features/category/presentation/bloc/event/category_event.dart';
import 'package:uptodo/features/category/presentation/widget/choose_category_widget.dart';
import 'package:uptodo/features/task_details/presentation/bloc/event/task_event.dart';
import 'package:uptodo/features/task_details/presentation/bloc/state/task_state.dart';
import 'package:uptodo/features/task_details/presentation/bloc/task_bloc.dart';
import 'package:uptodo/features/task_details/presentation/validators/task_validators.dart';
import 'package:uptodo/features/task_details/presentation/widget/priority_dialog_widget.dart';
import 'package:uptodo/shared/widgets/buttons/animated_button.dart';
import 'package:uptodo/shared/widgets/buttons/image_button.dart';
import 'package:uptodo/shared/widgets/dialogs/common_dialog_widget.dart';
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
  final _formKey = GlobalKey<FormState>();

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
      listenWhen: (_, current) =>
          current.editingStatus == TaskEditingStatus.created ||
          current.editingStatus == TaskEditingStatus.errored,
      bloc: bloc,
      listener: (context, state) {
        if (state.editingStatus == TaskEditingStatus.created) {
          Navigator.of(context).pop();
        } else if (state.editingStatus == TaskEditingStatus.errored) {
          final snackBar = SnackBar(
            content: Text(state.errorMessage ?? 'An error occurred'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
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
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Form(
            key: _formKey,
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
                  validator: TaskValidators.validateTitle,
                  controller: _taskNameController,
                  autoValidationRequired: true,
                ),
                CustomTextField(
                  hintText: AppLocalizations.of(context)!.description,
                  controller: _taskDescriptionController,
                  validator: TaskValidators.validateDescription,
                  autoValidationRequired: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        spacing: 4,
                        children: [
                          /// date picker
                          BlocBuilder<TaskBloc, TaskState>(
                            buildWhen: (previous, current) =>
                                previous != current &&
                                (previous.taskModel?.taskDate !=
                                    current.taskModel?.taskDate),
                            bloc: bloc,
                            builder: (context, state) {
                              return AnimatedValueButton<DateTime>(
                                value: state.taskModel?.taskDate,
                                icon: Assets.icons.calendar.svg(
                                  height: 24,
                                  width: 24,
                                ),
                                formatter: (date) {
                                  if (date != null) {
                                    return DateFormat(
                                      UsefulConstants.LOCAL_DATE_FORMAT,
                                    ).format(date);
                                  }
                                  return '';
                                },
                                onTap: () {
                                  // Open date picker
                                  DateTimePicker.showDates(
                                    context: context,
                                  ).then((date) {
                                    if (date != null) {
                                      bloc.add(TaskEvent.updateDate(date));
                                    }
                                  });
                                },
                              );
                            },
                          ),

                          /// timepicker
                          BlocBuilder<TaskBloc, TaskState>(
                            buildWhen: (previous, current) =>
                                previous.taskModel?.taskTime !=
                                current.taskModel?.taskTime,
                            bloc: bloc,
                            builder: (context, state) {
                              return AnimatedValueButton<TimeOfDay>(
                                value: state.taskModel?.taskTime,
                                icon: Assets.icons.clock.svg(
                                  height: 24,
                                  width: 24,
                                ),
                                formatter: (time) {
                                  if (time != null) {
                                    final now = DateTime.now();
                                    final dt = DateTime(
                                      now.year,
                                      now.month,
                                      now.day,
                                      time.hour,
                                      time.minute,
                                    );
                                    return DateFormat.jm().format(dt);
                                  }
                                  return '';
                                },
                                onTap: () {
                                  DateTimePicker.showTime(
                                    context: context,
                                    initialDate: DateTime.now(),
                                  ).then((time) {
                                    if (time != null) {
                                      bloc.add(TaskEvent.updateTime(time));
                                    }
                                  });
                                },
                              );
                            },
                          ),

                          /// category picker
                          BlocBuilder<TaskBloc, TaskState>(
                            bloc: bloc,
                            buildWhen: (previous, current) =>
                                previous != current &&
                                previous.taskModel?.category?.id !=
                                    current.taskModel?.category?.id,
                            builder: (context, state) {
                              return AnimatedValueButton<CategoryItem>(
                                itemWidth: 40,
                                value: state.taskModel?.category,
                                icon: Assets.icons.tag.svg(
                                  height: 24,
                                  width: 24,
                                ),
                                formatter: (category) => '${category?.name}',
                                onTap: () {
                                  showGeneralDialog(
                                    context: context,
                                    pageBuilder: (context, _, __) {
                                      return CommonDialogWidget(
                                        child: BlocProvider(
                                          create: (context) =>
                                              getIt<CategoryBloc>()
                                                ..add(
                                                  const CategoryEvent
                                                      .loadAllCategory(),
                                                ),
                                          child: ChooseCategoryWidget(
                                            onCategorySelected:
                                                (CategoryItem value) {
                                              bloc.add(
                                                TaskEvent.updateCategory(value),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    transitionBuilder:
                                        (context, anim1, anim2, child) {
                                      return SlideTransition(
                                        position: Tween(
                                          begin: const Offset(0, 1),
                                          end: Offset.zero,
                                        ).animate(
                                          CurvedAnimation(
                                            parent: anim1,
                                            curve: Curves.easeOutCubic,
                                          ),
                                        ),
                                        child: child,
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),

                          /// priority picker
                          BlocBuilder<TaskBloc, TaskState>(
                            bloc: bloc,
                            buildWhen: (previous, current) =>
                                previous != current &&
                                previous.taskModel?.priorityId !=
                                    current.taskModel?.priorityId,
                            builder: (context, state) {
                              return AnimatedValueButton<int>(
                                value: state.taskModel?.priorityId,
                                icon: Assets.icons.flag.svg(
                                  height: 24,
                                  width: 24,
                                ),
                                formatter: (priority) => '$priority',
                                onTap: () {
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
                                    transitionBuilder:
                                        (context, anim1, anim2, child) {
                                      return SlideTransition(
                                        position: Tween(
                                          begin: const Offset(0, 1),
                                          end: Offset.zero,
                                        ).animate(
                                          CurvedAnimation(
                                            parent: anim1,
                                            curve: Curves.easeOutCubic,
                                          ),
                                        ),
                                        child: child,
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    /// send button
                    ImageButton(
                      icon: Assets.icons.send.svg(
                        height: 24,
                        width: 24,
                      ),
                      onTap: () {
                        final form = _formKey.currentState;
                        if (form != null) {
                          // This will trigger validation and show errors
                          if (form.validate()) {
                            bloc.add(
                              TaskEvent.create(
                                title: _taskNameController.text,
                                desc: _taskDescriptionController.text,
                              ),
                            );
                          } else {
                            // Enable continuous validation after first failure
                            form.save(); // Forces form to update its state
                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
