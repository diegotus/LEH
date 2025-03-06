import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/enums.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../data/models/signup_model.dart';
import '../../../../routes/app_pages.dart';
import '../../providers/connection_provider.dart';

class NewPasswordController extends GetxController {
  final provider = Get.put(ConnectionProvider());
  var formKey = GlobalKey<FormState>();

  late final String email;
  String newPassword = "";

  final enableResend = RxBool(false);
  @override
  void onInit() {
    email = Get.arguments;
    print("the arguments ${Get.arguments}");
    print("the arguments args ${Get.args<String>()}");
    print("the arguments args ${Get.rootController.rootDelegate.arguments()}");
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future resetPassword() async {
    var response = await provider.resetPassword(email, newPassword);
    if (response?.isSuccess == true) {
      Get.offNamedUntil(
          Routes.LOGIN, (predicate) => predicate.name == Routes.CONNECTION);
      response!.showMessage();
    } else {
      Get.backLegacy(closeOverlays: true);
    }
  }
}
