import 'package:get/get.dart';

import '../controllers/connection_controller.dart';
import '../providers/connection_provider.dart';

class ConnectionBinding extends Bindings {
  @override
  void dependencies() {
    print("its not empty biding");
    Get.lazyPut<ConnectionProvider>(
      () => ConnectionProvider(),
    );
    Get.lazyPut<ConnectionController>(
      () => ConnectionController(),
    );
  }
}
