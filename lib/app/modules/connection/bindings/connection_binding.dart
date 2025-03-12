import 'package:get/get.dart';

import '../controllers/connection_controller.dart';
import '../providers/connection_provider.dart';

class ConnectionBinding extends Binding {
  @override
  List<Bind> dependencies() {
    print("binding here");
    return [
      Bind.lazyPut<ConnectionProvider>(
        () => ConnectionProvider(),
      ),
      Bind.lazyPut<ConnectionController>(
        () => ConnectionController(),
      ),
    ];
  }
}
