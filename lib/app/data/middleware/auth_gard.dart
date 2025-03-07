import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../controllers/app_services_controller.dart';
import '../../routes/app_pages.dart';
import '../models/storage_box_model.dart';

class EnsureAuthentificated extends GetMiddleware {
  @override
  int get priority => 0;
  AppServicesController get appService => Get.find<AppServicesController>();

  @override
  Future<RouteDecoder?> redirectDelegate(RouteDecoder route) async {
    if (StorageBox.token.val.isEmpty) {
      //NEVER navigate to auth screen, when user is already authed
      return RouteDecoder.fromRoute(Routes.CONNECTION);
    }
    return await super.redirectDelegate(route);
  }
}

class EnsureNotAuthentificated extends GetMiddleware {
  @override
  int get priority => 0;
  AppServicesController get appService => Get.find<AppServicesController>();

  @override
  Future<RouteDecoder?> redirectDelegate(RouteDecoder route) async {
    //NEVER navigate to auth screen, when user is already authed
    String? routeName = route.pageSettings?.name;
    print("the route name $routeName");
    if (StorageBox.token.val.isNotEmpty) {
      return RouteDecoder.fromRoute(Routes.HOME);
    }
    return await super.redirectDelegate(route);
  }
}
