import 'package:get/get.dart';

import '../../providers/connection_provider.dart';
import '../controllers/login_controller.dart';

class LoginBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<ConnectionProvider>(
        () => ConnectionProvider(),
      ),
      Bind.lazyPut<LoginController>(
        () => LoginController(),
      )
    ];
  }
}
