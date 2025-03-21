import 'package:get/get.dart';
import 'package:haiti_lotri/app/data/models/tchala_model.dart';
import 'package:haiti_lotri/app/providers/app_service_provider.dart';

import '../../../global_widgets/future_list_widget.dart';

class TchalaController extends GetxController {
  late AppServiceProvider provider;
  int currentPage = 1;

  bool isLoading = false;

  final RxList<TchalaModel> items = RxList<TchalaModel>.empty(growable: true);
  @override
  void onInit() {
    provider = Get.find<AppServiceProvider>();

    super.onInit();
  }

  @override
  onReady() {
    super.onReady();
  }

  Future<PaginateListData<TchalaModel>> futureRequest(int page,
      [String? label]) async {
    var response =
        await provider.getTchalaList(page: page, perPage: 100, search: label);
    var paginate = PaginateListData<TchalaModel>(items: [], total: 0);
    if (response?.isSuccess == true) {
      var data = paginate.copyWith(
          items: listTchalaModel(response!.data), total: response.total ?? 0);

      return data;
    }

    return paginate;
  }
}
