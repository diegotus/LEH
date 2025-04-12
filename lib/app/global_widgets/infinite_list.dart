// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:nestjs_prisma_pagination/nestjs_prisma_pagination.dart';

import 'package:haiti_lotri/app/core/utils/actions/overlay.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/app_utility.dart';
import '../data/models/paginate_data_model.dart' show PaginateListData;
import 'custom_refresh_indicator.dart';
import 'input_field.dart';
import 'scroll_widget.dart';

class InfiniteList<T> extends GetWidget<InfiniteListController<T>> {
  const InfiniteList({
    super.key,
    required this.itemBuilder,
    this.onPage,
    this.onSearch,
  });
  final Widget? Function(BuildContext, T) itemBuilder;
  final void Function(String? search)? onSearch;
  final Function({bool clear})? onPage;

  @override
  Widget build(BuildContext context) {
    String? pviousSearch;
    return Column(
      children: [
        if (onSearch != null)
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
                  showOverlay(asyncFunction: () {
                    if (pviousSearch != value) {
                      pviousSearch = value;
                      return controller.callApiData(
                          callBack: () => onSearch!(value));
                    }
                    return Future.value();
                  });
                });
              },
            ),
          ),
        Expanded(
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

              return CustomRefreshIndicator(
                  notificationPredicate: (notification) {
                    if (!controller.isLoading &&
                        notification.metrics.pixels ==
                            notification.metrics.maxScrollExtent &&
                        !controller.endPage) {
                      showOverlay(asyncFunction: () {
                        return controller.callApiData(
                            callBack: onPage, nextPage: true);
                      });
                      return true;
                    }
                    return notification.depth == 0;
                  },
                  onRefresh: () {
                    return controller.callApiData(
                        callBack: () => onPage?.call(clear: true));
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
                          key: controller._uniqueKey,
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
      ],
    );
  }
}

class InfiniteListController<T> extends GetxController {
  InfiniteListController({required this.future});
  final Future<PaginateListData<T>> Function() future;
  List<T> items = [];
  Timer? _debounce;
  bool isLoading = false;
  int? total;
  bool get endPage => items.length == total;
  late StreamController<List<T>> _streamController;
  String search = '';
  late UniqueKey _uniqueKey;
  @override
  onInit() {
    _uniqueKey = UniqueKey();
    _streamController = StreamController<List<T>>();
    _getData();
    super.onInit();
  }

  Future<void> callApiData({Callback? callBack, bool nextPage = false}) {
    isLoading = true;
    callBack?.call();
    return _getData(nextPage);
  }

  @override
  onClose() {
    _streamController.close();
    _debounce?.cancel();
    super.onClose();
  }

  Future<void> _getData([bool nextPage = false]) async {
    isLoading = true;
    try {
      final response = await future();
      total = response.total;
      if (!nextPage) {
        if (items.isNotEmpty) {
          _uniqueKey = UniqueKey();
        }
        items.clear();
      }
      items.addAll(response.items);
      _streamController.add(items);
    } catch (e) {
      _streamController.addError(e);
    }
    isLoading = false;
  }
}
