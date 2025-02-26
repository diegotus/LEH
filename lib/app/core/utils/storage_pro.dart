import 'package:get_storage_pro/get_storage_pro.dart';

/// get [T] saved by its id.
///
T? getObjectById<T extends CommonDataClass<T>>(String id) {
  return GetStoragePro.getObjectById<T>(id);
}

/// Get all object [T] as List<[T]>.
///
List<T> getAllObjects<T extends CommonDataClass<T>>() {
  return GetStoragePro.getAllObjects<T>();
}

/// Save Object [T] to Storage
///
void saveObject<T extends CommonDataClass<T>>(T data) {
  GetStoragePro.saveObject<T>(data);
}

/// Save List<[T]> to Stoage
///
void saveObjectsList<T extends CommonDataClass<T>>(List<T> data) {
  GetStoragePro.saveObjectsList<T>(data);
}

/// Clead all data in [T] memory.
///
void deleteAllObjects<T extends CommonDataClass<T>>() {
  GetStoragePro.deleteAllObjects<T>();
}

/// Clead all data in [T] memory.
///
listenAllObjects<T extends CommonDataClass<T>>(
    {required dynamic Function(List<T>) onData}) {
  GetStoragePro.listenAllObjects<T>(onData: onData);
}

/// Listens for changes to the object with the specified [id] of type [T].
///
/// Calls [onData] with the updated object whenever changes occur.
listenForObjectChanges<T extends CommonDataClass<T>>(
    {required String id, required dynamic Function(T?) onData}) {
  GetStoragePro.listenForObjectChanges<T>(id: id, onData: onData);
}
