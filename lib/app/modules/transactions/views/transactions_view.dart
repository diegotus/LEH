import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haiti_lotri/app/routes/app_pages.dart';

import '../controllers/transactions_controller.dart';

class TransactionsView extends GetView<TransactionsController> {
  const TransactionsView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet(
      initialRoute: Routes.TRANSACTION_HISTORY,
      anchorRoute: Routes.TRANSACTIONS,
    );
  }
}
