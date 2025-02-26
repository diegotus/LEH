import 'package:get/get.dart';

import '../controllers/play_game_controller.dart';

class PlayGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayGameController>(
      () => PlayGameController(),
    );
  }
}
