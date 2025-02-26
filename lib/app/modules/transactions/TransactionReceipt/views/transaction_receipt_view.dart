import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/utils/app_utility.dart';
import '../../../../data/models/ledger_model.dart';
import '../../../../global_widgets/app_bar.dart';
import '../../../../global_widgets/app_button.dart';
import '../../../../global_widgets/list_builder_widget.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/transaction_receipt_controller.dart';
import 'receipt_detail.dart';
import 'receipt_status.dart';

class TransactionReceiptView extends GetView<TransactionReceiptController> {
  const TransactionReceiptView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final containData = false.obs;

    return Scaffold(
      appBar: AppBarWidgetTitle(
        title: '',
        height: 50,
        predicate: backUntil,
        actions: [
          Obx(
            () => Visibility(
              visible: containData.isTrue,
              child:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            ),
          ),
        ],
      ),
      body: FutureDataBuilder<LedgerModel>(
          onEmptyText: "Receipt Not Found",
          isEmpty: (p0) {
            return p0 == null;
          },
          future: () => controller.getReceiptDetail().then((data) {
                containData.value = data != null;
                return data;
              }),

          // separatorBuilder: (p0, p1, item) {
          //   return Text(item.createdAt.since());
          // },

          futureBuilder: (context, item, _) {
            return Column(
              children: [
                Expanded(
                  child: ReceiptStatus(
                    amount: item.amount + item.fees,
                    status: item.status,
                  ),
                ),
                ReceiptDetail(
                  amount: item.amount,
                  date: item.updatedAt,
                  type: item.type,
                  method: item.method,
                  fee: item.fees,
                  status: item.status,
                ),
                verticalSpaceMedium,
                const AppButton(
                  buttonText: "Download Receipt",
                ),
                verticalSpaceSmall,
              ],
            );
          }),
    );
  }

  bool backUntil(GetPage route) {
    return route.name == Routes.HOME;
  }
}
