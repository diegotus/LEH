// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/formatters/extension.dart';
import 'package:haiti_lotri/app/data/models/paginate_data_model.dart';

import 'package:haiti_lotri/app/data/models/ticket_model.dart';
import 'package:nestjs_prisma_pagination/nestjs_prisma_pagination.dart'
    show DateRangeOptions, NestJSPrismaPagination, PColumn, Search, SearchType;

import '../../../core/utils/actions/overlay.dart' show showOverlay;
import '../../../global_widgets/infinite_list.dart' show InfiniteListController;
import '../../games/providers/lotto_game_provider.dart';

class TicketFilter {
  final DateTime? dateSelected;
  final String? selectedFilter;
  TicketFilter({
    this.dateSelected,
    this.selectedFilter,
  });

  @override
  String toString() =>
      'TicketFilter(dateSelected: $dateSelected, selectedFilter: $selectedFilter)';

  TicketFilter copyWith({
    DateTime? dateSelected,
    String? selectedFilter,
  }) {
    return TicketFilter(
      dateSelected: dateSelected,
      selectedFilter: selectedFilter,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateSelected': dateSelected?.millisecondsSinceEpoch,
      'selectedFilter': selectedFilter,
    };
  }

  factory TicketFilter.fromMap(Map<String, dynamic> map) {
    return TicketFilter(
      dateSelected: map['dateSelected'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateSelected'] as int)
          : null,
      selectedFilter: map['selectedFilter'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TicketFilter.fromJson(String source) =>
      TicketFilter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant TicketFilter other) {
    if (identical(this, other)) return true;

    return other.dateSelected == dateSelected &&
        other.selectedFilter == selectedFilter;
  }

  @override
  int get hashCode => dateSelected.hashCode ^ selectedFilter.hashCode;
}

class TicketsController extends GetxController {
  late final LottoGameProvider provider;
  final count = 0.obs;
  final winTickets = false.obs;
  final dateFilter = TicketFilter().obs;

  late NestJSPrismaPagination pagination;
  late final InfiniteListController<TicketModel> futureListController;

  Future<PaginateListData<TicketModel>> callGetTicketsApi() async {
    var response = await provider.getTicketsApi(params: pagination.paginate());
    if (response?.isSuccess == true) {
      return PaginateListData(
          items: listTicketModel(response!.data), total: response.total ?? 0);
    } else {
      response?.showMessage();
      return Future.error("Something went Wrrong");
    }
  }

  onPage({bool clear = false}) {
    pagination.skip = clear ? 0 : pagination.take! + pagination.skip!;
  }

  void addColumn(bool add) {
    if (add) {
      pagination.columns!.add(PColumn(
        name: "winTransactionId",
        search: Search(type: SearchType.isNotEmpy, value: ''),
      ));
    } else {
      pagination.columns?.clear();
    }
    showOverlay(
      asyncFunction: () => futureListController.callApiData(
        callBack: () => onPage(clear: true),
      ),
    );
  }

  void updateDate(DateTime? date) {
    if (date == null) {
      pagination.dateRange = null;
    } else {
      pagination.dateRange = DateRangeOptions(
        from: date.startOfDay.toUtc(),
        to: date.startOfDay.toUtc(),
        name: 'createdAt',
      );
    }
    showOverlay(
      asyncFunction: () => futureListController.callApiData(
        callBack: () => onPage(clear: true),
      ),
    );
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
    pagination = NestJSPrismaPagination(skip: 0, take: 100, columns: [
      PColumn(
        name: "winTransactionId",
        search: Search(type: SearchType.isNotEmpy, value: null),
      ),
    ]);
    futureListController = Get.put<InfiniteListController<TicketModel>>(
        InfiniteListController<TicketModel>(future: callGetTicketsApi));
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
