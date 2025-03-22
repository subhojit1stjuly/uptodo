import 'package:injectable/injectable.dart';
import 'package:uptodo/features/task_details/data/model/task_model/task_model.dart';
import 'package:uptodo/features/task_details/domain/repositories/task_details_repository.dart';

/// UseCase for watching all tasks and getting real-time updates
@injectable
class WatchTasksChanges {
  /// Constructor
  WatchTasksChanges(this._taskRepository);

  final TaskDetailsRepository _taskRepository;

  /// Returns a stream of all tasks
  /// The stream will emit a new list whenever tasks are added, updated,
  /// or deleted
  Stream<TaskModel> call() {
    return _taskRepository.watchTask();
  }
}
