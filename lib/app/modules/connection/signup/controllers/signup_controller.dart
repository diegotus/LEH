import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/formatters/validation.dart';
import '../../../../data/models/signup_model.dart';
import '../../../../routes/app_pages.dart';
import '../../providers/connection_provider.dart';

class SignupController extends GetxController {
  late final ConnectionProvider provider;
  final formKey = GlobalKey<FormState>();
  String name = "";
  String email = "";
  String phone = "";
  String password = "";

  late RxBool isLoading;
  @override
  void onInit() {
    isLoading = RxBool(false);
    provider = Get.find<ConnectionProvider>();
    super.onInit();
  }

  Future signupApiCall() async {
    try {
      var response = await provider.signup(
        name.trim(),
        phone,
        email.trim(),
        password.trim(),
      );
      if (response?.isSuccess == true) {
        var signupData = SignupModel.fromMap(response!.data!);
        showMsg(
          signupData.message ?? "Otp sent to ${signupData.email} successfully",
          color: AppColors.SUCCESS,
        );
        Get.offNamedUntil(
            Routes.LOGIN, (page) => page.name == Routes.CONNECTION);
      } else {
        Get.backLegacy(closeOverlays: true);
        response?.showMessage(
          message: (response.message).isNotEmpty
              ? response.message
              : ['Server issue Please Try again or revisit the screen. '],
        );
      }
    } catch (e) {
      Get.backLegacy(closeOverlays: true);
      Get.log("$e", isError: true);
      isLoading.value = false;
    }
  }
}
