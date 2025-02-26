import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/app_colors.dart';
import '../custom_appbar.dart';

class CashIn extends GetWidget {
  const CashIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.APP_BG,
      appBar: CustomAppBar(
        context,
        "Cash In",
        true,
        true,
        const [],
        () {},
      ),
    );
  }
}
