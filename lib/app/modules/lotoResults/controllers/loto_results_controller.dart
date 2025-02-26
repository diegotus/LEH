import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/enums.dart';
import '../../../data/models/tirage_model.dart';
import '../../games/providers/lotto_game_provider.dart';

class LotoResultsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;
  late final LottoGameProvider _provider;
  final count = 0.obs;
  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    _provider = Get.find<LottoGameProvider>();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future<List<ResultTirageModel>> callResultTirajApi(TirageName tirage) async {
    var response = await _provider.resultTirajApi(tirage.name);
    if (response?.isSuccess == true) {
      return listResultTirageModel(response!.data);
    }
    response?.showMessage();
    return Future.error("Something went Wrrong");
  }
}
