/// TaskRepository
abstract class TaskRepository {
  /// create task
  Future<int> createTask({
    required String title,
    String? description,
    DateTime? dueDate,
    int? categoryId,
    int? priority,
  });
}
