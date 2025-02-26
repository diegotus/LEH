import 'package:get/get.dart';

import '../data/models/storage_box_model.dart';
import '../data/models/user_detail_model.dart';
import 'app_services_controller.dart';

mixin class DefController {
  final appServiceController = Get.find<AppServicesController>();
  // FirebaseServices get firebaseService => Get.find<FirebaseServices>();
  Rx<UserDetailModel?> get userDetails => appServiceController.userDetails;
  int? get userID => userDetails.value?.id;
  String? get email => userDetails.value?.email;
  String? get phone => userDetails.value?.phone;
  String? get token => StorageBox.token.val;
  ExtraInfo? get getExtraInfo => userDetails.value?.extraInfo;
}
