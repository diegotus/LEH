// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final loginModel = ServerResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart' show Get, Inst, SnackbarController;

import '../../controllers/app_services_controller.dart';
import '../../core/utils/app_utility.dart';
import '../../core/utils/response_server_code.dart';

class ServerResponseModel {
  int statusCode;
  String? error;
  List<String> message;
  dynamic data;
  bool get isSuccess =>
      statusCode == StatusResponse.SUCCESS ||
      statusCode == StatusResponse.SUCCESS_201;

  ServerResponseModel({
    required this.statusCode,
    this.error,
    required this.message,
    this.data,
  });
  SnackbarController? showMessage({List<String>? message}) {
    var msg = (message ?? this.message);
    if (msg.isNotEmpty) {
      if (error != null) {
        Get.find<AppServicesController>().errorMsg.value = msg.join("\n");
      } else {
        return showMsg(
          msg.join("\n"),
        );
      }
    }
    return null;
  }

  String getMessage() {
    return message.join('\n');
  }

  ServerResponseModel copyWith({
    int? statusCode,
    String? error,
    List<String>? message,
    Map<String, dynamic>? data,
  }) {
    return ServerResponseModel(
      statusCode: statusCode ?? this.statusCode,
      error: error ?? this.error,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusCode': statusCode,
      'error': error,
      'message': message,
      'data': data,
    };
  }

  factory ServerResponseModel.fromMap(Map<String, dynamic> map) {
    return ServerResponseModel(
      statusCode: map['statusCode'] as int,
      error: map['error'] != null ? map['error'] as String : null,
      message: List<String>.from(((map['message'] is String
          ? [map['message']]
          : map['message'] ?? []))),
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ServerResponseModel.fromJson(String source) =>
      ServerResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ServerResponseModel(statusCode: $statusCode, error: $error, message: $message, data: $data)';
  }

  @override
  bool operator ==(covariant ServerResponseModel other) {
    if (identical(this, other)) return true;

    return other.statusCode == statusCode &&
        other.error == error &&
        listEquals(other.message, message) &&
        mapEquals(other.data, data);
  }

  @override
  int get hashCode {
    return statusCode.hashCode ^
        error.hashCode ^
        message.hashCode ^
        data.hashCode;
  }
}
