import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart' show Request;
import 'package:haiti_lotri/app/data/models/storage_box_model.dart';

import '../core/api_helper/urls.dart';
import '../data/models/server_response_model.dart';

class DefaultProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = '${Url.BASE_URL}api/';
    httpClient.defaultDecoder = (body) {
      return ServerResponseModel.fromMap(body ?? {"statusCode": 404});
    };
    httpClient.addRequestModifier(requestModifier);
    httpClient.timeout = const Duration(seconds: 15);
    super.onInit();
  }

  Request requestModifier(Request request) {
    request.headers['x-custom-lang'] = StorageBox.locale.val;
    return request;
  }

  @override
  Future<Response<T>> patch<T>(String url, body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress}) {
    return request<T>(url, "PATCH",
        body: body,
        contentType: contentType,
        headers: headers,
        query: query,
        decoder: decoder,
        uploadProgress: uploadProgress);
  }
}
