/// UseCase is a class that will be
/// used to define the use case of the application.
abstract class UseCase<Type, Params> {
  /// this method will be called from the presentation layer
  Future<Type> execute(Params params) async {
    // Pre-processing (if any)
    final result = await run(params);
    // Post-processing (if any)
    return result;
  }

  /// this method will be implemented in the use case class
  Future<Type> run(Params params);
}
