import 'package:get/get.dart';

import '../controllers/transaction_receipt_controller.dart';

class TransactionReceiptBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionReceiptController>(
      () => TransactionReceiptController(),
    );
  }
}
