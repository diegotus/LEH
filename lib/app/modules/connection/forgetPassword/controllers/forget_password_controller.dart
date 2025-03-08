import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/enums.dart';

import '../../../../data/models/signup_model.dart';
import '../../../../routes/app_pages.dart';
import '../../providers/connection_provider.dart';

class ForgetPasswordController extends GetxController {
  final provider = Get.put(ConnectionProvider());
  final formKey = GlobalKey<FormState>();
  var formKeyNewPass = GlobalKey<FormState>();

  String email = "";
  String newPassword = "";
  Timer? timer;
  final enableResend = RxBool(false);
  final isLoading = RxBool(false);

  int remainingSecoends = 1;
  final time = '00:00'.obs;

  Future<double?> requestOtp() async {
    try {
      var response =
          await provider.askForOtpApi(email, OTPType.forgotPassword.name);
      if (response?.isSuccess == true) {
        var otpData = OTPModel.fromMap(response!.data!);
        response.showMessage(message: ["Otp sent to successfully"]);

        return otpData.otpValidity;
      } else {
        response?.showMessage();
        if ((response?.error ?? '').isNotEmpty) {
          return OTPModel.fromMap({
            'otpValidity': response!.error!,
          }).otpValidity;
        }
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  Future resetPassword() async {
    var response = await provider.resetPassword(email, newPassword);
    if (response?.isSuccess == true) {
      Get.offNamedUntil(
          Routes.LOGIN, (predicate) => predicate.name == Routes.CONNECTION);
      response!.showMessage();
    } else {
      Get.backLegacy(closeOverlays: true);
    }
  }
}
