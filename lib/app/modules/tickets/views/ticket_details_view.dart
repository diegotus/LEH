import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/app_colors.dart';
import 'package:haiti_lotri/app/core/utils/formatters/extension.dart';
import 'package:haiti_lotri/app/global_widgets/boul_widget.dart';
import 'package:haiti_lotri/app/global_widgets/list_builder_widget.dart';

import '../../../data/models/ticket_model.dart';
import '../controllers/tickets_controller.dart';

class TicketDetailView extends GetView<TicketsController> {
  const TicketDetailView({super.key, required this.ticket});
  final TicketModel ticket;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Card(
            color: AppColors.PRIMARY3,
            margin: EdgeInsets.zero,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "#${'${ticket.id}'.padLeft(8, "0")}",
                  style: Get.theme.textTheme.headlineSmall?.copyWith(
                      color: AppColors.PRIMARY2, fontWeight: FontWeight.bold),
                ),
                Text(
                  ticket.getAmountTotal.toHLG,
                  style: Get.theme.textTheme.titleMedium,
                ),
                Text(
                  ticket.createdAt.since(),
                  style: Get.theme.textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListBuilderWidget.future(
              future: () => controller.callGetTicketDetailApi(ticket.id),
              itemBuilder: (context, item, refreshFuture, [previous]) {
                return Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BoulWidget(boulJwe: item, ticket: ticket),
                    ));
              },
            ),
          ),
        ),
      ],
    );
  }
}

// old boul list
//  var color = item.status.name == "win"
//                   ? AppColors.PRIMARY
//                   : item.status.name == "lost"
//                       ? FontColors.RED
//                       : Colors.grey.shade400;
//               return ListTile(
//                 dense: true,
//                 leading: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     ...item.getboul(ticket.type).map(
//                           (el) => CircleAvatar(
//                             backgroundColor: color,
//                             radius: 15,
//                             child: Text(el),
//                           ),
//                         )
//                   ],
//                 ),
//                 title: Text.rich(
//                   TextSpan(text: ticket.type.name.capitalize, children: [
//                     WidgetSpan(
//                       alignment: PlaceholderAlignment.baseline,
//                       baseline: TextBaseline.alphabetic,
//                       child: SizedBox(width: 35),
//                     ),
//                     if (item.option != null)
//                       WidgetSpan(
//                         alignment: PlaceholderAlignment.baseline,
//                         baseline: TextBaseline.alphabetic,
//                         child: Container(
//                           padding: EdgeInsets.symmetric(horizontal: 8.ss),
//                           decoration: ShapeDecoration(
//                             color: AppColors.PRIMARY3,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(
//                                   20), // Adds BorderRadius
//                             ),
//                           ),
//                           child: Text(
//                             item.option!.miniName,
//                             style: TextStyle(
//                                 color: FontColors.PRIMARY,
//                                 fontFamily: FontPoppins.BOLD,
//                                 fontSize: 18.fs),
//                           ),
//                         ),
//                       ),
//                     WidgetSpan(
//                       alignment: PlaceholderAlignment.baseline,
//                       baseline: TextBaseline.alphabetic,
//                       child: SizedBox(width: 45),
//                     ),
//                     TextSpan(text: ticket.tirageName.name),
//                   ]),
//                 ),
//                 subtitle: Text(item.amount.toHLG),
//                 trailing: item.status.name == "win"
//                     ? Text(
//                         "${ticket.getWinningMultiple(item.boul)}",
//                         style: Get.textTheme.titleLarge
//                             ?.copyWith(color: AppColors.PRIMARY),
//                       )
//                     : null,
//               );
