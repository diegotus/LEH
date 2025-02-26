import 'package:get/get.dart';

import '../../../core/utils/cache_manager.dart';
import '../providers/connection_provider.dart';

class ConnectionController extends GetxController {
  final provider = Get.find<ConnectionProvider>();
  @override
  void onInit() {
    CustomCacheManager.cleanCache();
    super.onInit();
  }
}
