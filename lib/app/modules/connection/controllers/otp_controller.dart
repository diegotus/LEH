import 'dart:async';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/utils/actions/overlay.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_utility.dart';
import '../../../core/utils/enums.dart';
import '../../../data/models/signup_model.dart';
import '../providers/connection_provider.dart';

class OTPController extends GetxController {
  OTPController({required this.otpContacted}) : type = OTPType.register;
  OTPController.forgotPassword({required this.otpContacted})
      : type = OTPType.forgotPassword;
  late final ConnectionProvider provider;
  late final RxString pin;
  late final Rx<int> secondsRemaining;
  bool get enableResend => duration.value == Duration.zero;
  Timer? timer;
  late final StreamController<ErrorAnimationType> pinErrorController;
  final OTPType type;
  final String otpContacted;
  late final Rx<Duration> duration;

  @override
  onInit() {
    duration = Rx<Duration>(_getDuration(Get.arguments ?? 3));
    provider = Get.find<ConnectionProvider>();
    pinErrorController = StreamController<ErrorAnimationType>();
    pin = RxString("");
    secondsRemaining = 0.obs;
    super.onInit();
  }

  @override
  onClose() {
    pinErrorController.close();
    super.onClose();
  }

  Future<bool> verifyOtpApi() async {
    try {
      var response =
          await provider.verifyOTP(otpContacted, pin.value, type.name);

      if (response?.isSuccess == true) {
        await response!.showMessage()?.future;
        return true;
      } else {
        response?.showMessage();
      }
    } catch (e) {
      Get.log('$e', isError: true);
    }
    return false;
  }

  Future<void> requestOtp() async {
    try {
      var response =
          await provider.askForOtpApi(otpContacted.trim(), type.name);
      if (response?.isSuccess == true) {
        var registerData = OTPModel.fromMap(response!.data!);
        updateDuration(registerData.otpValidity!);
        showMsg(
          registerData.message ?? "Otp sent to successfully",
          color: AppColors.SUCCESS,
        );
      } else {
        if ((response?.error ?? '').isNotEmpty) {
          updateDuration(double.parse(response!.error!));
        }
      }
    } catch (e) {
      Get.log("$e", isError: true);
      Get.back();
    }
  }

  updateDuration(double value) {
    duration.value = _getDuration(value);
  }

  Duration _getDuration(double value) {
    return Duration(
      milliseconds: (value * Duration.millisecondsPerMinute).toInt(),
    );
  }

  resendOtpApiCall() async {
    //isLoading.value = true;
    showOverlay(asyncFunction: requestOtp);
  }
}
