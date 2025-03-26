import 'package:get/get.dart';
import 'package:haiti_lotri/app/modules/connection/providers/connection_provider.dart';

import '../controllers/forget_password_controller.dart';

class ForgetPasswordBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<ConnectionProvider>(
        () => ConnectionProvider(),
      ),
      Bind.lazyPut<ForgetPasswordController>(
        () => ForgetPasswordController(),
      ),
    ];
  }
}
