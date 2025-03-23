import 'package:injectable/injectable.dart';
import 'package:uptodo/features/home/domain/repositories/task_details_repository.dart';
import 'package:uptodo/features/task_details/data/model/task_event_types.dart';

/// UseCase for watching all tasks and getting real-time updates
@singleton
class WatchTasksChangesStreamUseCase {
  /// Constructor
  WatchTasksChangesStreamUseCase(this._taskRepository);

  final TaskDetailsRepository _taskRepository;

  /// Returns a stream of all tasks
  /// The stream will emit a new list whenever tasks are added, updated,
  /// or deleted
  Stream<TaskTableEvents> call() {
    return _taskRepository.watchTask();
  }
}
