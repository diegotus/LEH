import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';
import 'package:haiti_lotri/app/core/utils/app_colors.dart';
import 'package:haiti_lotri/app/core/utils/app_utility.dart';
import 'package:haiti_lotri/app/core/utils/datetime_utility.dart';
import 'package:haiti_lotri/app/core/utils/font_family.dart';
import 'package:haiti_lotri/app/core/utils/formatters/extension.dart';
import 'package:haiti_lotri/app/global_widgets/app_button.dart';
import 'package:haiti_lotri/app/global_widgets/list_builder_widget.dart';
import 'package:intl/intl.dart';
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
      appBar: AppBarWithWidgetTitle(
        title: "Haiti Loto",
        child: Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => FilterButton.checkBox(
                title: "WinTicket",
                value: controller.winTickets.isTrue,
                onPressedChecked: (val) {
                  controller.winTickets(val);
                },
              ),
            ),
            Obx(() {
              var filter = controller.dateFilter.value;
              return DropdownFilterButton(
                  items: [
                    DropdownMenuItem(value: null, child: Text("Denye Biyè yo")),
                    DropdownMenuItem(value: "Today", child: Text("Jodia")),
                    DropdownMenuItem(value: "Yesterday", child: Text("Yè")),
                    DropdownMenuItem(
                      value: "Custom",
                      child: Text("pèsonalize"),
                    ),
                  ],
                  value: filter.selectedFilter,
                  onChanged: (p0) {
                    if (p0 != "Custom") {
                      DateTime? date = DateTime.now();
                      if (p0 == "Yesterday") {
                        date = date.subtract(Duration(days: 1));
                      } else if (p0 == null) {
                        date = null;
                      }
                      controller.dateFilter.call(filter.copyWith(
                          selectedFilter: p0, dateSelected: date));
                    } else {
                      showDatePicker(
                        context: context,
                        initialDate: filter.dateSelected,
                        initialEntryMode: DatePickerEntryMode.calendarOnly,
                        firstDate: DateTimeUtility.convertDateFromString(
                          "2025-01-01",
                        ),
                        lastDate: DateTime.now(),
                      ).then((value) {
                        if (value != null) {
                          controller.dateFilter.call(filter.copyWith(
                              selectedFilter: p0!, dateSelected: value));
                        }
                      });
                    }
                  },
                  selectedItemBuilder: (context, items, value) {
                    return [
                      ...items!.map((el) {
                        if (value != "Custom" || el.value != "Custom") {
                          return el;
                        } else {
                          return DropdownMenuItem(
                              child: Text(
                            filter.dateSelected!.format("dd-MM-yyyy"),
                          ));
                        }
                      })
                    ];
                  });
            }),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                var filter = controller.dateFilter.value;
                var windOnly = controller.winTickets.isTrue;
                return ListBuilderWidget<TicketModel>.future(
                  future: () => controller.callGetTicketsApi(filter, windOnly),
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
                        subtitle:
                            Text("${ticket.totalWon}/${ticket.boulJwe.length}"),
                        title: Text.rich(
                          TextSpan(
                              text: ticket.type.name.capitalize,
                              children: [
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.baseline,
                                  baseline: TextBaseline.alphabetic,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
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
                                      color: AppColors.PRIMARY,
                                      fontFamily: FontPoppins.BOLD),
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
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
