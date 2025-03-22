import 'package:injectable/injectable.dart';
import 'package:uptodo/core/utils/use_case.dart';
import 'package:uptodo/features/task_details/data/model/task_model/task_model.dart';
import 'package:uptodo/features/task_details/domain/repositories/task_create_update_repository.dart';

/// UseCase for updating an existing task
@injectable
class UpdateTaskUseCase extends UseCase<bool, TaskModel> {
  /// constructor
  UpdateTaskUseCase(this.taskRepository);

  /// repository that handles task operations
  final TaskCreateUpdateRepository taskRepository;

  @override
  Future<bool> run(TaskModel params) async {
    return taskRepository.updateTask(params);
  }
}
