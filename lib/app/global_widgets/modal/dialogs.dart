import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizing/sizing_extension.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_utility.dart';
import '../../core/utils/font_family.dart';
import '../../core/utils/formatters/validation.dart';

Future<String?> showPinDialog() async {
  GlobalKey<FormState> formKey = GlobalKey();
  String? pin;
  pin = await Get.defaultDialog<String>(
    title: "Enter your PIN",
    content: Form(
      key: formKey,
      child: PinCodeTextField(
        showCursor: false,
        appContext: Get.context!,
        mainAxisAlignment: MainAxisAlignment.center,
        separatorBuilder: (context, index) => horizontalSpaceTiny,
        pastedTextStyle: TextStyle(
          textBaseline: TextBaseline.alphabetic,
          fontFamily: FontPoppins.REGULAR,
          color: const Color.fromARGB(255, 1, 1, 1),
          fontSize: 16.fss,
        ),
        autovalidateMode: AutovalidateMode.disabled,
        length: 4,
        obscureText: true,
        obscuringCharacter: "*",
        // backgroundColor: AppColors.WHITE,
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
          fieldHeight: 45,
          fieldWidth: 40,
        ),
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        enablePinAutofill: true,
        keyboardType: const TextInputType.numberWithOptions(),
        inputFormatters: [numberFormatter],
        validator: (value) {
          var empty = isEmptyValidator(value, "Please enter PIN");
          if (empty != null) {
            return empty;
          } else if (value?.length != 4) {
            return "PIN Should not 4 digit.";
          }
          return null;
        },
        onSaved: (value) {
          pin = value!;
        },
      ),
    ),
    textConfirm: "Confirm",
    onConfirm: () {
      if (formKey.currentState?.validate() == true) {
        formKey.currentState!.save();
        Get.back(result: pin);
      }
    },
    // backgroundColor: Colors.white,
  );
  return pin;
}
