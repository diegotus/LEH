import 'package:get/get.dart';

import '../app_utility.dart';

Future<T> showOverlay<T>({required Future<T> Function() asyncFunction}) async {
  var response = Get.showOverlay<T>(
    asyncFunction: asyncFunction,
    loadingWidget: loadingAnimation(),
  );
  return response;
}
