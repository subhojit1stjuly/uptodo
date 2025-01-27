import 'package:flutter/foundation.dart';
import 'package:objectbox/objectbox.dart';

/// base class for the objectBox database
abstract class ObjectBoxRepository<T> {

  /// constructor for the objectBox database
  ObjectBoxRepository(this.store, this.box);

  /// the store for the database
  final Store store;

  /// the box for the database
  final Box<T> box;

  /// add an item to the database
  int addItem(T item) {
    return box.put(item);
  }

  /// add multiple items to the database
  List<int> addItems(List<T> items) {
    return box.putMany(items);
  }

  /// remove an item from the database
  void removeItem(int id) {
    box.remove(id);
  }

  /// remove multiple items from the database
  void removeItems(List<int> ids) {
    box.removeMany(ids);
  }

  /// get an item from the database
  T? getItem(int id) {
    return box.get(id);
  }

  /// get all items from the database
  List<T> getAllItems() {
    return box.getAll();
  }

  /// query items from the database
  List<T> queryItems(Query<T> query) {
    return query.find();
  }

  /// count items in the database
  int countItems() {
    return box.count();
  }

  /// clear all items from the database
  void clearAllItems() {
    box.removeAll();
  }

  /// update an item in the database
  void updateItem(T item) {
    box.put(item);
  }

  /// perform a transaction for multiple operations
  void performTransaction(List<T> itemsToAdd, List<int> idsToRemove) {
    store.runInTransaction(TxMode.write, () {
      try {
        // Add multiple items
        box..putMany(itemsToAdd)

        // Remove multiple items
        ..removeMany(idsToRemove);
      } catch (e) {
        // Handle exceptions
        if (kDebugMode) {
          print('Transaction failed: $e');
        }
        rethrow; // Re-throw the exception after logging
      }
    });
  }

  /// get all items using a read-only transaction
  List<T> getAllItemsInTransaction() {
    return store.runInTransaction(TxMode.read, box.getAll);
  }
}
