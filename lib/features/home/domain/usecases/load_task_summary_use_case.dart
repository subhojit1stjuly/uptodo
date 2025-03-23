import 'package:injectable/injectable.dart';
import 'package:uptodo/core/utils/use_case.dart';
import 'package:uptodo/features/home/domain/repositories/task_details_repository.dart';

/// LoadTaskSummaryUseCase is a class that will be used to
/// get the summary of the task for last three days.
@injectable
class LoadTaskSummaryUseCase extends UseCase<bool, DateTime> {
  /// Constructor
  LoadTaskSummaryUseCase(this._taskDetailsRepository);

  /// TaskDetailsRepository
  final TaskDetailsRepository _taskDetailsRepository;

  @override
  Future<bool> run(DateTime params) async {
    return _taskDetailsRepository.loadTaskSummary(params);
  }
}
