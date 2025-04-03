import 'package:get/get.dart';
import 'package:haiti_lotri/app/data/models/tchala_model.dart';
import 'package:haiti_lotri/app/providers/app_service_provider.dart';
import 'package:nestjs_prisma_pagination/nestjs_prisma_pagination.dart'
    show NestJSPrismaPagination, PColumn, Search, SearchType;

import '../../../data/models/paginate_data_model.dart' show PaginateListData;
import '../../../global_widgets/infinite_list.dart';

class TchalaController extends GetxController {
  late AppServiceProvider provider;
  late final NestJSPrismaPagination pagination;
  late final InfiniteListController<TchalaModel> futureListController;
  @override
  void onInit() {
    provider = Get.find<AppServiceProvider>();
    pagination = NestJSPrismaPagination(skip: 0, take: 100, columns: [
      PColumn(
        name: "label",
        search: Search(
          type: SearchType.contains,
          value: null,
        ),
      )
    ]);
    futureListController =
        Get.put(InfiniteListController<TchalaModel>(future: futureRequest));
    super.onInit();
  }

  @override
  onReady() {
    super.onReady();
  }

  Future<PaginateListData<TchalaModel>> futureRequest() async {
    var response =
        await provider.getTchalaList(pagination: pagination.paginate());
    var paginate = PaginateListData<TchalaModel>(items: [], total: 0);
    if (response?.isSuccess == true) {
      var data = paginate.copyWith(
          items: listTchalaModel(response!.data), total: response.total ?? 0);

      return data;
    }

    return paginate;
  }

  onPage({bool clear = false}) {
    pagination.skip = clear ? 0 : pagination.take! + pagination.skip!;
  }

  void onSearch(String? search) {
    pagination.skip = 0;
    pagination.columns?[0].search.value =
        (search ?? '').isEmpty ? null : search;
  }
}
