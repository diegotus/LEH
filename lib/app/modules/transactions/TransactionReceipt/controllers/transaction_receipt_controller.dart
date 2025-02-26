import 'package:get/get.dart';

import '../../../../core/utils/enums.dart';
import '../../../../data/models/ledger_model.dart';
import '../../providers/transactions_provider.dart';

class TransactionReceiptController extends GetxController {
  late TransactionsProvider provider;

  @override
  void onInit() {
    provider = Get.put<TransactionsProvider>(TransactionsProvider());
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<LedgerModel?> getReceiptDetail() async {
    var id = Get.parameters['transactionId'];
    var method = Get.parameters['method'];
    var response = await provider.getLedgerDetailAPI2(
      id: id!,
      method: TransactionMethod.fromMap(method),
    );
    if (response?.isSuccess == true) {
      return LedgerModel.fromMap(response!.data);
    }
    throw response?.data;
  }
}
