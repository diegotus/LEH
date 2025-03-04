import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/app_string.dart';
import 'package:haiti_lotri/app/views/views/not_implemented_yet_view.dart';

import '../controllers/cash_out_controller.dart';

class CashOutView extends GetView<CashOutController> {
  const CashOutView({super.key});
  @override
  Widget build(BuildContext context) {
    return NotImplementedYetView(title: AppStrings.LABEL_CASH_OUT);
  }
}
