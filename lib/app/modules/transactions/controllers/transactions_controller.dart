import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:haiti_lotri/app/data/models/ticket_model.dart';

import '../../../controllers/app_services_controller.dart';
import '../../../controllers/def_controller.dart';
import '../../../data/models/payment_receipt_model.dart';
import '../../../data/models/transaction_model.dart';
import '../../../data/models/user_detail_model.dart';
import '../providers/transactions_provider.dart';

class TransactionsController extends GetxController {
  late TransactionsProvider provider;
  final appServiceController = Get.find<AppServicesController>();
  // FirebaseServices get firebaseService => Get.find<FirebaseServices>();
  Rx<UserDetailModel?> get userDetails => appServiceController.userDetails;
  int? get userID => userDetails.value?.id;
  String? get email => userDetails.value?.email;
  String? get phone => userDetails.value?.phone;
  @override
  onInit() {
    provider = Get.put(TransactionsProvider());
    super.onInit();
  }

  Future<List<TransactionModel>> futureRequest() async {
    var response = await provider.getTransactions(page: 0, perPage: 100);
    if (response?.isSuccess == true) {
      return TransactionModel.fromList(response!.data);
    }

    return [];
  }

  Future<PaymentReceiptData?> getTransactionDetail(int id) async {
    var response = await provider.getTransactionDetailAPI(id: id);
    if (response?.isSuccess == true) {
      return PaymentReceiptData.fromMap(response!.data);
    }
    return null;
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
