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
    String? routeName = route.pageSettings?.path;
    if (StorageBox.token.val.isNotEmpty) {
      if (routeName?.isEmpty == true ||
          routeName == Routes.ROOT ||
          (routeName?.contains(Routes.CONNECTION) ?? false)) {
        return RouteDecoder.fromRoute(Routes.HOME);
      }
      return route;

      //OR redirect user to another screen
      //return RouteDecoder.fromRoute(Routes.PROFILE);
    }
    return await super.redirectDelegate(route);
  }
}

class CheckAuthentificated extends GetMiddleware {
  @override
  int get priority => 0;
  AppServicesController get appService => Get.find<AppServicesController>();

  @override
  RouteSettings? redirect(String? route) {
    //NEVER navigate to auth screen, when user is already authed
    print("is not empu");
    if (StorageBox.token.val.isEmpty) {
      return RouteSettings(name: Routes.HOME);

      //OR redirect user to another screen
      //return RouteDecoder.fromRoute(Routes.PROFILE);
    }
    return null;
  }
}
