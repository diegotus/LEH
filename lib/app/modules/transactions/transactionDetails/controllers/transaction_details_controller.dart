import 'package:get/get.dart';
import 'package:haiti_lotri/app/controllers/def_controller.dart';
import 'package:haiti_lotri/app/core/api_helper/app_exception.dart';

import '../../../../data/models/ticket_model.dart';
import '../../../../data/models/transaction_model.dart';
import '../../providers/transactions_provider.dart';

class TransactionDetailsController extends GetxController with DefController {
  late TransactionsProvider provider;

  final count = 0.obs;
  @override
  void onInit() {
    provider =
        Get.putOrFind<TransactionsProvider>(() => TransactionsProvider());
    super.onInit();
  }

  Future<TransactionModel?> getTransactionDetail() async {
    int? transactionId = int.tryParse("${Get.parameters["id"]}");
    if (transactionId != null) {
      var response = await provider.getTransactionDetailAPI(id: transactionId);
      if (response?.isSuccess == true) {
        print("before result");
        var result = TransactionModel.fromMap(response!.data);
        print("after result $result");
        return result;
      }
      return null;
    } else {
      return Future.error(InvalidInputException("invalid Parameter"));
    }
  }

  Future<List<TicketModel>> callTicketApi(trasnactionId) async {
    var response = await provider.ticketApi(trasnactionId);
    if (response?.isSuccess == true) {
      return listTicketModel(response!.data);
    }
    response?.showMessage();
    return [];
  }
}
