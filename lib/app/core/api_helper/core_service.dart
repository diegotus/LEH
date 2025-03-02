// ignore_for_file: unused_catch_clause, constant_identifier_names, prefer_typing_uninitialized_variables, depend_on_referenced_packages

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/server_response_model.dart';
import '../utils/device_manager/screen_constants.dart';
import 'app_exception.dart';
import 'urls.dart';

class CoreService {
  static ServerResponseModel returnResponse(Response response) {
    debugPrint("API Request : ${response.statusText}");
    debugPrint("API Response : ${response.body} ");
    debugPrint("API Response url: ${response.request?.url} ");
    var body = response.body;
    switch (response.statusCode) {
      case 200:
      case 201:
      case 400:
      case 422:
      case 403:
        if (body != null) {
          var responseJson = body;
          debugPrint("Result : $responseJson");

          return responseJson!;
        }
        return ServerResponseModel(
            statusCode: response.statusCode!,
            error: response.statusText,
            message: [
              "Error occurred while Communication with Server",
              'StatusCode :${response.statusCode}',
            ]);
      case 401:
        // final StorageLocalService storageLocalService = StorageLocalService();

        // storageLocalService.setAuthTokenSF(authToken: "");
        // storageLocalService.setUserIdSF(value: 0);
        // storageLocalService.setUserNameSF(name: "");

        if (body is ServerResponseModel &&
            body.getMessage() == 'Not authenticated') {
          throw UnauthorisedException.userNotLogin();
        }

        throw UnauthorisedException(body.getMessage());
      case 500:
      default:
        throw FetchDataException(
          'Error occurred while Communication with Server ${response.statusCode == null ? '' : 'with StatusCode :${response.statusCode}'}',
        );
    }
  }

  Future<bool> networkCheck() async {
    try {
      final result = await InternetAddress.lookup('$Url.baseUrl');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return false;
      } else {
        return true;
      }
    } on SocketException catch (_) {
      return true;
    }
  }

  Widget normalLoader() {
    return Center(
        child: Container(
            height: ScreenConstant.sizeXXL,
            width: ScreenConstant.sizeXXL,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(40))),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 1.5,
              ),
            )));
  }
}
