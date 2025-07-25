import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../../core/utils/actions/overlay.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/font_family.dart';
import '../../../../core/utils/formatters/validation.dart';
import '../../../../core/utils/presentation_page_header.dart';
import '../../../../core/utils/text_teme_helper.dart';
import '../../../../global_widgets/app_button.dart';
import '../../../../global_widgets/input_field.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/forget_password_controller.dart';
import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  const NewPasswordView({super.key});
  void submitRegistration([_]) async {
    print("validate 1 ${controller.formKey.currentState}");
    if (controller.formKey.currentState?.validate() == true) {
      controller.formKey.currentState?.save();
      print("validate 2");

      showOverlay(
        asyncFunction: controller.resetPassword,
      );
    }
    print("validate 3");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PresentationPageHeader(
              pageTitle: AppStrings.CHANGE_PASSWORD,
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
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: AppStrings.ENTER_NEW_PASSWORD,
                      style: TextStyle(
                        color: const Color(0xFF111A24),
                        fontSize: 14.fss,
                        fontFamily: FontPoppins.SEMIBOLD,
                      ),
                      textInputAction: TextInputAction.next,
                      onChanged: (value) => controller.newPassword = value,
                      onSaved: (value) {
                        controller.newPassword = value!;
                      },
                      validator: (value) {
                        print("the validator msg ${validPassword(value)}");
                        return validPassword(value);
                      },
                    ),
                  ),
                  verticalSpaceMedium,
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.ss,
                    ),
                    child: CustomInputFormField(
                      obscureText: true,
                      hintText: AppStrings.ENTER_CONFIRM_NEW_PASSWORD,
                      style: TextStyle(
                        color: const Color(0xFF111A24),
                        fontSize: 14.fss,
                        fontFamily: FontPoppins.SEMIBOLD,
                      ),
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: submitRegistration,
                      validator: (value) {
                        var isEmpty = controller.newPassword.isNotEmpty
                            ? isEmptyValidator(
                                value,
                                AppStrings.PLEASE_ENTER_CONFIRM_NEW_PASSWORD,
                              )
                            : null;
                        if (isEmpty == null &&
                            value != controller.newPassword) {
                          return AppStrings.PLS_ENTER_PASSWORD_NOT_MATCH;
                        }
                        return isEmpty;
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
