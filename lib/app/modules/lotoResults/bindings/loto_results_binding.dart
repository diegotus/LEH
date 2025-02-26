import 'package:get/get.dart';
import 'package:haiti_lotri/app/modules/games/providers/lotto_game_provider.dart';

import '../controllers/loto_results_controller.dart';

class LotoResultsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LottoGameProvider>(
      () => LottoGameProvider(),
    );
    Get.lazyPut<LotoResultsController>(
      () => LotoResultsController(),
    );
  }
}
