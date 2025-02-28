import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../../core/utils/actions/overlay.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/presentation_page_header.dart';
import '../../../../core/utils/text_teme_helper.dart';
import '../../../../global_widgets/app_button.dart';
import '../../../../global_widgets/input_field.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PresentationPageHeader(
              pageTitle: AppStrings.LOGIN,
            ),
            verticalSpaceRegular,
            Form(
              key: controller.formKey,
              child: AutofillGroup(
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
                        autofillHints: [AutofillHints.email],
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
                    verticalSpaceRegular,
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.ss,
                      ),
                      child: CustomInputFormField(
                        keyboardType: TextInputType.visiblePassword,
                        autofillHints: [AutofillHints.password],
                        hintText: AppStrings.PASSWORD,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => submitLogin(),
                        errorMaxLines: 5,
                        validator: (value) {
                          if ((value ?? "").isEmpty) {
                            return AppStrings.PLS_ENTER_PASSWORD;
                          }
                          return null;
                        },
                        onSaved: (p0) {
                          controller.password = p0 ?? "";
                        },
                      ),
                    ),
                    verticalSpaceSmall,
                    ExcludeFocus(
                      child: TextButton(
                        statesController: WidgetStatesController(),
                        iconAlignment: IconAlignment.end,
                        onPressed: () {
                          Get.offNamed(Routes.FORGET_PASSWORD);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.ss,
                          ),
                          child: Text(
                            AppStrings.FORGOT_PASSWORD,
                            textAlign: TextAlign.center,
                            style: TextThemeHelper.forgotPassword,
                          ),
                        ),
                      ),
                    ),
                    verticalSpaceMedium,
                    customeAuthButton(
                        lableName: AppStrings.LOGIN, onTap: submitLogin),
                  ],
                ),
              ),
            ),
            verticalSpaceRegular,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppStrings.NEW_USER,
                    textAlign: TextAlign.center,
                    style: TextThemeHelper.authTitle),
                horizontalSpaceTiny,
                GestureDetector(
                  onTap: () {
                    Get.offNamed(Routes.SIGNUP);
                  },
                  child: Text(
                    AppStrings.REGISTER_HERE,
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
    );
  }

  submitLogin() {
    if (controller.formKey.currentState!.validate()) {
      controller.formKey.currentState!.save();
      showOverlay(
        asyncFunction: controller.logInApiCall,
      );
    }
  }
}
