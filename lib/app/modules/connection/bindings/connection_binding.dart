import 'package:get/get.dart';

import '../controllers/connection_controller.dart';

class ConnectionBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<ConnectionController>(
        () => ConnectionController(),
      ),
    ];
  }
}
