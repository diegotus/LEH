import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haiti_lotri/app/global_widgets/infinite_list.dart';
import 'package:sizing/sizing_extension.dart';

import 'package:haiti_lotri/app/core/utils/app_colors.dart';
import 'package:haiti_lotri/app/core/utils/app_string.dart';
import 'package:haiti_lotri/app/core/utils/datetime_utility.dart';
import 'package:haiti_lotri/app/core/utils/enums.dart';
import 'package:haiti_lotri/app/core/utils/font_family.dart';
import 'package:haiti_lotri/app/core/utils/formatters/extension.dart';
import 'package:haiti_lotri/app/global_widgets/app_button.dart';
import 'package:haiti_lotri/app/global_widgets/list_builder_widget.dart';

import '../../../core/utils/function.dart';
import '../../../core/utils/kiwoo_icons.dart';
import '../../../data/models/ticket_model.dart';
import '../../../global_widgets/app_bar.dart';
import '../../../global_widgets/filter_widets.dart'
    show DateFilter, DropDownFilter;
import '../../../global_widgets/modal/bottom_sheet.dart';
import '../controllers/tickets_controller.dart';
import 'ticket_details_view.dart';

class TicketsView extends GetView<TicketsController> {
  const TicketsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTitleWidthBottomFilter(
        title: "Haiti Loto",
        children: [
          Flexible(
            child: ObxValue(
              (value) => FilterButton.checkBox(
                title: AppStrings.WIN_TICKET,
                value: value.value == false,
                onPressedChecked: (val) {
                  print("the value checked $value");
                  value(!val);
                  controller.addColumn(!val);
                },
              ),
              false.obs,
            ),
          ),
          Flexible(child: DateFilter(onUpdate: controller.updateDate)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: InfiniteList<TicketModel>(
              onPage: controller.onPage,
              itemBuilder: (context, ticket) {
                var icon = Icon(
                  Kiwoo.sun,
                  size: 20.fs,
                  color: AppColors.YELLOW_CARD,
                );
                if (ticket.dayTime == DayTime.soir) {
                  icon = Icon(
                    Kiwoo.moon,
                    size: 20.fs,
                    color: AppColors.SUBTITLE,
                  );
                }
                return Card(
                  color: getTicketColor(ticket),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    onTap: () {
                      bottomSheetWidget(
                        // isScrollControlled: true,
                        clipBehavior: Clip.antiAlias,
                        backgroundColor: AppColors.APP_BG,
                        child: TicketDetailView(ticket: ticket),
                      );
                      // Get.to(() => TicketDetailView(idTicket: ticket.id),
                      //     routeName: "ticket_details");
                    },
                    subtitle:
                        Text("${ticket.totalWon}/${ticket.boulJwe.length}"),
                    title: Text.rich(
                      TextSpan(text: ticket.type.name.capitalize, children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.baseline,
                          baseline: TextBaseline.alphabetic,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: icon,
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
            )),
          ],
        ),
      ),
    );
  }
}
