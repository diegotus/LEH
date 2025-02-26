import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:haiti_lotri/app/routes/app_pages.dart';

import '../../../../controllers/app_services_controller.dart';
import '../../../../controllers/def_controller.dart';
import '../../../../data/models/user_profil_update_model.dart';

class ChangePasswordController extends GetxController with DefController {
  final GlobalKey<FormState> formKey = GlobalKey();
  String oldPassword = "";
  String newpassword = "";

  Future<void> changePassword() async {
    var response =
        await Get.find<AppServicesController>().provider.updateUserProfile(
              profil: UserProfilUpdate(
                oldPassword: oldPassword,
                password: newpassword,
                name: userDetails.value?.name,
                phone: userDetails.value?.phone,
              ),
            );
    if (response?.isSuccess == true) {
      await Get.find<AppServicesController>().getUserDetails();
      Get.back();
      response!.showMessage();
    } else {
      response?.showMessage();
    }
  }
}
