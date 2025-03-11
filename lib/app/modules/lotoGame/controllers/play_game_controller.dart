import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haiti_lotri/app/modules/games/controllers/games_controller.dart';
import 'package:haiti_lotri/app/modules/lotoGame/views/play_game_receipt_view.dart';
import 'package:haiti_lotri/app/modules/transactions/views/transaction_detail_view.dart';
import 'package:haiti_lotri/app/routes/app_pages.dart';

import '../../../data/models/game_model.dart';
import '../../../data/models/ticket_receipt_model.dart';
import '../../games/providers/lotto_game_provider.dart';

class PlayGameController extends GamesController {
  late final CarouselController carouselController;
  RxList<GameTirageModel> game = RxList.empty(growable: true);
  GameTirageModel? tempGameTirage;
  // late LottoGameProvider provider;

  @override
  void onInit() {
    provider = Get.put<LottoGameProvider>(LottoGameProvider());
    carouselController =
        CarouselController(initialItem: Get.arguments?.index ?? 0);
    super.onInit();
  }

  Future<void> callJweGameApi() async {
    var response = await provider.jweGameApi([...game.map((el) => el.toMap())]);
    if (response?.isSuccess == true) {
      Get.toNamed(Routes.TRANSACTION_DETAILS,
          parameters: {"id": response!.data['transactionId'].toString()});

      game.clear();
    }
    response?.showMessage();
  }

  Future<TicketReceiptModel?> callTicketReceiptApi(int id) async {
    var response = await provider.ticketReceiptApi(id);
    if (response?.isSuccess == true) {
      return TicketReceiptModel.fromMap(response!.data);
    }
    response?.showMessage();
    return null;
  }
}
