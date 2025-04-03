import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/formatters/extension.dart';
import 'package:haiti_lotri/app/data/models/ticket_model.dart';
import 'package:haiti_lotri/app/global_widgets/infinite_list.dart'
    show InfiniteListController;
import 'package:nestjs_prisma_pagination/nestjs_prisma_pagination.dart'
    show DateRangeOptions, NestJSPrismaPagination, PColumn, Search, SearchType;

import '../../../controllers/app_services_controller.dart';
import '../../../core/utils/actions/overlay.dart' show showOverlay;
import '../../../core/utils/enums.dart';
import '../../../data/models/paginate_data_model.dart' show PaginateListData;
import '../../../data/models/payment_receipt_model.dart';
import '../../../data/models/transaction_model.dart';
import '../../../data/models/user_detail_model.dart';
import '../providers/transactions_provider.dart';

class TransactionsController extends GetxController {
  late TransactionsProvider provider;
  final appServiceController = Get.find<AppServicesController>();
  // FirebaseServices get firebaseService => Get.find<FirebaseServices>();
  Rx<UserDetailModel?> get userDetails => appServiceController.userDetails;
  int? get userID => userDetails.value?.id;
  String? get email => userDetails.value?.email;
  String? get phone => userDetails.value?.phone;
  late NestJSPrismaPagination pagination;
  late final InfiniteListController<TransactionModel> infiniteListController;
  @override
  onInit() {
    provider = Get.put(TransactionsProvider());
    pagination = NestJSPrismaPagination(skip: 0, take: 100, columns: [
      PColumn(
        name: "type",
        search: Search(type: SearchType.equal, value: null),
      ),
    ]);
    infiniteListController = Get.put<InfiniteListController<TransactionModel>>(
        InfiniteListController<TransactionModel>(future: futureRequest));
    super.onInit();
  }

  onPage({bool clear = false}) {
    pagination.skip = clear ? 0 : pagination.take! + pagination.skip!;
  }

  Future<PaginateListData<TransactionModel>> futureRequest() async {
    var response =
        await provider.getTransactions(params: pagination.paginate());
    if (response?.isSuccess == true) {
      return PaginateListData(
        items: TransactionModel.fromList(response!.data),
        total: response.total ?? 0,
      );
    } else {
      response?.showMessage();
      return Future.error("Something went Wrrong");
    }
  }

  Future<PaymentReceiptData?> getTransactionDetail(int id) async {
    var response = await provider.getTransactionDetailAPI(id: id);
    if (response?.isSuccess == true) {
      return PaymentReceiptData.fromMap(response!.data);
    }
    return null;
  }

  Future<List<TicketModel>> callTicketApi(trasnactionId) async {
    var response = await provider.ticketApi(trasnactionId);
    if (response?.isSuccess == true) {
      return listTicketModel(response!.data);
    }
    response?.showMessage();
    return [];
  }

  void updateDate(DateTime? date) {
    if (date == null) {
      pagination.dateRange = null;
    } else {
      pagination.dateRange = DateRangeOptions(
        from: date.startOfDay.toUtc(),
        to: date.startOfDay.toUtc(),
        name: 'created_at',
      );
    }
    showOverlay(
      asyncFunction: () => infiniteListController.callApiData(
        callBack: () => onPage(clear: true),
      ),
    );
  }

  void updateColumn(TransactionType? type) {
    pagination.columns![0].search.value = type?.name;

    showOverlay(
      asyncFunction: () => infiniteListController.callApiData(
        callBack: () => onPage(clear: true),
      ),
    );
  }
}
