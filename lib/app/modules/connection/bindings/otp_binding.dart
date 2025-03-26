import 'package:get/get.dart';

import '../../../core/utils/enums.dart';
import '../controllers/otp_controller.dart';
import '../providers/connection_provider.dart';

class OTPBinding extends Binding {
  OTPBinding(this.otpContacted) : bidingtype = OTPType.register;
  OTPBinding.forgotPassword(this.otpContacted)
      : bidingtype = OTPType.forgotPassword;
  final OTPType bidingtype;
  final String otpContacted;
  @override
  List<Bind> dependencies() {
    List<Bind> binds = [
      Bind.lazyPut<ConnectionProvider>(
        () => ConnectionProvider(),
      ),
    ];
    switch (bidingtype) {
      case OTPType.register:
        binds.add(Bind.lazyPut<OTPController>(
          () => OTPController(otpContacted: otpContacted),
        ));
        break;
      case OTPType.forgotPassword:
        binds.add(Bind.lazyPut<OTPController>(
          () => OTPController.forgotPassword(otpContacted: otpContacted),
        ));
        break;
    }
    return binds;
  }
}
