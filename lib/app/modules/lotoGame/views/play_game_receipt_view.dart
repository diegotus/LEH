import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/app_utility.dart';
import 'package:haiti_lotri/app/core/utils/formatters/extension.dart';
import 'package:haiti_lotri/app/global_widgets/list_builder_widget.dart';

import '../../../core/utils/app_colors.dart';
import '../../../global_widgets/app_bar.dart';
import '../../../routes/app_pages.dart';
import '../controllers/play_game_controller.dart';

class PlayGameReceiptView extends GetView<PlayGameController> {
  PlayGameReceiptView({super.key, required this.trasnactionId});
  final int trasnactionId;
  @override
  final PlayGameController controller =
      Get.put<PlayGameController>(PlayGameController());
  @override
  Widget build(BuildContext context) {
    final containData = false.obs;
    return Scaffold(
      appBar: AppBarWidgetTitle(
        title: 'Resi',
        height: 50,
        predicate: backUntil,
        actions: [
          Obx(
            () => Visibility(
              visible: containData.isTrue,
              child:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            ),
          ),
        ],
      ),
      body: FutureDataBuilder(
        onEmptyText: "Receipt Not Found",
        future: () => controller.callTicketReceiptApi(trasnactionId),

        // separatorBuilder: (p0, p1, item) {
        //   return Text(item.createdAt.since());
        // },

        futureBuilder: (context, item, _) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 5,
            ),
            itemCount: item.billets.length,
            separatorBuilder: (context, index) => verticalSpaceSmall,
            itemBuilder: (context, index) {
              final ticket = item.billets[index];
              return ExpansionTile(
                dense: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                maintainState: true,
                collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Text("Biyè #${ticket.id.toString().padLeft(8, "0")}"),
                subtitle: Text(ticket.getAmountTotal.toHLG),
                collapsedBackgroundColor: AppColors.WHITE,
                backgroundColor: AppColors.WHITE,
                children: [
                  ...ticket.boulJwe.map((el) {
                    var color = el.status.name == "win"
                        ? AppColors.PRIMARY
                        : el.status.name == "lost"
                            ? FontColors.RED
                            : Colors.grey.shade400;

                    return ListTile(
                      dense: true,
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...el.getboul(ticket.type).map(
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
                      subtitle: Text(el.amount.toHLG),
                      trailing: el.status.name == "win"
                          ? Text(
                              "${ticket.getWinningMultiple(el.boul)}",
                              style: Get.textTheme.titleLarge
                                  ?.copyWith(color: AppColors.PRIMARY),
                            )
                          : null,
                    );
                  })
                ],
              );
            },
          );
        },
        isEmpty: (t) {
          containData.value = t != null;
          return t == null;
        },
      ),
    );
  }

  bool backUntil(GetPage route) {
    return route.name == Routes.HOME;
  }
}
