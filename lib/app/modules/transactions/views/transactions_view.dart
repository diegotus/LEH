import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/app_utility.dart';
import 'package:haiti_lotri/app/global_widgets/app_button.dart';
import 'package:haiti_lotri/app/global_widgets/infinite_list.dart';
import 'package:sizing/sizing_extension.dart';

import 'package:haiti_lotri/app/core/utils/formatters/extension.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_string.dart';
import '../../../core/utils/enums.dart';
import '../../../core/utils/font_family.dart';
import '../../../core/utils/formatters/format_number.dart';
import '../../../core/utils/kiwoo_icons.dart' show Kiwoo;
import '../../../data/models/transaction_model.dart';
import '../../../global_widgets/app_bar.dart';
import '../../../global_widgets/filter_widets.dart'
    show DateFilter, DropDownFilter, DropdownFilterItem;
import '../../../global_widgets/list_tile_card.dart';
import '../../../routes/app_pages.dart';
import '../controllers/transactions_controller.dart';

class TransactionsView extends GetView<TransactionsController> {
  const TransactionsView({super.key});
  @override
  Widget build(BuildContext context) {
    DateTime? lastCreate;
    return Scaffold(
      appBar: AppBarTitleWidthBottomFilter(
        title: AppStrings.TRANSACTIONS,
        homeIfCantPop: true,
        children: [
          Flexible(
            child: DropDownFilter<TransactionType>(
              onUpdate: (value) {
                controller.updateColumn(value);
                lastCreate = null;
              },
              icon: Icon(
                Kiwoo.exchange,
                color: AppColors.PRIMARY1,
              ),
              items: [
                DropdownFilterItem(title: AppStrings.ALL),
                ...TransactionType.values.map((type) {
                  return DropdownFilterItem(
                      title: AppStrings.TRANSACTION_TYPE_NAMED(type),
                      value: type);
                })
              ],
            ),
          ),
          Flexible(
            child: DateFilter(
              onUpdate: (date) {
                lastCreate = null;
                controller.updateDate(date);
              },
            ),
          ),
        ],
      ),
      body: InfiniteList<TransactionModel>(
        onPage: controller.onPage,
        itemBuilder: (context, item) {
          var icon = Icons.arrow_downward;
          final direction = item.direction(controller.phone);
          if (direction == Direction.outbound) {
            icon = Icons.arrow_upward;
          }
          bool isNewDate = lastCreate == null ||
              lastCreate!.difference(item.createdAt).inDays.abs() > 0;
          var dataText = item.getTitle(direction);
          lastCreate = item.createdAt;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isNewDate)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 0),
                  child: Text(
                    item.createdAt.format("dd MMM, yyyy"),
                    style: TextStyle(
                      fontSize: 18.fss,
                      color: const Color(0xFF1A1A1A),
                      fontFamily: FontPoppins.MEDIUM,
                    ),
                  ),
                ),
              ListTileCard(
                onTap: () {
                  Get.toNamed(
                    Routes.TRANSACTION_DETAILS,
                    parameters: {"id": item.id.toString()},
                  );
                },
                isThreeLine: true,
                leading: AspectRatio(
                  aspectRatio: 0.6,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border:
                              Border.all(color: AppColors.PRIMARY, width: 2)),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        foregroundColor: AppColors.PRIMARY,
                        child: Icon(
                          icon,
                        ),
                      ),
                    ),
                  ),
                ),
                title: dataText['title']!,
                subTitle: dataText['body']!,
                trailing: Container(
                  constraints: BoxConstraints(maxWidth: 120.ss),
                  margin: const EdgeInsets.only(left: 5),
                  child: Wrap(
                    spacing: 10.ss,
                    children: [
                      Text(
                        toHLGCurrency().currencySymbol,
                        style: TextStyle(
                          fontSize: 16.fss,
                          color: const Color(0xFF1A1A1A),
                          fontFamily: FontPoppins.BOLD,
                        ),
                      ),
                      Text(
                        item.amount.formatNumberCompact,
                        style: TextStyle(
                          fontSize: 16.fss,
                          color: const Color(0xFF1A1A1A),
                          fontFamily: FontPoppins.BOLD,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String data(List<TransactionModel> data, int index) {
    return index.toString();
  }
}
