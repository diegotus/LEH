import 'package:get/get.dart';

import '../controllers/cash_out_controller.dart';

class CashOutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashOutController>(
      () => CashOutController(),
    );
  }
}
