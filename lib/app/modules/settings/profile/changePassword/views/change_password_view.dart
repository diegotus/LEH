import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../../../core/utils/actions/overlay.dart';
import '../../../../../core/utils/app_string.dart';
import '../../../../../core/utils/app_utility.dart';
import '../../../../../core/utils/font_family.dart';
import '../../../../../core/utils/formatters/validation.dart';
import '../../../../../global_widgets/app_bar.dart';
import '../../../../../global_widgets/app_button.dart';
import '../../../../../global_widgets/input_field.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});
  void submitData([_]) {
    if (controller.formKey.currentState?.validate() == true) {
      controller.formKey.currentState!.save();
      showOverlay(asyncFunction: () => controller.changePassword());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidgetTitle(
          title: AppStrings.CHANGE_PASSWORD,
        ),
        body: Form(
          key: controller.formKey,
          child: ListView(
            padding: const EdgeInsets.only(top: 35, right: 25, left: 25),
            children: [
              inputWithLabel(
                required: true,
                obscureText: true,
                label: AppStrings.OLD_PASSWORD,
                hintText: AppStrings.ENTER_OLD_PASSWORD,
                style: TextStyle(
                  color: const Color(0xFF111A24),
                  fontSize: 14.fss,
                  fontFamily: FontPoppins.SEMIBOLD,
                ),
                textInputAction: TextInputAction.done,
                onSaved: (value) {
                  controller.oldPassword = value ?? '';
                },
                validator: (value) => isEmptyValidator(
                  value,
                  AppStrings.PLEASE_ENTER_OLD_PASSWORD,
                ),
              ),
              verticalSpaceMedium,
              inputWithLabel(
                required: true,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                label: AppStrings.NEW_PASSWORD,
                hintText: AppStrings.ENTER_NEW_PASSWORD,
                style: TextStyle(
                  color: const Color(0xFF111A24),
                  fontSize: 14.fss,
                  fontFamily: FontPoppins.SEMIBOLD,
                ),
                textInputAction: TextInputAction.next,
                onChanged: (value) => controller.newpassword = value ?? '',
                onSaved: (value) {
                  controller.newpassword = value!;
                },
                validator: (value) => validPassword(value),
              ),
              verticalSpaceMedium,
              inputWithLabel(
                required: true,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                label: AppStrings.CONFIRM_NEW_PASSWORD,
                hintText: AppStrings.ENTER_CONFIRM_NEW_PASSWORD,
                style: TextStyle(
                  color: const Color(0xFF111A24),
                  fontSize: 14.fss,
                  fontFamily: FontPoppins.SEMIBOLD,
                ),
                textInputAction: TextInputAction.done,
                onFieldSubmitted: submitData,
                onSaved: (value) {},
                validator: (value) {
                  var isEmpty = controller.newpassword.isNotEmpty
                      ? isEmptyValidator(
                          value,
                          AppStrings.PLEASE_ENTER_CONFIRM_NEW_PASSWORD,
                        )
                      : null;
                  if (isEmpty == null && value != controller.newpassword) {
                    return AppStrings.PASSWORD_NOT_MATCH;
                  }
                  return isEmpty;
                },
              ),
              verticalSpaceMedium,
              AppButton(
                buttonText: "Submit",
                onTap: submitData,
              )
            ],
          ),
        ));
  }
}
