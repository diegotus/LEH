import 'package:get/get.dart';

import '../../../core/utils/enums.dart';
import '../controllers/otp_controller.dart';

class OTPBinding extends Bindings {
  OTPBinding(this.otpContacted) : bidingtype = OTPType.register;
  OTPBinding.forgotPassword(this.otpContacted)
      : bidingtype = OTPType.forgotPassword;
  final OTPType bidingtype;
  final otpContacted;
  @override
  void dependencies() {
    switch (bidingtype) {
      case OTPType.register:
        Get.lazyPut<OTPController>(
          () => OTPController(otpContacted: otpContacted),
        );
      case OTPType.forgotPassword:
        Get.lazyPut<OTPController>(
          () => OTPController.forgotPassword(otpContacted: otpContacted),
        );
    }
  }
}
