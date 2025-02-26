import 'package:get/get.dart';

import '../controllers/transaction_details_controller.dart';

class TransactionDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionDetailsController>(
      () => TransactionDetailsController(),
    );
  }
}
