import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/image_name.dart';
import 'package:sizing/sizing.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_string.dart';
import '../../../core/utils/app_utility.dart';
import '../../../core/utils/text_teme_helper.dart';
import '../../../global_widgets/app_button.dart';
import '../../../routes/app_pages.dart';
import '../controllers/connection_controller.dart';

class ConnectionView extends GetView<ConnectionController> {
  const ConnectionView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.provider;
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(ImgName.LOGO, width: 150.ss),
          verticalSpaceRegular,
          Text(
            AppStrings.WELCOME,
            textAlign: TextAlign.center,
            style: TextThemeHelper.welcomeTitle,
          ),
          verticalSpaceMedium,
          customeAuthButton(
            lableName: AppStrings.LOG_IN,
            onTap: () {
              Get.toNamed(Routes.LOGIN);
            },
          ),
          verticalSpaceRegular,
          customeAuthButton2(
            lableName: AppStrings.REGISTER,
            onTap: () {
              Get.toNamed(Routes.SIGNUP);
            },
          )
        ]),
      ),
    );
  }
}
