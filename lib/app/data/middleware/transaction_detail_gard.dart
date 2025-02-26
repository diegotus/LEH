import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class TransactionDetailGard extends GetMiddleware {
  @override
  int get priority => 0;

  @override
  Future<RouteDecoder?> redirectDelegate(RouteDecoder route) async {
    if (route.parameters['id'] == null ||
        int.tryParse("${route.parameters['id']}") == null) {
      return RouteDecoder.fromRoute(Routes.TRANSACTIONS);
    }
    return route;
  }
}
