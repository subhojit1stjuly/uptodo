import 'package:injectable/injectable.dart';
import 'package:uptodo/features/task_details/data/model/task_model/task_model.dart';
import 'package:uptodo/features/task_details/domain/repositories/task_repository.dart';

/// UseCase for watching all tasks and getting real-time updates
@injectable
class WatchAllTasksUseCase {
  /// Constructor
  WatchAllTasksUseCase(this._taskRepository);

  final TaskRepository _taskRepository;

  /// Returns a stream of all tasks
  /// The stream will emit a new list whenever tasks are added, updated, or deleted
  Stream<List<TaskModel>> call() {
    return _taskRepository.watchAllTasks();
  }

  /// Optional: Add methods for filtered task streams if needed
  /// For example:
  /// Stream<List<TaskModel>> getCompletedTasks() {
  ///   return _taskRepository.watchAllTasks()
  ///     .map((tasks) => tasks.where((task) => task.status == 'completed').toList());
  /// }
}
