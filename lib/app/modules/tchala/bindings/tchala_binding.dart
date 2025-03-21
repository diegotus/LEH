import 'package:get/get.dart';

import '../controllers/tchala_controller.dart';

class TchalaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TchalaController>(
      () => TchalaController(),
    );
  }
}
