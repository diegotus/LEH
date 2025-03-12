import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';

import '../core/utils/app_utility.dart';
import '../core/utils/storage_pro.dart';
import '../data/models/account_balance.dart';
import '../data/models/server_response_model.dart';
import '../data/models/storage_box_model.dart';
import '../data/models/user_detail_model.dart';
import '../data/models/user_model.dart';
import '../providers/app_service_provider.dart';
import '../routes/app_pages.dart';

class AppServicesController extends GetxService
    with WidgetsBindingObserver, StorageBox {
  late final AppServiceProvider provider;
  // late String? fmcToken;
  late final RxInt totalUnReadMessage;
  late final RxString errorMsg;
  late Rx<UserDetailModel?> userDetails;
  late Rx<UserDetailModel?> acountBalance;
  late Locale appLocale;

  Worker? errorWorker;
  RxBool connectionStatus = false.obs;

  @override
  void onInit() {
    appLocale = Locale("fr");
    provider = Get.put(AppServiceProvider(), permanent: true);
    errorMsg = ''.obs;
    errorWorker = ever(errorMsg, (msg) {
      showMsg(msg, color: Colors.red);
    }, condition: () => errorMsg.isNotEmpty);
    var currentUser = getObjectById<CurrentUser>('currentUser');
    userDetails = Rx<UserDetailModel?>(currentUser?.userDetails);
    // clearCurrentUser();
    addKeysListenter();
    super.onInit();
  }

  @override
  void onReady() {
    if (userDetails.value != null) {
      addCurrentUserListener();
      if (StorageBox.token.val.isNotEmpty) getUserDetails();
    }

    super.onReady();
  }

  @override
  void onClose() async {
    errorWorker?.dispose();
    Get.delete<AppServiceProvider>(force: true);
    super.onClose();
  }

  Future<ServerResponseModel?> getUserDetails() async {
    var response = await provider.getUserDetails();
    if (response?.isSuccess == true) {
      saveUserData(UserDetailModel.fromMap(response!.data!));
    }
    return response;
  }

  void addKeysListenter() {
    StorageBox.boxKeys().listenKey("locale", (value) async {
      if (value != Get.locale?.languageCode) {
        await Get.updateLocale(Locale(value));
      }
    });
    StorageBox.boxKeys().listenKey("token", (value) {
      var currentRoute = Get.rootController.rootDelegate.pageSettings?.name ??
          Get.currentRoute;

      if (value == null) {
        if (currentRoute != Routes.CONNECTION) {
          Get.offAllNamed(Routes.CONNECTION);
        }
      } else if (currentRoute.contains(Routes.CONNECTION)) {
        Get.offAllNamed(Routes.HOME);
      }
    });
  }

  void addCurrentUserListener() {
    GetStoragePro.listenForObjectChanges<CurrentUser>(
      id: 'currentUser',
      onData: (model) {
        userDetails.value = model?.userDetails;
        if (userDetails.value != null) {
          StorageBox.locale.val =
              userDetails.value!.extraInfo!.locale.languageCode;
        }
      },
    );
  }

  void saveUserData(UserDetailModel? userDetails) {
    var currentUser = CurrentUser(userDetails: this.userDetails.value);
    GetStoragePro.saveObject<CurrentUser>(
        currentUser.copyWith(userDetails: userDetails?.copyWith()));

    if (this.userDetails.value == null) {
      addCurrentUserListener();
    }
  }

  Future<List<AccountBalanceModel>?> getUserBalance() async {
    var response = await provider.getUserBalance();
    if (response?.isSuccess == true) {
      return listAccountModelFromMap(response!.data);
    }
    return null;
  }

  Future<void> clearCurrentUser() async {
    try {
      GetStoragePro.saveObject<CurrentUser>(CurrentUser());
      await StorageBox.removeToken();
    } catch (e) {
      Get.log("the error >>> $e", isError: true);
    }
  }
}
