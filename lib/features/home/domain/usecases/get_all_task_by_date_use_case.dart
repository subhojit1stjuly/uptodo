import 'package:injectable/injectable.dart';
import 'package:uptodo/core/utils/use_case.dart';
import 'package:uptodo/features/home/domain/repositories/task_details_repository.dart';
import 'package:uptodo/features/task_details/data/model/task_model/task_model.dart';

/// UseCase for getting all tasks by date
@injectable
class GetAllTaskByDateUseCase extends UseCase<List<TaskModel>, DateTime> {
  /// Constructor
  GetAllTaskByDateUseCase(this._taskRepository);

  /// TaskDetailsRepository instance
  final TaskDetailsRepository _taskRepository;

  @override
  Future<List<TaskModel>> run(DateTime params) async {
    return _taskRepository.getAllTasksByDate(date: params);
  }
}
