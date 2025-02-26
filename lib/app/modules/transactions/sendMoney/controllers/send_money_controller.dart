import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../core/utils/formatters/validation.dart';
import '../../../../data/models/payment_receipt_model.dart';
import '../../../../data/models/validation_info_model.dart';
import '../../providers/transactions_provider.dart';
import '../views/payment_receipt.dart';

class SendMoneyController extends GetxController {
  late final TransactionsProvider provider;

  final canNext = false.obs;
  final formKey = GlobalKey<FormState>();
  final phoneNumberformatter = phoneFormateur();
  double amount = 0;
  @override
  void onInit() {
    provider = Get.put<TransactionsProvider>(TransactionsProvider());
    super.onInit();
  }

  Future<ValidationData?> getValidationInfo(
      String number, double amount) async {
    try {
      var response = await provider.getvalidationInfo(
        phone: number,
        amount: amount,
      );
      if (response?.isSuccess == true) {
        return ValidationData.fromMap(response!.data);
      } else {
        response?.showMessage();
        return null;
      }
    } catch (e) {
      Get.log("getValidationInfoApiCall ==>${e.toString()}", isError: true);
      return null;
    }
  }

  Future<void> sendMoney(
      {required int transactionID, required String pin}) async {
    try {
      var response = await provider.sendMoney(
        transactionID: transactionID,
        pin: pin,
      );
      if (response?.isSuccess == true) {
        Get.log("transferMoneyRequestApiCall>>>>>>>${response?.data}");
        Get.to(() => PaymentReceipt(
              receipt: PaymentReceiptData.fromMap(response!.data!),
            ));
        // loanRequestList.clear();
        // loanRequestList.addAll(response.data as Iterable<Data>);
      } else {
        response?.showMessage();
      }
    } catch (e) {
      Get.log("transferMoneyRequestApiCall ==> ${e.toString()}", isError: true);
    }
  }
}
