import 'package:flutter/material.dart';

import 'package:get/get.dart';

class RootView extends GetView {
  const RootView({super.key, required this.initialRoute, this.anchorRoute});
  final String initialRoute;
  final String? anchorRoute;
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet(
      initialRoute: initialRoute,
      anchorRoute: anchorRoute,
      filterPages: (pages) {
        var ret = pages.toList();
        ret = ret.where((e) => e.participatesInRootNavigator != true).toList();
        return ret;
      },
    );
  }
}
