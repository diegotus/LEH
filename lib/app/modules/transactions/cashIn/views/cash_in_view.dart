import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/app_string.dart';

import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/enums.dart';
import '../../../../global_widgets/custom_appbar.dart';
import '../controllers/cash_in_controller.dart';
import 'moncash_view.dart';

class CashInView extends GetView<CashInController> {
  const CashInView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context,
        AppStrings.LABEL_CASH_IN,
        true,
        true,
        const [],
        () {},
      ),
      body: bodyWidet(),
    );
  }

  Widget bodyWidet() {
    switch (controller.method) {
      case TransactionMethod.moncash:
        return const MoncashView();

      default:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(AppStrings.UNAVAILABLE_METHOD),
            verticalSpaceRegular,
            Center(
                child: FilledButton(
                    onPressed: Get.back, child: Text(AppStrings.BACK))),
          ],
        );
    }
  }
}
