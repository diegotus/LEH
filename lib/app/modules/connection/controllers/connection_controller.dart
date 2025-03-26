import 'package:get/get.dart';

import '../../../core/utils/cache_manager.dart';

class ConnectionController extends GetxController {
  @override
  void onInit() {
    CustomCacheManager.cleanCache();
    super.onInit();
  }
}
