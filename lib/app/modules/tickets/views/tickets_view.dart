import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/app_colors.dart';
import 'package:haiti_lotri/app/core/utils/font_family.dart';
import 'package:haiti_lotri/app/core/utils/formatters/extension.dart';
import 'package:haiti_lotri/app/global_widgets/list_builder_widget.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../core/utils/function.dart';
import '../../../core/utils/kiwoo_icons.dart';
import '../../../data/models/ticket_model.dart';
import '../../../global_widgets/app_bar.dart';
import '../../../global_widgets/modal/bottom_sheet.dart';
import '../controllers/tickets_controller.dart';
import 'ticket_details_view.dart';

class TicketsView extends GetView<TicketsController> {
  const TicketsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidgetTitle(title: "Haiti Loto"),
      body: ListBuilderWidget<TicketModel>.future(
        future: controller.callGetTicketsApi,
        itemBuilder: (context, ticket, refreshFuture, [previous]) {
          return Card(
            color: getTicketColor(ticket),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              onTap: () {
                bottomSheetWidget(
                  // isScrollControlled: true,
                  child: TicketDetailView(ticket: ticket),
                );
                // Get.to(() => TicketDetailView(idTicket: ticket.id),
                //     routeName: "ticket_details");
              },
              subtitle: Text("${ticket.totalWon}/${ticket.boulJwe.length}"),
              title: Text.rich(
                TextSpan(text: ticket.type.name.capitalize, children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        Kiwoo.moon,
                        size: 20.fs,
                        color: AppColors.SUBTITLE,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: ticket.dayTime.name.capitalize,
                    style: Get.textTheme.titleMedium
                        ?.copyWith(color: AppColors.SUBTITLE),
                  ),
                  TextSpan(
                    text: " ${ticket.tirageName.name}",
                    style: Get.textTheme.titleMedium?.copyWith(
                        color: AppColors.PRIMARY, fontFamily: FontPoppins.BOLD),
                  ),
                ]),
              ),
              subtitleTextStyle: Get.textTheme.titleMedium
                  ?.copyWith(color: AppColors.SUBTITLE),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(ticket.createdAt.since()),
                  Text(ticket.getAmountTotal.toHLG),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
