import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/formatters/extension.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../../core/utils/actions/overlay.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/font_family.dart';
import '../../../../core/utils/formatters/validation.dart';
import '../../../../core/utils/text_style.dart';
import '../../../../global_widgets/app_button.dart';
import '../../../../global_widgets/custom_appbar.dart';
import '../../../../global_widgets/input_field.dart';
import '../../../../data/models/validation_info_model.dart';
import '../controllers/send_money_controller.dart';

final _titleStile = TextStyle(
  fontSize: 12.fss,
  color: FontColors.BLUE_FADE,
  fontWeight: FontWeight.w300,
);

class SendMoneyView extends GetView<SendMoneyController> {
  const SendMoneyView({super.key});
  submitTransaction(BuildContext context) {
    if (controller.formKey.currentState!.validate()) {
      controller.formKey.currentState!.save();
      showOverlay(
        asyncFunction: () => controller.getValidationInfo(
            '+${controller.phone}', controller.amount),
      ).then((val) {
        if (val == null) return;
        getValidationSheet(
          context: context,
          amount: controller.amount,
          val: val,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: CustomAppBar(
        context,
        AppStrings.LABEL_SEND_MONEY,
        true,
        true,
        const [],
        () {},
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        AppButton(
            buttonText: AppStrings.NEXT,
            onTap: () => submitTransaction(context)),
      ],
      body: Container(
        margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      inputWithLabel(
                        required: true,
                        label: AppStrings.PHONE_NUMBER,
                        hintText: AppStrings.PHONE_NUMBER,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        prefixIcon: Center(
                          widthFactor: 0.1,
                          child: Text(
                            "+",
                            style: labelTextStyle.copyWith(
                                fontSize: 16.ss, fontWeight: FontWeight.bold),
                          ),
                        ),
                        inputFormatters: [numberFormatter],
                        validator: (value) {
                          if ((value ?? '').isEmpty) {
                            return AppStrings.PLS_ENTER_PHONE_NUMBER;
                          }
                          if (value?.isPhoneNumber != true) {
                            return AppStrings.PLS_ENTER_VALID_PHONE_NUMBER;
                          }
                          return null;
                        },
                        onSaved: (value) {
                          controller.phone = value!;
                        },
                      ),
                      verticalSpaceMedium,
                      inputWithLabel(
                          required: true,
                          label: AppStrings.ENTER_AMOUNT,
                          hintText: AppStrings.AMOUNT,
                          inputFormatters: [decimalNumberFormatter],
                          keyboardType: TextInputType.number,
                          onFieldSubmitted: (p0) => submitTransaction(context),
                          textInputAction: TextInputAction.done,
                          onSaved: (val) {
                            controller.amount = double.parse(val!);
                          },
                          validator: (value) {
                            if ((value ?? '').isEmpty) {
                              return AppStrings.PLS_ENTER_AMOUNT;
                            }
                            if (double.parse(value!) < 100) {
                              return AppStrings.PLS_MIN_AMOUNT;
                            }
                            controller.canNext.value = true;

                            return null;
                          }),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void getValidationSheet({
    required BuildContext context,
    required double amount,
    required ValidationData val,
  }) {
    var listData = [
      {
        "leading": AppStrings.AMOUNT,
        "title": amount.toHLG,
      },
      {
        "leading": AppStrings.FEE,
        "title": val.fees.toHLG,
      },
      {
        "leading": AppStrings.TAX,
        "title": (amount * 0.1).toHLG,
      },
      {
        "leading": AppStrings.FROM,
        "title": val.senderInfo.name,
        "subtitle": val.senderInfo.phone
      },
      {
        "leading": AppStrings.TO,
        "title": val.receiverInfo.name,
        "subtitle": val.receiverInfo.phone
      },
    ];

    final pin = ''.obs;

    showModalBottomSheet(
      backgroundColor: AppColors.APP_BG,
      scrollControlDisabledMaxHeightRatio: .92,
      context: context,
      builder: (context) {
        return Scaffold(
          // use CupertinoPageScaffold for iOS
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  //header
                  ListTile(
                    title: Text(
                      amount.toHLG,
                      textAlign: TextAlign.center,
                      style: _titleStile.copyWith(
                        fontSize: 20.fss,
                        fontFamily: FontPoppins.BOLD,
                      ),
                    ),
                    subtitle: Text(
                      "Transfer HTG",
                      textAlign: TextAlign.center,
                      style: _titleStile.copyWith(
                        fontSize: 15.fss,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  verticalSpaceMedium,
                  //body
                  ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (BuildContext context, int index) {
                      var currentEl = listData[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${currentEl['leading']}",
                              style: _titleStile,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${currentEl['title']}",
                                  style: _titleStile,
                                ),
                                if (currentEl['subtitle'] != null)
                                  Text(
                                    "${currentEl['subtitle']}",
                                    style:
                                        _titleStile.copyWith(fontSize: 10.fss),
                                  )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: FontColors.GREY_140,
                      );
                    },
                    itemCount: listData.length,
                  ),
                  verticalSpaceLarge,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.08.sw),
                    child: Text(
                      AppStrings.PLS_ENTER_PIN,
                      textAlign: TextAlign.center,
                      style: _titleStile.copyWith(
                        fontFamily: FontPoppins.BOLD,
                      ),
                    ),
                  ),
                  verticalSpaceSmall,
                  PinCodeTextField(
                    showCursor: false,
                    appContext: context,
                    mainAxisAlignment: MainAxisAlignment.center,
                    separatorBuilder: (context, index) => horizontalSpaceTiny,
                    pastedTextStyle: TextStyle(
                      textBaseline: TextBaseline.alphabetic,
                      fontFamily: FontPoppins.REGULAR,
                      color: const Color.fromARGB(255, 1, 1, 1),
                      fontSize: 16.fss,
                    ),
                    length: 4,
                    obscureText: true,
                    obscuringCharacter: "*",
                    // backgroundColor: AppColors.WHITE,
                    hapticFeedbackTypes: HapticFeedbackTypes.heavy,
                    useHapticFeedback: true,
                    pinTheme: PinTheme(
                      activeColor: AppColors.PRIMARY1,
                      selectedFillColor: AppColors.WHITE,
                      selectedColor: Colors.blueGrey,
                      activeFillColor: AppColors.WHITE,
                      inactiveFillColor: AppColors.WHITE,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      borderWidth: 1.5,
                      inactiveColor: Colors.grey.shade400,
                      fieldHeight: 40,
                      fieldWidth: 35,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    enablePinAutofill: true,
                    keyboardType: const TextInputType.numberWithOptions(),
                    inputFormatters: [numberFormatter],
                    onChanged: (value) {
                      pin.value = value;
                    },
                  ),
                  verticalSpaceMedium,
                  //footer
                  Obx(() => AppButton(
                        buttonText: AppStrings.SUBMIT,
                        onTap: pin.isEmpty || pin.value.length < 4
                            ? null
                            : () {
                                Get.showOverlay(
                                  asyncFunction: () => controller.sendMoney(
                                    transactionID: val.id,
                                    pin: pin.value,
                                  ),
                                  loadingWidget:
                                      LoadingAnimationWidget.fourRotatingDots(
                                    color: AppColors.PRIMARY1,
                                    size: 30.0, // Adjust size as needed
                                  ),
                                );
                              },
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
