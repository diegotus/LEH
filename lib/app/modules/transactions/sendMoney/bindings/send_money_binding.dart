import 'package:get/get.dart';

import '../controllers/send_money_controller.dart';
import '../views/recent_transfer.dart' show RecentTransferController;

class SendMoneyBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<SendMoneyController>(() => SendMoneyController()),
      Bind.lazyPut<RecentTransferController>(() => RecentTransferController()),
    ];
  }
}
