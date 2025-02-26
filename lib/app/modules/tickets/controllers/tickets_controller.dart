import 'package:get/get.dart';
import 'package:haiti_lotri/app/data/models/ticket_model.dart';

import '../../games/providers/lotto_game_provider.dart';

class TicketsController extends GetxController {
  late final LottoGameProvider provider;
  final count = 0.obs;

  Future<List<TicketModel>> callGetTicketsApi() async {
    var response = await provider.getTicketsApi();
    if (response?.isSuccess == true) {
      return listTicketModel(response!.data);
    } else {
      response?.showMessage();
      return Future.error("Something went Wrrong");
    }
  }

  Future<List<BoulJweModel>> callGetTicketDetailApi(int id) async {
    var response = await provider.getTicketDetailApi(id);
    if (response?.isSuccess == true) {
      return listBoulJweModel(response!.data);
    } else {
      response?.showMessage();
      return Future.error("Something went Wrrong");
    }
  }

  @override
  void onInit() {
    provider = Get.put<LottoGameProvider>(LottoGameProvider());

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
