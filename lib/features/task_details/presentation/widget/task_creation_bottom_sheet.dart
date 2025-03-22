import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uptodo/core/constants/assets.gen.dart';
import 'package:uptodo/core/constants/useful_constants.dart';
import 'package:uptodo/core/di/injector.dart';
import 'package:uptodo/core/localizations/app_localizations.dart';
import 'package:uptodo/features/category/data/model/category_model.dart';
import 'package:uptodo/features/category/presentation/bloc/category_bloc.dart';
import 'package:uptodo/features/category/presentation/bloc/event/category_event.dart';
import 'package:uptodo/features/category/presentation/widget/choose_category_widget.dart';
import 'package:uptodo/features/onboarding/presentation/bloc/event_type.dart';
import 'package:uptodo/features/task_details/presentation/bloc/event/task_event.dart';
import 'package:uptodo/features/task_details/presentation/bloc/state/task_state.dart';
import 'package:uptodo/features/task_details/presentation/bloc/task_bloc.dart';
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
      listenWhen: (previous, current) =>
          previous != current &&
          (current is TaskCreatedState || current is PickerOpenState),
      listener: (context, state) {
        state.maybeWhen(
          taskCreated: () {
            getIt<GoRouter>().pop();
          },
          pickerOpen: (type, _) async {
            switch (type) {
              case TaskPropertyEvents.datePicker:
                // Open date picker
                final date = await DateTimePicker.showDates(
                  context: context,
                );
                if (date != null) {
                  bloc.add(TaskEvent.updateDate(date));
                }
              case TaskPropertyEvents.timePicker:
                final time = await DateTimePicker.showTime(
                  context: context,
                  initialDate: DateTime.now(),
                );
                if (time != null) {
                  bloc.add(TaskEvent.updateTime(time));
                }
              case TaskPropertyEvents.categoryPicker:
                await showDialog<CategoryItem>(
                  context: context,
                  builder: (BuildContext context) {
                    return CommonDialogWidget(
                      child: BlocProvider(
                        create: (context) => getIt<CategoryBloc>()
                          ..add(const CategoryEvent.loadAllCategory()),
                        child: ChooseCategoryWidget(
                          onCategorySelected: (CategoryItem value) {
                            bloc.add(TaskEvent.updateCategory(value));
                          },
                        ),
                      ),
                    );
                  },
                );
              case TaskPropertyEvents.priorityPicker:
                await showDialog<int>(
                  context: context,
                  builder: (BuildContext context) {
                    return CommonDialogWidget(
                      child: PriorityDialog(
                        onPrioritySelected: (int value) {
                          bloc.add(TaskEvent.updatePriority(value));
                        },
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
                      spacing: 4,
                      children: [
                        /// date picker
                        BlocBuilder<TaskBloc, TaskState>(
                          buildWhen: (previous, current) =>
                              previous != current &&
                              current is DateUpdatedState,
                          bloc: bloc,
                          builder: (context, state) {
                            return AnimatedValueButton<DateTime>(
                              value: state.maybeWhen(
                                dateUpdated: (date) => date,
                                orElse: () => null,
                              ),
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
                                bloc.add(
                                  const TaskEvent.openPicker(
                                    TaskPropertyEvents.datePicker,
                                  ),
                                );
                              },
                            );
                          },
                        ),

                        /// timepicker
                        BlocBuilder<TaskBloc, TaskState>(
                          buildWhen: (previous, current) =>
                              previous != current &&
                              current is TimeUpdatedState,
                          bloc: bloc,
                          builder: (context, state) {
                            return AnimatedValueButton<TimeOfDay>(
                              value: state.maybeWhen(
                                timeUpdated: (time) => time,
                                orElse: () => null,
                              ),
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
                                bloc.add(
                                  const TaskEvent.openPicker(
                                    TaskPropertyEvents.timePicker,
                                  ),
                                );
                              },
                            );
                          },
                        ),

                        /// category picker
                        BlocBuilder<TaskBloc, TaskState>(
                          bloc: bloc,
                          buildWhen: (previous, current) =>
                              previous != current &&
                              current is CategoryUpdatedState,
                          builder: (context, state) {
                            return AnimatedValueButton<CategoryItem>(
                              value: state.maybeWhen(
                                categoryUpdated: (category) => category,
                                orElse: () => null,
                              ),
                              icon: Assets.icons.tag.svg(
                                height: 24,
                                width: 24,
                              ),
                              formatter: (category) => '${category?.name}',
                              onTap: () {
                                bloc.add(
                                  const TaskEvent.openPicker(
                                    TaskPropertyEvents.categoryPicker,
                                  ),
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
                              current is PriorityUpdatedState,
                          builder: (context, state) {
                            return AnimatedValueButton<int>(
                              value: state.maybeWhen(
                                priorityUpdated: (priority) => priority,
                                orElse: () => null,
                              ),
                              icon: Assets.icons.flag.svg(
                                height: 24,
                                width: 24,
                              ),
                              formatter: (priority) => '$priority',
                              onTap: () {
                                bloc.add(
                                  const TaskEvent.openPicker(
                                    TaskPropertyEvents.priorityPicker,
                                  ),
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
                      bloc.add(
                        TaskEvent.create(
                          title: _taskNameController.text,
                          desc: _taskDescriptionController.text,
                        ),
                      );
                    },
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
