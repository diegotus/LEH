import 'package:get/get.dart';

import '../controllers/cash_in_controller.dart';

class CashInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashInController>(
      () => CashInController(),
    );
  }
}
