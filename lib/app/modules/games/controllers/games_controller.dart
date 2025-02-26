import 'package:get/get.dart';

import '../../../core/utils/enums.dart';
import '../../../core/utils/image_name.dart';
import '../../../data/models/tirage_model.dart';
import '../../../routes/app_pages.dart';
import '../providers/lotto_game_provider.dart';

class GamesController extends GetxController {
  late LottoGameProvider provider;

  List<Map<String, dynamic>> listGame = [
    {
      "id": 1,
      "label": "Bolèt",
      "image": ImgName.BOLET_GAME_IMG,
      "description": "50X 20X 10X",
      "MaterialIcon": "",
      "onTap": () {
        Get.toNamed(Routes.LOTO_GAME, arguments: Gametype.bolet);
      }
    },
    {
      "id": 2,
      "label": "maryaj",
      "image": ImgName.MARYAJ_GAME_IMG,
      "description": "1000X",
      "MaterialIcon": "",
      "onTap": () {
        Get.toNamed(Routes.LOTO_GAME, arguments: Gametype.mariaj);
      }
    },
    {
      "id": 3,
      "label": "lotto3",
      "image": ImgName.LOTTO3_GAME_IMG,
      "description": "500X",
      "MaterialIcon": "",
      "onTap": () => Get.toNamed(Routes.LOTO_GAME, arguments: Gametype.lotto3),
    },
    {
      "id": 4,
      "label": "lotto4",
      "description": "5,000X",
      "image": ImgName.LOTTO4_GAME_IMG,
      "MaterialIcon": "",
      "onTap": () => Get.toNamed(Routes.LOTO_GAME, arguments: Gametype.lotto4),
    },
    {
      "id": 5,
      "label": "lotto5",
      "description": "25,000X",
      "MaterialIcon": "",
      // "onTap": () => Get.toNamed(Routes.PLAY_LOTO, arguments: Gametype.lotto5),
    },
    {
      "id": 6,
      "label": "lotto5/5",
      "description": "200,464G",
      "MaterialIcon": "",
      // "onTap": () => Get.toNamed(Routes.PLAY_LOTO, arguments: Gametype.lotto5p5),
    },
    {
      "id": 7,
      "label": "royal5",
      "description": "1,021,649G",
      "MaterialIcon": "",
      // "onTap": () => Get.toNamed(Routes.PLAY_LOTO, arguments: Gametype.royal5),
    },
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
