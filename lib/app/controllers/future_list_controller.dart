import 'dart:async' show StreamController, Timer;

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nestjs_prisma_pagination/nestjs_prisma_pagination.dart';

import '../data/models/paginate_data_model.dart' show PaginateListData;

abstract class FutureListController<T> extends GetxController {
  List<T> items = [];
  Timer? debounce;
  bool isLoading = false;
  int? total;
  bool get endPage => items.length == total;
  StreamController<List<T>> get streamController => _streamController;
  late StreamController<List<T>> _streamController;
  NestJSPrismaPagination? pagination;
  void Function(String? search)? onSearch;

  Future<PaginateListData<T>> callListApi();
  onPage({bool clear = false});

  String search = '';
  @override
  onInit() {
    _streamController = StreamController<List<T>>();
    getData();
    super.onInit();
  }

  @override
  onClose() {
    _streamController.close();
    debounce?.cancel();
    super.onClose();
  }

  Future<void> getData([bool nextPage = false]) async {
    isLoading = true;

    final response = await callListApi();
    isLoading = false;
    total = response.total;
    if (!nextPage) {
      items.clear();
    }
    items.addAll(response.items);

    _streamController.add(items);
    // _streamController.add(response.items);
  }
}
