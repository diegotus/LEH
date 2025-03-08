import 'package:get/get.dart';
import 'package:haiti_lotri/app/modules/connection/providers/connection_provider.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectionProvider>(
      () => ConnectionProvider(),
      fenix: true,
    );
    Get.lazyPut<NewPasswordController>(
      () => NewPasswordController(),
      fenix: true,
    );
  }
}
