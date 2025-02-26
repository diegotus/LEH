import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/presentation_page_header.dart';
import '../../../../core/utils/text_teme_helper.dart';
import '../../../../global_widgets/app_button.dart';
import '../../../../global_widgets/input_field.dart';
import '../../../../routes/app_pages.dart';
import '../../bindings/otp_binding.dart';
import '../../views/otp_view.dart';
import '../controllers/forget_password_controller.dart';
import 'new_password_view.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({super.key});

  void submitRegistration([_]) async {
    //Get.toNamed(otpScreen, arguments: {"email": ""});
    if (controller.formKey.currentState?.validate() == true) {
      controller.formKey.currentState?.save();
      Get.to(
        () {
          return OTPView(
            onAuthentificated: () {
              Get.off(() => NewPasswordView());
              return;
            },
          );
        },
        opaque: false,
        bindings: [OTPBinding.forgotPassword(controller.email)],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PresentationPageHeader(
              pageTitle: AppStrings.RESET_PASSWORD,
            ),
            verticalSpaceRegular,
            Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.ss,
                    ),
                    child: CustomInputFormField(
                      hintText: AppStrings.EMAIL,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: submitRegistration,
                      validator: (value) {
                        if ((value ?? "").isEmpty) {
                          return AppStrings.PLS_ENTER_EMAILID;
                        } else if (!value!.isEmail) {
                          return AppStrings.PLS_ENTER_VALID_EMAILID;
                        } else {
                          return null;
                        }
                      },
                      onSaved: (p0) {
                        controller.email = p0 ?? "";
                      },
                    ),
                  ),
                  verticalSpaceLarge,
                  customeAuthButton(
                    lableName: AppStrings.RESET,
                    onTap: submitRegistration,
                  ),
                ],
              ),
            ),
            verticalSpaceRegular,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.BACK_TO,
                  textAlign: TextAlign.center,
                  style: TextThemeHelper.authTitle,
                ),
                horizontalSpaceTiny,
                GestureDetector(
                  onTap: () {
                    Get.offNamed(Routes.LOGIN);
                  },
                  child: Text(
                    AppStrings.LOGIN,
                    textAlign: TextAlign.left,
                    style: TextThemeHelper.registerHere,
                  ),
                ),
              ],
            ),
            verticalSpaceRegular,
          ],
        ),
      ),
    );
  }
}
