import 'package:get/get.dart';
import 'package:haiti_lotri/app/modules/connection/providers/connection_provider.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<ConnectionProvider>(
        () => ConnectionProvider(),
      ),
      Bind.lazyPut<NewPasswordController>(
        () => NewPasswordController(),
      ),
    ];
  }
}
