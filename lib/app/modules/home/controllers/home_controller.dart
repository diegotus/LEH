import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/app_services_controller.dart';
import '../../../core/utils/enums.dart';
import '../../../core/utils/kiwoo_icons.dart';
import '../../../data/models/account_balance.dart';
import '../../../data/models/user_detail_model.dart';
import '../../../global_widgets/modal/bottom_sheet.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  final appServiceController = Get.find<AppServicesController>();
  final isLoading = false.obs;

  late final RxInt selectedIndex;

  List<Map<String, dynamic>> serviceListTmp = [
    {
      "id": 1,
      "label": "Cash In",
      "icon": Kiwoo.cash_in,
      "MaterialIcon": "",
      "onTap": () {
        boomSheetOptions<TransactionMethod>(options: [
          BottomSheetOption(
            label: "MonCash",
            iconColor: Colors.red,
            value: TransactionMethod.moncash,
            icon: Kiwoo.moncash,
          ),
          BottomSheetOption(
            label: "Natcash",
            value: TransactionMethod.natcash,
            icon: Kiwoo.credit_card,
          ),
          BottomSheetOption(
            label: "Credit/Debit Card",
            value: TransactionMethod.card,
            icon: Kiwoo.credit_card,
          ),
        ]).then((resp) {
          if (resp == null) return;
          Get.toNamed(Routes.CASH_IN, parameters: {'methods': resp.name});
        });
      }
    },
    {
      "id": 2,
      "label": "Send/Receive money",
      "icon": Kiwoo.send_rece_money,
      "MaterialIcon": "",
      "onTap": () {
        boomSheetOptions<String>(options: [
          BottomSheetOption(
              label: "Send Money",
              value: Routes.SEND_MONEY,
              icon: Kiwoo.cash_out),
          BottomSheetOption(
              label: "Receive Money",
              value: Routes.RECEIVE_MONEY,
              icon: Kiwoo.cash_in),
        ]).then((resp) {
          if (resp == null) return;
          Get.toNamed(resp);
        });
      }
    },
    {
      "id": 3,
      "label": "Cash-out",
      "icon": Kiwoo.cash_out,
      "MaterialIcon": "",
      "onTap": () => Get.toNamed(Routes.CASH_OUT),
    },
    {
      "id": 4,
      "label": "Transaction History",
      "icon": Kiwoo.loan_market,
      "MaterialIcon": "",
      "onTap": () => Get.toNamed(Routes.TRANSACTIONS),
    },
    {
      "id": 5,
      "label": "Profil",
      "icon": Kiwoo.person_outline,
      "MaterialIcon": "",
      "onTap": () => Get.toNamed(Routes.PROFILE),
    },
    {
      "id": 6,
      "label": "Address Market",
      "icon": Kiwoo.market_address,
      "MaterialIcon": "",
    },
  ];

  int? get userID => Get.find<AppServicesController>().userDetails.value?.id;
  Rx<UserDetailModel?> get userDetails => appServiceController.userDetails;

  String categorizeCreditScore(int creditScore) {
    if (creditScore >= 750) {
      return "Excellent";
    } else if (creditScore >= 700) {
      return "Good";
    } else if (creditScore >= 650) {
      return "Fair";
    } else if (creditScore >= 600) {
      return "Poor";
    } else {
      return "Very Poor";
    }
  }

  void getUserDetails() async {
    isLoading.value = true;
    var response = await appServiceController.provider.getUserDetails();
    if (response?.isSuccess == true) {
      appServiceController
          .saveUserData(UserDetailModel.fromMap(response!.data!));
    }
    isLoading.value = false;
  }

  Future<List<AccountBalanceModel>?> getUserBalance() async {
    var response = await appServiceController.provider.getUserBalance();
    if (response?.isSuccess == true) {
      return listAccountModelFromMap(response!.data);
    }
    return null;
  }

  @override
  void onInit() {
    int value = Get.arguments?['selectedIndex'] ?? 0;
    selectedIndex = value.obs;
    super.onInit();
  }
}
