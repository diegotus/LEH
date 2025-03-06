import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizing/sizing.dart';

import '../../../core/utils/actions/overlay.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_string.dart';
import '../../../core/utils/app_utility.dart';
import '../../../core/utils/font_family.dart';
import '../../../core/utils/text_teme_helper.dart';
import '../../../global_widgets/app_button.dart';
import '../../../global_widgets/count_down.dart';
import '../controllers/otp_controller.dart';

class OTPView extends GetWidget<OTPController> {
  const OTPView({super.key, required this.onAuthentificated});
  final FutureOr<void> Function() onAuthentificated;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 85.ss),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.OTP,
                      textAlign: TextAlign.center,
                      style: TextThemeHelper.headlineLarge,
                    ),
                    verticalSpaceRegular,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.CODE_IS_SENT_TO,
                          textAlign: TextAlign.center,
                          style: TextThemeHelper.authTitle,
                        ),
                        verticalSpaceSmall,
                        Text(
                          controller.otpContacted,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextThemeHelper.forgotPassword,
                        ),
                        IconButton(
                          icon: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [Icon(Icons.edit), Text("Change Email")],
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        )
                      ],
                    ),
                    Obx(
                      () => (!controller.enableResend)
                          ? CountDownWidget(
                              title: "counttDoun title",
                              duration: controller.duration.value,
                              onDone: () => controller.updateDuration(0),
                              style: TextThemeHelper.welcomeTitle,
                            )
                          : AppButton(
                              height: 37.ss,
                              width: .5.sw,
                              buttonText: AppStrings.RESEND_CODE_BTN,
                              onTap: () {
                                controller.pin.value = "";
                                controller.resendOtpApiCall();
                              },
                            ),
                    ),
                    verticalSpaceMedium,
                    SizedBox(
                      width: 290.ss,
                      child: PinCodeTextField(
                        showCursor: false,
                        appContext: context,
                        pastedTextStyle: TextStyle(
                            textBaseline: TextBaseline.alphabetic,
                            fontFamily: FontPoppins.REGULAR,
                            color: const Color.fromARGB(255, 1, 1, 1),
                            fontSize: 26.fss),
                        length: 4,
                        obscureText: false,
                        hapticFeedbackTypes: HapticFeedbackTypes.heavy,
                        useHapticFeedback: true,
                        pinTheme: PinTheme(
                          activeColor: AppColors.PRIMARY1,
                          selectedFillColor: AppColors.WHITE,
                          selectedColor: Colors.grey.shade400,
                          activeFillColor: AppColors.WHITE,
                          inactiveFillColor: AppColors.WHITE,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(10),
                          borderWidth: 1.5,
                          inactiveColor: Colors.grey.shade400,
                          fieldHeight: 56,
                          fieldWidth: 56,
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        enablePinAutofill: true,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          controller.pin.value = value;
                        },
                        errorAnimationController: controller.pinErrorController,
                      ),
                    ),
                    verticalSpaceRegular,
                    AppButton(
                      buttonText: AppStrings.SUBMIT,
                      color: AppColors.PRIMARY,
                      onTap: controller.pin.isEmpty ||
                              controller.pin.value.length < 4
                          ? null
                          : () {
                              showOverlay(asyncFunction: () async {
                                var resp = await controller.verifyOtpApi();
                                if (resp) {
                                  return onAuthentificated();
                                }
                              });
                            },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
