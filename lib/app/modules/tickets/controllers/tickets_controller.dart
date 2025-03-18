// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:get/get.dart';

import 'package:haiti_lotri/app/data/models/ticket_model.dart';

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

  Future<List<TicketModel>> callGetTicketsApi(
      TicketFilter value, bool winOnly) async {
    var response = await provider.getTicketsApi(
        winOnly: winOnly, date: value.dateSelected);
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
