// To parse this JSON data, do
//
//     final ResponseModel = ResponseModelFromJson(jsonString);

abstract class ResponseModel<T> {
  int statusCode;
  List<String> message;
  T data;

  ResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });
}
