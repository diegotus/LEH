import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/formatters/extension.dart';
import 'package:haiti_lotri/app/data/models/ticket_model.dart';
import 'package:haiti_lotri/app/global_widgets/boul_widget.dart';
import 'package:sizing/sizing_extension.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/app_string.dart';
import '../core/utils/font_family.dart';
import '../core/utils/function.dart';
import 'list_builder_widget.dart';

class TicketWidget extends GetWidget {
  const TicketWidget({super.key, required this.future});
  final Future<List<TicketModel>?> Function()? future;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: AppColors.PRIMARY3,
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(AppStrings.TICKET, style: Get.textTheme.titleLarge),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListBuilderWidget.future(
              onEmptyText: "No Billet Found",
              shrinkWrap: false,
              future: future,
              itemBuilder: (context, ticket, _, [__]) {
                return Card(
                  color: getTicketColor(ticket),
                  child: ExpansionTile(
                    dense: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    maintainState: true,
                    collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    childrenPadding: EdgeInsets.only(
                      left: 8,
                      right: 23,
                    ),
                    title: Text(
                        "${AppStrings.TICKET} #${ticket.id.toString().padLeft(8, "0")}"),
                    subtitle: Text(ticket.getAmountTotal.toHLG),
                    // backgroundColor: AppColors.WHITE,
                    children: [
                      ...ticket.boulJwe.map((el) {
                        return BoulWidget(boulJwe: el, ticket: ticket);
                      })
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
