import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uptodo/core/storage/objectbox/config/objectbox.g.dart'; // updated path

@singleton

/// the main objectBox provider class
class ObjectBox {
  /// Factory constructor to return the same instance
  factory ObjectBox() {
    return _instance;
  }

  // Private constructor
  ObjectBox._privateConstructor();

  // The single instance of the class
  static final ObjectBox _instance = ObjectBox._privateConstructor();

  late final Store _store;

  /// initialize the store
  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    _store = await openStore(
      directory: p.join(directory.path, 'obx-uptodo'),
      macosApplicationGroup: 'objectbox.uptodo',
    );
  }

  /// get the store
  Store get store => _store;

  /// get the box
  Box<T> getBox<T>() {
    return _store.box<T>();
  }

  /// close the store
  Future<void> close() async {
    _store.close();
  }
}
