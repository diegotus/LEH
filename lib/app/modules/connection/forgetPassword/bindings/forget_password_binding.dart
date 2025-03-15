import 'package:get/get.dart';
import 'package:haiti_lotri/app/modules/connection/providers/connection_provider.dart';

import '../controllers/forget_password_controller.dart';

class ForgetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgetPasswordController>(
      () => ForgetPasswordController(),
      fenix: true,
    );
    Get.lazyPut<ConnectionProvider>(
      () => ConnectionProvider(),
      fenix: true,
    );
  }
}
