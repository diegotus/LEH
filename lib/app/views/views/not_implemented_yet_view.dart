import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/app_string.dart';

import '../../global_widgets/custom_appbar.dart';

class NotImplementedYetView extends GetView {
  const NotImplementedYetView({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context,
        title,
        true,
        true,
        const [],
        () {},
      ),
      body: Center(
        child: Text(
          AppStrings.NOT_IMPLEMENTED,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
