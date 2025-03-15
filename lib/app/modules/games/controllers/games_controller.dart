import 'package:get/get.dart';
import 'package:haiti_lotri/app/modules/games/model/game_widget_model.dart';

import '../../../core/utils/enums.dart';
import '../../../core/utils/image_name.dart';
import '../../../data/models/tirage_model.dart';
import '../../../routes/app_pages.dart';
import '../providers/lotto_game_provider.dart';

class GamesController extends GetxController {
  late LottoGameProvider provider;

  List<GameWidgetModel> listGame = [
    GameWidgetModel(
      type: Gametype.bolet,
      image: ImgName.BOLET_GAME_IMG,
    ),
    GameWidgetModel(
      type: Gametype.mariaj,
      image: ImgName.MARYAJ_GAME_IMG,
    ),
    GameWidgetModel(
      type: Gametype.lotto3,
      image: ImgName.LOTTO3_GAME_IMG,
    ),
    GameWidgetModel(
      type: Gametype.lotto4,
      image: ImgName.LOTTO4_GAME_IMG,
    ),
    GameWidgetModel(
      type: Gametype.lotto5,
      image: ImgName.LOTTO5_GAME_IMG,
    ),
    GameWidgetModel(
      type: Gametype.lotto5p5,
      image: ImgName.LOTTO55_GAME_IMG,
    ),
    GameWidgetModel(
      type: Gametype.royal5,
      image: ImgName.ROYAL5_GAME_IMG,
    ),
  ];

  @override
  void onInit() {
    provider = Get.put<LottoGameProvider>(LottoGameProvider());
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<List<NextTirageModel>> callNextTiragesAPI() async {
    var response = await provider.getNextTirageApi();
    if (response?.isSuccess == true) {
      return listNextTirageModel(response!.data);
    }
    return [];
  }
}
