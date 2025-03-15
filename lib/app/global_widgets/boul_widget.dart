import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/formatters/extension.dart';
import 'package:sizing/sizing_extension.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/enums.dart';
import '../core/utils/font_family.dart';
import '../data/models/ticket_model.dart';

class BoulWidget extends GetWidget {
  const BoulWidget({
    super.key,
    required this.boulJwe,
    required this.ticket,
  });
  final BoulJweModel boulJwe;
  final TicketModel ticket;
  get color => won
      ? AppColors.PRIMARY
      : lost
          ? FontColors.RED
          : Colors.grey.shade400;
  bool get won => boulJwe.status == GameStatus.win;
  bool get lost => boulJwe.status == GameStatus.lost;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        spacing: 15,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...boulJwe.getboul(ticket.type).map(
                    (el) => CircleAvatar(
                      backgroundColor: color,
                      radius: 15,
                      child: Text(el),
                    ),
                  ),
            ],
          ),
          Expanded(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(
                    ticket.type.name.capitalize,
                    style: Get.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  )),
                  Center(
                      child: Text(
                    ticket.tirageName.name,
                    style: Get.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  )),
                  if (boulJwe.option != null)
                    Card(
                      color: AppColors.PRIMARY3,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.ss),
                        child: Text(
                          boulJwe.option!.miniName,
                          style: TextStyle(
                              color: FontColors.PRIMARY,
                              fontFamily: FontPoppins.BOLD,
                              fontSize: 18.fs),
                        ),
                      ),
                    ),
                  Expanded(
                    child: Text(
                      "${ticket.getWinningMultiple(boulJwe.boul, boulJwe.status)}",
                      textAlign: TextAlign.end,
                      style: Get.textTheme.titleMedium
                          ?.copyWith(color: color, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Text(boulJwe.amount.toHLG),
            ],
          )),
        ],
      ),
    );
  }
}
