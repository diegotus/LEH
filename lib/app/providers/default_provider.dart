import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../core/api_helper/urls.dart';
import '../data/models/server_response_model.dart';

class DefaultProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = '${Url.BASE_URL}api/';
    httpClient.defaultDecoder = (body) {
      return ServerResponseModel.fromMap(body ?? {"statusCode": 404});
    };
    httpClient.timeout = const Duration(seconds: 15);
    print("is kdebug $kDebugMode ${httpClient.baseUrl}");

    super.onInit();
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
