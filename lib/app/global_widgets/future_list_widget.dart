// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/actions/overlay.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/app_utility.dart';
import 'custom_refresh_indicator.dart';
import 'input_field.dart';
import 'scroll_widget.dart';

class FutureListWidget<T> extends GetWidget<FutureListWidgetController<T>> {
  FutureListWidget({
    super.key,
    required this.itemBuilder,
    required Future<PaginateListData<T>> Function(int page, [String search])
        future,
  }) {
    Get.put<FutureListWidgetController<T>>(
        FutureListWidgetController<T>(future));
  }
  final Widget? Function(BuildContext, T) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchCustomInputFormField(
            borderColor: AppColors.PRIMARY2,
            width: double.infinity,
            height: 40,
            onChanged: (value) {
              if (controller._debounce?.isActive ?? false) {
                controller._debounce?.cancel();
              }
              controller._debounce =
                  Timer(const Duration(milliseconds: 500), () {
                controller.search = value;
                showOverlay(asyncFunction: () => controller.getData(true));
              });
            },
          ),
        ),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (!controller.isLoading &&
                  notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent &&
                  !controller.endPage) {
                controller.isLoading = true;
                controller.currentPage++;
                showOverlay(asyncFunction: () => controller.getData());
                return true;
              }
              return false;
            },
            child: StreamBuilder<List<T>>(
              stream: controller._streamController.stream,
              builder: (context, snapshot) {
                Widget? custom;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  custom = Center(child: loadingAnimation());
                }

                if (snapshot.hasError) {
                  custom = Center(
                    child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Something went Wrong!!!"),
                          Text("Swipe Down to retry")
                        ]),
                  );
                }
                var data = snapshot.data;
                bool isEmptyData = !snapshot.hasData || data!.isEmpty;
                if (custom == null && (!snapshot.hasData || isEmptyData)) {
                  custom = Center(child: Text("No Data"));
                }
                print(
                    "is empy data $data $isEmptyData ${data?.length} ${snapshot.hasData}");
                return CustomRefreshIndicator(
                    onRefresh: () {
                      return controller.getData(true);
                    },
                    refreshIndicator: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 2,
                                  offset: Offset(0, 2) // Shadow position
                                  ),
                            ]),
                        padding: const EdgeInsets.all(8),
                        child: loadingAnimation(),
                      ),
                    ),
                    child: layoutBuilderWithAlwaytScoll(
                      scrool: custom != null || false,
                      child: custom ??
                          ListView.builder(
                            // shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: itemBuilder(
                                  context,
                                  data![index],
                                ),
                              );
                            },
                            itemCount: data?.length,
                          ),
                    ));
              },
            ),
          ),
        ),
      ],
    );
  }
}

class FutureListWidgetController<T> extends GetxController {
  FutureListWidgetController(this.future);
  List<T> items = [];
  Timer? _debounce;
  int currentPage = 1;
  bool isLoading = false;
  int? total;
  bool get endPage => items.length == total;
  final Future<PaginateListData<T>> Function(int page, [String search]) future;
  late StreamController<List<T>> _streamController;
  String search = '';
  @override
  onInit() {
    _streamController = StreamController<List<T>>();
    getData();
    super.onInit();
  }

  @override
  onClose() {
    _streamController.close();
    _debounce?.cancel();
    super.onClose();
  }

  Future<void> getData([bool refresh = false]) async {
    isLoading = true;
    final response = await future(
      currentPage,
      search,
    );
    total = response.total;
    isLoading = false;
    if (refresh) items.clear();
    items.addAll(response.items);

    _streamController.add(items);
    // _streamController.add(response.items);
  }
}

class PaginateListData<T> {
  final List<T> items;
  final int total;
  PaginateListData({
    required this.items,
    required this.total,
  });

  PaginateListData<T> copyWith({
    List<T>? items,
    int? total,
  }) {
    return PaginateListData<T>(
      items: items ?? this.items,
      total: total ?? this.total,
    );
  }

  @override
  bool operator ==(covariant PaginateListData<T> other) {
    if (identical(this, other)) return true;

    return listEquals(other.items, items) && other.total == total;
  }

  @override
  int get hashCode => items.hashCode ^ total.hashCode;
}
