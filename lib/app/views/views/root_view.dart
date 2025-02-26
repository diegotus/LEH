import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class RootView extends GetView {
  const RootView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetRouterOutlet(
        initialRoute: Routes.CONNECTION,
        anchorRoute: Routes.ROOT,
      ),
    );
  }
}
