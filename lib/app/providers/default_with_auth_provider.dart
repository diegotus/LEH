import 'package:get/get_connect/http/src/request/request.dart';

import '../data/models/storage_box_model.dart';
import 'default_provider.dart';

class DefaultWithAuthProvider extends DefaultProvider {
  String? get token => StorageBox.token.val;
  @override
  void onInit() {
    // httpClient.addRequestModifier(_autoeh);

    super.onInit();
  }

  @override
  Request requestModifier(Request request) {
    request.headers['Authorization'] = "Bearer $token";
    return super.requestModifier(request);
  }
}
