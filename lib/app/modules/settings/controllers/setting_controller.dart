import 'package:get/get.dart';

import '../../../controllers/app_services_controller.dart';
import '../../../controllers/def_controller.dart';

import '../../../data/models/document_model.dart';
import '../../../data/models/storage_box_model.dart';
import '../../../data/models/user_detail_model.dart';
import '../../../data/models/user_profil_update_model.dart';
import '../../../providers/app_service_provider.dart';

class SettingController extends GetxController with DefController {
  final provider = Get.find<AppServiceProvider>();

  Future<void> uploadFile(FileData file) async {
    var response = await provider.uploadProfilPicture(file);
    if (response?.isSuccess == true) {
      await 1.delay();
      response = await provider.updateUserProfile(
        profil: UserProfilUpdate(
          avatar: response!.data["file_id"]['id'],
          name: userDetails.value?.name,
          phone: userDetails.value?.phone,
        ),
      );

      if (response?.isSuccess == true) {
        userDetails.value = UserDetailModel.fromMap(response!.data);
        Get.find<AppServicesController>().saveUserData(userDetails.value);
      }
    }
    response?.showMessage();
  }

  Future<void> updateUserInfo(String newLangage) async {
    if (StorageBox.locale.val != newLangage) {
      var response = await provider.updateUserInfo(locale: newLangage);
      if (response?.isSuccess == true) {
        await Get.find<AppServicesController>().getUserDetails();
        response?.showMessage();
      }
    }
  }

  Future<void> signOut() async {
    var response = await provider.signOutApi();
    if (response?.isSuccess == true) {
      print("success loging");
      Get.find<AppServicesController>().clearCurrentUser();
      response?.showMessage();
    }
  }
}
