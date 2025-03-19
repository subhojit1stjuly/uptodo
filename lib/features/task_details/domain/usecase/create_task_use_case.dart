import 'package:injectable/injectable.dart';
import 'package:uptodo/core/utils/use_case.dart';
import 'package:uptodo/features/task_details/data/model/task_model.dart';
import 'package:uptodo/features/task_details/domain/repositories/task_repository.dart';

/// UseCase for creating a new task
@injectable
class CreateTaskUseCase extends UseCase<int, TaskModel> {
  /// constructor
  CreateTaskUseCase(this.taskRepository);

  /// repository that handles task operations
  final TaskRepository taskRepository;

  @override
  Future<int> run(TaskModel params) async {
    return taskRepository.createTask(params);
  }
}
