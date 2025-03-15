import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

import 'package:haiti_lotri/app/core/utils/formatters/extension.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/font_family.dart';
import '../../../../core/utils/formatters/format_number.dart';
import '../../../../data/models/transaction_model.dart';
import '../../../../global_widgets/app_bar.dart';
import '../../../../global_widgets/list_builder_widget.dart';
import '../../../../global_widgets/list_tile_card.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/transactions_controller.dart';

class TransactionHistoryView extends GetView<TransactionsController> {
  const TransactionHistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    DateTime? lastCreate;
    return Scaffold(
      appBar: AppBarWidgetTitle(
        title: AppStrings.TRANSACTIONS,
      ),
      body: ListBuilderWidget<TransactionModel>.future(
        future: controller.futureRequest,
        // separatorBuilder: (p0, p1, item) {
        //   return Text(item.createdAt.since());
        // },

        itemBuilder: (p0, item, _, [previous]) {
          var icon = Icons.arrow_downward;
          final direction = item.direction(controller.phone);
          if (direction == Direction.outbound) {
            icon = Icons.arrow_upward;
          }
          var dataText = item.getTitle(direction);
          lastCreate = previous?.createdAt;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (lastCreate == null ||
                  lastCreate!.difference(item.createdAt).inDays.abs() > 0)
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
