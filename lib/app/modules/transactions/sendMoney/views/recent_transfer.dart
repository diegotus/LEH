import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haiti_lotri/app/global_widgets/input_field.dart';
import 'package:haiti_lotri/app/modules/transactions/providers/transactions_provider.dart';

import '../../../../data/models/contact_list_model.dart'
    show ContactData, listContactFromListMap;
import '../../../../data/models/paginate_data_model.dart' show PaginateListData;
import '../../../../global_widgets/list_builder_widget_infinite.dart'
    show ListBuilderWidget, ListBuilderWidgetController;

class RecentTransferController extends GetxController {
  late final ListBuilderWidgetController<ContactData> listController;
  @override
  void onInit() {
    print("initalised");
    Get.put<ListBuilderWidgetController<ContactData>>(
      ListBuilderWidgetController<ContactData>(
        future: callRecentTransactionAPI,
      ),
    );
    super.onInit();
  }

  Future<PaginateListData<ContactData>> callRecentTransactionAPI() async {
    var response =
        await Get.putOrFind<TransactionsProvider>(
          () => TransactionsProvider(),
        ).recentTransferApi();
    if (response?.isSuccess == true) {
      var items = listContactFromListMap(response!.data);
      return PaginateListData(
        items: items,
        total: response.total ?? items.length,
      );
    } else {
      response?.showMessage();
      return Future.error("Something went Wrrong");
    }
  }
}

class RecentTransfer extends GetWidget<RecentTransferController> {
  const RecentTransfer({super.key, this.onTap});
  final void Function(ContactData user)? onTap;

  @override
  Widget build(BuildContext context) {
    return labelWidget(
      label: "Previous Transfer",
      child: Expanded(
        child: ListBuilderWidget<ContactData>(
          emptyMsg: "No Transfer Yet",
          builder: (context, listItems) {
            return GridView.extent(
              maxCrossAxisExtent: 190,
              childAspectRatio: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              shrinkWrap: true,
              children: [
                ...listItems.map(
                  (el) => Card(
                    child: Center(
                      child: ListTile(
                        onTap: onTap == null ? null : () => onTap!(el),
                        dense: true,
                        title: FittedBox(child: Text("${el.name}")),
                        subtitle: FittedBox(
                          child: Text(
                            "${el.phone}",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
