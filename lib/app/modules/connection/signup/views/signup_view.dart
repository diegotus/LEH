import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haiti_lotri/app/modules/connection/signup/controllers/signup_controller.dart';
import 'package:sizing/sizing.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/formatters/validation.dart';
import '../../../../core/utils/presentation_page_header.dart';
import '../../../../core/utils/text_teme_helper.dart';
import '../../../../global_widgets/app_button.dart';
import '../../../../global_widgets/input_field.dart';
import '../../../../routes/app_pages.dart';
import '../../bindings/otp_binding.dart';
import '../../views/otp_view.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  void submitRegistration([_]) async {
    //Get.toNamed(otpScreen, arguments: {"email": ""});
    if (controller.formKey.currentState?.validate() == true) {
      controller.formKey.currentState?.save();
      Get.to(() {
        return OTPView(
          onAuthentificated: controller.signupApiCall,
        );
      }, opaque: false, bindings: [OTPBinding(controller.email)]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyboard(),
      child: Scaffold(
        backgroundColor: AppColors.APP_BG,
        body: SingleChildScrollView(
          child: Column(
            children: [
              PresentationPageHeader(
                pageTitle: AppStrings.SIGN_UP_NOW,
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
                        hintText: AppStrings.NAME,
                        keyboardType: TextInputType.streetAddress,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          controller.name = value!;
                        },
                        validator: (p0) {
                          if ((p0 ?? '').isEmpty) {
                            return AppStrings.PLS_ENTER_NAME;
                          }
                          return null;
                        },
                      ),
                    ),
                    verticalSpaceRegular,
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.ss,
                      ),
                      child: CustomInputFormField(
                        hintText: AppStrings.EMAIL,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          controller.email = value!;
                        },
                        validator: isValidEmail,
                      ),
                    ),
                    verticalSpaceRegular,
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.ss,
                      ),
                      child: CustomInputFormField(
                        hintText: AppStrings.PHONE_NUMBER,
                        keyboardType: TextInputType.number,
                        inputFormatters: [controller.phoneFormatter],
                        counterText: "",
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          controller.phone =
                              controller.phoneFormatter.unmaskText(value!);
                        },
                        validator: (p0) {
                          if ((p0 ?? '').isEmpty) {
                            return AppStrings.PLS_ENTER_PHONE_NUMBER;
                          } else if (!controller.phoneFormatter.isFill()) {
                            return AppStrings.PLS_ENTER_VALID_PHONE_NUMBER;
                          }
                          return null;
                        },
                      ),
                    ),
                    verticalSpaceRegular,
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.ss,
                      ),
                      child: CustomInputFormField(
                        keyboardType: TextInputType.visiblePassword,
                        errorMaxLines: 5,
                        hintText: AppStrings.PASSWORD,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: submitRegistration,
                        onSaved: (value) {
                          controller.password = value!;
                        },
                        validator: validPassword,
                      ),
                    ),
                    SizedBox(height: 40.vs),
                    controller.isLoading.value
                        ? customeAuthButtonLoading()
                        : customeAuthButton(
                            lableName: AppStrings.SIGN_UP,
                            onTap: submitRegistration,
                          ),
                  ],
                ),
              ),
              SizedBox(height: 50.ss),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStrings.ALREADY_HAVE_AN_ACCOUNT,
                      textAlign: TextAlign.center,
                      style: TextThemeHelper.authTitle),
                  horizontalSpaceTiny,
                  GestureDetector(
                    onTap: () {
                      Get.offAndToNamed(Routes.LOGIN);
                    },
                    child: Text(
                      AppStrings.LOGIN,
                      textAlign: TextAlign.center,
                      style: TextThemeHelper.registerHere,
                    ),
                  ),
                ],
              ),
              verticalSpaceRegular,
            ],
          ),
        ),
      ),
    );
  }
}
