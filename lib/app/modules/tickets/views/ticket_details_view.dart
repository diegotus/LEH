import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/app_colors.dart';
import 'package:haiti_lotri/app/core/utils/enums.dart';
import 'package:haiti_lotri/app/core/utils/formatters/extension.dart';
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
        Expanded(
          child: ListBuilderWidget.future(
            future: () => controller.callGetTicketDetailApi(ticket.id),
            itemBuilder: (context, item, refreshFuture, [previous]) {
              var color = item.status.name == "win"
                  ? AppColors.PRIMARY
                  : item.status.name == "lost"
                      ? FontColors.RED
                      : Colors.grey.shade400;
              return ListTile(
                dense: true,
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...item.getboul(ticket.type).map(
                          (el) => CircleAvatar(
                            backgroundColor: color,
                            radius: 15,
                            child: Text(el),
                          ),
                        )
                  ],
                ),
                title: Text.rich(
                  TextSpan(text: ticket.type.name.capitalize, children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: SizedBox(width: 35),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: SizedBox(width: 45),
                    ),
                    TextSpan(text: ticket.tirageName.name),
                  ]),
                ),
                subtitle: Text(item.amount.toHLG),
                trailing: item.status.name == "win"
                    ? Text(
                        "${getWinningMultiple(item.boul)}",
                        style: Get.textTheme.titleLarge
                            ?.copyWith(color: AppColors.PRIMARY),
                      )
                    : null,
              );
            },
          ),
        ),
      ],
    );
  }

  String? getWinningMultiple(boul) {
    switch (ticket.type) {
      case Gametype.bolet:
        const price = ["x50", "x20", "x10"];
        var index =
            ticket.winningNumbers?.indexWhere((value) => value.endsWith(boul));
        if (index != null && index - 1 > -1) return price[index];
        break;
      case Gametype.mariaj:
        var exp = RegExp(r'\d{2}');

        if (exp.allMatches(boul).every(
            (el) => ticket.winningNumbers?.contains(el.group(0)) ?? false)) {
          return "x2000";
        }
        break;
      case Gametype.lotto3:
        // TODO: Handle this case.
        break;
      case Gametype.lotto4:
        // TODO: Handle this case.
        break;
      case Gametype.lotto5:
        // TODO: Handle this case.
        break;
      case Gametype.lotto5p5:
        // TODO: Handle this case.
        break;
      case Gametype.royal5:
        // TODO: Handle this case.
        break;
    }
    return null;
  }
}
