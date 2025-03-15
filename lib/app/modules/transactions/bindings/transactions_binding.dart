import 'package:get/get.dart';

import '../controllers/transactions_controller.dart';

class TransactionsBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<TransactionsController>(
        () => TransactionsController(),
      )
    ];
  }
}
