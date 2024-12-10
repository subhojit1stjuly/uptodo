import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uptodo/core/offline_datasource/object_box_database/config/objectbox.g.dart'; // updated path

/// the main objectBox provider class
class ObjectBox {
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

  /// close the store
  Future<void> close() async {
    _store.close();
  }
}
