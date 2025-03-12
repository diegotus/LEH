import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../controllers/app_services_controller.dart';
import '../../../../data/models/storage_box_model.dart';
import '../../../../data/models/user_model.dart';
import '../../providers/connection_provider.dart';

class LoginController extends GetxController {
  late final ConnectionProvider provider;
  String email = "";
  String password = "";
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  @override
  onInit() {
    provider = Get.find<ConnectionProvider>();
    super.onInit();
  }

  Future<void> logInApiCall() async {
    isLoading.value = true;
    try {
      var response = await provider.signIn(
        email.trim(),
        password.trim(),
        StorageBox.fmcToken.val,
      );
      if (response?.isSuccess == true) {
        var userData = UserData.fromMap(response!.data!);
        var appservice = Get.find<AppServicesController>();
        appservice.saveUserData(userData.userDetails);
        StorageBox.token.val = userData.authToken ?? '';

        response.showMessage();
      } else {
        // response?.showMessage();
      }
      isLoading.value = false;
    } catch (e) {
      Get.log(e.toString(), isError: true);
      isLoading.value = false;
    }
  }
}
