import 'package:get/get_rx/get_rx.dart';

mixin ControllerWithFuture<T> {
  late Rx<Future<T?>> futureData;

  Future<void> refreshFuture() async {
    futureData = futureRequest().obs;
  }

  Future<T?> futureRequest();
}
