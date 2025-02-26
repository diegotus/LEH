import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/app_utility.dart';
import 'custom_refresh_indicator.dart';
import 'input_field.dart';
import 'scroll_widget.dart';

typedef RefreshData = Future Function([bool]);

class ListBuilderWidget<T> extends GetView {
  const ListBuilderWidget({
    super.key,
    this.onEmptyText = "No Data",
    required this.itemBuilder,
    required this.items,
    this.onItems,
    this.physics,
    this.separatorBuilder,
    this.pullRefresh = true,
    this.shrinkWrap = true,
  })  : future = null,
        futureSearch = null,
        futureBuilder = null,
        onSearch = null;

  ListBuilderWidget.future({
    super.key,
    this.onEmptyText = "No Data",
    this.futureBuilder,
    required this.itemBuilder,
    List<T>? initialData,
    this.onItems,
    this.physics,
    this.separatorBuilder,
    required this.future,
    this.pullRefresh = true,
    this.shrinkWrap = true,
  })  : items = initialData ?? [],
        futureSearch = null,
        onSearch = null;

  ListBuilderWidget.futureWithSearch({
    super.key,
    this.onEmptyText = "No Data",
    required this.futureSearch,
    this.futureBuilder,
    required this.itemBuilder,
    List<T>? initialData,
    this.onItems,
    this.physics,
    this.separatorBuilder,
    required this.onSearch,
    this.pullRefresh = true,
    this.shrinkWrap = true,
  })  : future = null,
        items = initialData ?? [];

  final List<T> Function(String searchValue, List<T>? data,
      RefreshData refreshData, bool isLoading)? onSearch;
  final Widget Function(BuildContext context, int index, T item)?
      separatorBuilder;

  final String onEmptyText;
  final List<T> items;
  final Future<List<T>?> Function()? future;
  final Future<List<T>?> Function([String?])? futureSearch;
  final Widget? Function(BuildContext, T, RefreshData? refreshFuture,
      [T? previous]) itemBuilder;
  final Widget Function(
    BuildContext,
    List<T>,
    Widget Function(List<T>, [RefreshData refreshFuture]),
  )? futureBuilder;
  final List<T> Function(List<T>)? onItems;
  final ScrollPhysics? physics;
  final bool pullRefresh;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    if (future == null && futureSearch == null) {
      var data = items;
      if (onItems != null) {
        data = onItems!(data);
      }
      return listViewBuilder(data);
    }
    if (futureSearch != null) {
      return ListFutureBuilderWithSearch(
        future: futureSearch!,
        initialData: items,
        onEmptyText: onEmptyText,
        futureBuilder: (BuildContext context, List<T> data, refreshData) {
          if (futureBuilder == null) {
            return listViewBuilder(data, refreshData);
          }
          return futureBuilder!(context, data, listViewBuilder);
        },
        isEmpty: (List<T>? data) {
          return data == null || data.isEmpty == true;
        },
      );
    }
    return FutureDataBuilder(
      future: future!,
      initialData: items,
      onEmptyText: onEmptyText,
      physics: physics,
      pullRefresh: pullRefresh,
      futureBuilder: (BuildContext context, List<T> data, refreshData) {
        if (futureBuilder == null) {
          return listViewBuilder(data, refreshData, shrinkWrap);
        }
        return futureBuilder!(context, data, listViewBuilder);
      },
      isEmpty: (List<T>? data) {
        return data == null || data.isEmpty == true;
      },
    );
  }

  Widget listViewBuilder(List<T> items,
      [RefreshData? refreshFuture, bool shrinkWrap = true]) {
    builder(context, index) {
      T value = items[index];

      return itemBuilder(context, value, refreshFuture,
          (index == 0 ? null : items[index - 1]));
    }

    if (separatorBuilder != null) {
      return ListView.separated(
        separatorBuilder: (context, index) {
          return separatorBuilder!(context, index, items[index]);
        },
        itemCount: items.length,
        shrinkWrap: shrinkWrap,
        physics: physics,
        itemBuilder: builder,
      );
    }
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: physics,
      itemBuilder: builder,
    );
  }
}

// ignore: must_be_immutable
class FutureDataBuilder<T> extends GetView {
  FutureDataBuilder({
    super.key,
    required this.future,
    required this.futureBuilder,
    this.onEmptyText = "No Data",
    this.initialData,
    this.onItems,
    this.physics,
    required this.isEmpty,
    this.pullRefresh = true,
    this.autoAddScroll = false,
    this.onError,
  }) {
    futureData = future().obs;
  }
  final bool pullRefresh;
  final bool autoAddScroll;
  final String onEmptyText;
  final T? initialData;
  final Future<T?> Function() future;
  final Widget Function(BuildContext, T, RefreshData refreshFuture)
      futureBuilder;
  final T Function(T)? onItems;
  final ScrollPhysics? physics;
  final bool Function(T?) isEmpty;
  final Function(Object error)? onError;

  late final Rx<Future<T?>> futureData;
  bool _eraseAll = true;

  Future refreshFuture([bool reset = true, Future? data]) async {
    _eraseAll = reset;
    futureData.value = future();
    return futureData.value;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return FutureBuilder(
        future: futureData.value,
        initialData: initialData,
        builder: (context, snapshot) {
          Widget? custom;
          if (snapshot.connectionState == ConnectionState.waiting) {
            if (_eraseAll) {
              custom = Center(child: loadingAnimation());
            }
          } else {
            _eraseAll = false;
          }
          if (snapshot.hasError) {
            custom = Center(
              child: onError?.call(snapshot.error!) ??
                  const Column(mainAxisSize: MainAxisSize.min, children: [
                    Text("Something went Wrong!!!"),
                    Text("Swipe Down to retry")
                  ]),
            );
          }
          var data = snapshot.data;
          bool isEmptyData = data == null || isEmpty(data);
          if (custom == null && (!snapshot.hasData || isEmptyData)) {
            custom = Center(child: Text(onEmptyText));
          }

          if (!pullRefresh) {
            return custom ?? futureBuilder(context, data as T, refreshFuture);
          }
          return CustomRefreshIndicator(
            onRefresh: () {
              return refreshFuture(false);
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
                  child: loadingAnimation()),
            ),
            child: layoutBuilderWithAlwaytScoll(
                scrool: !_eraseAll && custom != null || autoAddScroll,
                child:
                    custom ?? futureBuilder(context, data as T, refreshFuture)),
          );
        },
      );
    });
  }
}

class ListFutureBuilderWithSearchController extends GetxController {
  final RxString searchValue = RxString('');
  Timer? _debounce;
  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }
}

class ListFutureBuilderWithSearch<T>
    extends GetView<ListFutureBuilderWithSearchController> {
  ListFutureBuilderWithSearch({
    super.key,
    required this.future,
    required this.futureBuilder,
    this.onEmptyText = "No Data",
    this.initialData,
    this.onItems,
    this.physics,
    required this.isEmpty,
    this.pullRefresh = true,
    this.autoAddScroll = false,
    // required this.onSearch,
    this.searchInput,
  }) {
    futureData = future().obs;
  }

  @override
  get controller => Get.put<ListFutureBuilderWithSearchController>(
      ListFutureBuilderWithSearchController());

  // final T Function(
  //         String seachText, T? data, RefreshData refreshFuture, bool isLoading)
  //     onSearch;
  final bool pullRefresh;
  final bool autoAddScroll;
  final String onEmptyText;
  final T? initialData;
  final Future<T?> Function([String? search]) future;
  final Widget Function(BuildContext, T, RefreshData refreshFuture)
      futureBuilder;
  final Widget Function(void Function(String) onChanged)? searchInput;
  final T Function(T)? onItems;
  final ScrollPhysics? physics;
  final bool Function(T?) isEmpty;

  late final Rx<Future<T?>> futureData;
  bool _eraseAll = true;

  Future refreshFuture([bool reset = true]) async {
    _eraseAll = reset;
    final search = controller.searchValue.value;
    futureData.value = future(search);
    return futureData.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        searchInput?.call(
              (value) {
                if (controller._debounce?.isActive ?? false) {
                  controller._debounce?.cancel();
                }
                controller._debounce =
                    Timer(const Duration(milliseconds: 500), () {
                  controller.searchValue.value = value;
                  refreshFuture();
                });
              },
            ) ??
            SearchCustomInputFormField(
              borderColor: AppColors.BLACK,
              onChanged: (value) {
                if (controller._debounce?.isActive ?? false) {
                  controller._debounce?.cancel();
                }
                controller._debounce =
                    Timer(const Duration(milliseconds: 500), () {
                  controller.searchValue.value = value;
                  refreshFuture();
                });
              },
            ),
        Expanded(
          child: Obx(() {
            return FutureBuilder(
              future: futureData.value,
              initialData: initialData,
              builder: (context, snapshot) {
                Widget? custom;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  if (_eraseAll) {
                    custom = Center(child: loadingAnimation());
                  }
                } else {
                  _eraseAll = false;
                }
                var data = snapshot.data;
                bool isEmptyData =
                    !snapshot.hasData || data == null || isEmpty(data);

                if (custom == null && isEmptyData) {
                  custom = Center(child: Text(onEmptyText));
                } else if (!isEmptyData && !_eraseAll) {
                  custom = null;
                }

                if (!pullRefresh) {
                  return custom ??
                      futureBuilder(context, data as T, refreshFuture);
                }

                return CustomRefreshIndicator(
                  onRefresh: () {
                    return refreshFuture(false);
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
                        child: loadingAnimation()),
                  ),
                  child: layoutBuilderWithAlwaytScoll(
                      scrool: !_eraseAll && custom != null || autoAddScroll,
                      child: custom ??
                          futureBuilder(context, data as T, refreshFuture)),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}

class FutureBuilderWithSearch<T>
    extends GetView<ListFutureBuilderWithSearchController> {
  FutureBuilderWithSearch({
    super.key,
    required this.future,
    required this.futureBuilder,
    this.onEmptyText = "No Data",
    this.initialData,
    this.onItems,
    this.physics,
    required this.isEmpty,
    this.pullRefresh = true,
    this.autoAddScroll = false,
    // required this.onSearch,
    this.searchInput,
  }) {
    futureData = future().obs;
  }

  @override
  get controller => Get.put<ListFutureBuilderWithSearchController>(
      ListFutureBuilderWithSearchController());

  // final T Function(
  //         String seachText, T? data, RefreshData refreshFuture, bool isLoading)
  //     onSearch;
  final bool pullRefresh;
  final bool autoAddScroll;
  final String onEmptyText;
  final T? initialData;
  final Future<T?> Function([String? search]) future;
  final Widget Function(
      BuildContext, T, bool isLoading, RefreshData refreshFuture) futureBuilder;
  final Widget Function(void Function(String) onChanged)? searchInput;
  final T Function(T)? onItems;
  final ScrollPhysics? physics;
  final bool Function(T?) isEmpty;

  late final Rx<Future<T?>> futureData;
  bool _eraseAll = true;

  Future refreshFuture([bool reset = true]) async {
    _eraseAll = reset;
    final search = controller.searchValue.value;
    futureData.value = future(search);
    return futureData.value;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: pullRefresh ? const NeverScrollableScrollPhysics() : null,
      children: [
        searchInput?.call(
              (value) {
                if (controller._debounce?.isActive ?? false) {
                  controller._debounce?.cancel();
                }
                controller._debounce =
                    Timer(const Duration(milliseconds: 500), () {
                  controller.searchValue.value = value;
                  refreshFuture();
                });
              },
            ) ??
            SearchCustomInputFormField(
              borderColor: AppColors.BLACK,
              onChanged: (value) {
                if (controller._debounce?.isActive ?? false) {
                  controller._debounce?.cancel();
                }
                controller._debounce =
                    Timer(const Duration(milliseconds: 500), () {
                  controller.searchValue.value = value;
                  refreshFuture();
                });
              },
            ),
        Obx(() {
          return FutureBuilder(
            future: futureData.value,
            initialData: initialData,
            builder: (context, snapshot) {
              Widget? custom;

              var data = snapshot.data;
              bool isEmptyData =
                  !snapshot.hasData || data == null || isEmpty(data);

              // if (custom == null && isEmptyData) {
              //   custom = Center(child: Text(onEmptyText));
              // } else if (!isEmptyData && !_eraseAll) {
              //   custom = null;
              // }

              if (!pullRefresh) {
                return futureBuilder(
                    context,
                    data as T,
                    snapshot.connectionState == ConnectionState.waiting,
                    refreshFuture);
              }

              return CustomRefreshIndicator(
                onRefresh: () {
                  return refreshFuture(false);
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
                      child: loadingAnimation()),
                ),
                child: layoutBuilderWithAlwaytScoll(
                    scrool: autoAddScroll,
                    child: custom ??
                        futureBuilder(
                            context,
                            data as T,
                            snapshot.connectionState == ConnectionState.waiting,
                            refreshFuture)),
              );
            },
          );
        }),
      ],
    );
  }
}
