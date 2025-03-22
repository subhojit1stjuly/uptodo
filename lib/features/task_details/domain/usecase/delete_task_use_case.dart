import 'package:injectable/injectable.dart';
import 'package:uptodo/core/utils/use_case.dart';
import 'package:uptodo/features/task_details/domain/repositories/task_create_update_repository.dart';

/// UseCase for deleting a task
@injectable
class DeleteTaskUseCase extends UseCase<bool, int> {
  /// constructor
  DeleteTaskUseCase(this.taskRepository);

  /// repository that handles task operations
  final TaskCreateUpdateRepository taskRepository;

  @override
  Future<bool> run(int params) async {
    return taskRepository.deleteTask(params);
  }
}