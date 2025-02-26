import 'package:get_storage/get_storage.dart';

mixin StorageBox {
  static GetStorage boxKeys() => GetStorage('appKeys');
  static final token = ''.val("token", getBox: boxKeys);
  static final fmcToken = ''.val("fmcToken", getBox: boxKeys);
  static Future<void> removeToken() async {
    await boxKeys().remove('token');
  }

  static saveData(String key, data) async {
    await boxKeys().write(key, data);
  }
}
