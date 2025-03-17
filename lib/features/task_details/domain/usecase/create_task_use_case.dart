import 'package:injectable/injectable.dart';
import 'package:uptodo/core/utils/use_case.dart';
import 'package:uptodo/features/task_details/domain/repositories/task_repository.dart';

/// UseCase for creating a new task
@injectable
class CreateTaskUseCase extends UseCase<
    int,
    ({
      String title,
      String? description,
      DateTime? dueDate,
      int? categoryId,
      int? priority,
    })> {
  /// constructor
  CreateTaskUseCase(this.taskRepository);

  /// repository that handles task operations
  final TaskRepository taskRepository;

  @override
  Future<int> run(
      ({
        String title,
        String? description,
        DateTime? dueDate,
        int? categoryId,
        int? priority,
      }) params) async {
    return taskRepository.createTask(
      title: params.title,
      description: params.description,
      dueDate: params.dueDate,
      categoryId: params.categoryId,
      priority: params.priority,
    );
  }
}
