// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizing/sizing.dart';

import 'app_colors.dart';
import 'text_teme_helper.dart';

Widget imageFromAssets(String assetName,
    {String? semanticsLabel,
    double? height,
    double? width,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    Color? color}) {
  return Image.asset(
    "assets/images/$assetName",
    color: color,
    width: width,
    height: height,
    fit: fit ?? BoxFit.cover,
    alignment: alignment ?? Alignment.center,
  );
}

enum TypeMessage { error, success, info, other }

SnackbarController showMsg(String msg, {Color? color, TypeMessage? type}) {
  Color? background;
  switch (type) {
    case TypeMessage.error:
      background = Colors.red;
      break;
    case TypeMessage.success:
      background = AppColors.PRIMARY1;
    case TypeMessage.info:
      background = AppColors.YELLOW_CARD;
    default:
      background = color;
  }
  return Get.showSnackbar(GetSnackBar(
    snackPosition: SnackPosition.bottom,
    backgroundColor: background ?? AppColors.PRIMARY,
    duration: const Duration(seconds: 3),
    borderRadius: 10,
    messageText: Text.rich(
      TextSpan(text: msg),
      style: TextStyle(color: AppColors.WHITE),
    ),
    margin: const EdgeInsets.fromLTRB(20, 5, 20, 20),
  ));
}

showValidationMsg(String msg, {Color? color}) {
  Get.showSnackbar(GetSnackBar(
    snackPosition: SnackPosition.bottom,
    backgroundColor: color ?? Colors.red,
    duration: const Duration(seconds: 2),
    borderRadius: 10,
    messageText: Text(msg, style: TextThemeHelper.validationTitle),
    margin: const EdgeInsets.fromLTRB(20, 5, 20, 20),
  ));
}

const Widget horizontalSpaceTiny = SizedBox(width: 5.0);
const Widget horizontalSpaceSmall = SizedBox(width: 10.0);
const Widget horizontalSpaceRegular = SizedBox(width: 18.0);
const Widget horizontalSpaceMedium = SizedBox(width: 25.0);
const Widget horizontalSpaceLarge = SizedBox(width: 50.0);

const Widget verticalSpaceTiny = SizedBox(height: 5.0);
const Widget verticalSpaceSmall = SizedBox(height: 10.0);
const Widget verticalSpaceRegular = SizedBox(height: 20.0);
const Widget verticalSpaceMedium = SizedBox(height: 25.0);
const Widget verticalSpaceLarge = SizedBox(height: 50.0);

hideKeyboard() {
  return FocusManager.instance.primaryFocus?.unfocus();
}

circularProgressIndi({Color? color}) {
  return CircularProgressIndicator(
    color: color ?? AppColors.PRIMARY1,
  );
}

Widget loadingAnimation({Color? color, double? size}) {
  return Center(
    child: LoadingAnimationWidget.staggeredDotsWave(
      color: color ?? AppColors.PRIMARY1,
      size: size ?? 30.ss,
    ),
  );
}
