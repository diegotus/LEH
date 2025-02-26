import 'package:get/get.dart';

import '../../../controllers/app_services_controller.dart';
import '../../../controllers/def_controller.dart';

import '../../../data/models/document_model.dart';
import '../../../data/models/user_detail_model.dart';
import '../../../data/models/user_profil_update_model.dart';
import '../../../providers/app_service_provider.dart';

class ProfileController extends GetxController with DefController {
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
}
