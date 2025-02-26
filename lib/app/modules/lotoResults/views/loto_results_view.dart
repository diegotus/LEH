import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../core/utils/app_colors.dart' show AppColors;
import '../../../core/utils/app_utility.dart'
    show
        horizontalSpaceLarge,
        horizontalSpaceRegular,
        verticalSpaceLarge,
        verticalSpaceRegular;
import '../../../core/utils/enums.dart' show DayTime, TirageName;
import '../../../core/utils/formatters/extension.dart' show DateTimeExtention;
import '../../../core/utils/kiwoo_icons.dart' show Kiwoo;
import '../../../global_widgets/app_bar.dart' show AppBarWithWidgetTitle;
import '../../../global_widgets/list_builder_widget.dart'
    show ListBuilderWidget;
import '../controllers/loto_results_controller.dart' show LotoResultsController;

class LotoResultsView extends GetView<LotoResultsController> {
  const LotoResultsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithWidgetTitle(
        title: "Haiti Loto Rezilta",
        child: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
            color: Colors.white,
          ),
          labelColor: Colors.black,
          unselectedLabelColor: Colors.white,
          controller: controller.tabController,
          tabs: [
            Tab(text: 'NEW YORK'),
            Tab(text: 'FLORIDA'),
            Tab(text: 'GORGIA'),
          ],
        ),
      ),
      body: Center(
          child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 40.ss, vertical: 20.ss),
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  getResultaWidget(TirageName.NY),
                  getResultaWidget(TirageName.FL),
                  getResultaWidget(TirageName.GA),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  Widget getResultaWidget(TirageName tirage) {
    return ListBuilderWidget.future(
      onEmptyText: "Poko Gen tiraj",
      itemBuilder: (context, result, refreshFuture, [previous]) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              result.createdAt
                  .format("EEEE, dd MMMM, yyyy", locale: "fr")
                  .capitalize,
            ),
            verticalSpaceRegular,
            Row(
              children: [
                result.dayTime == DayTime.midi
                    ? Icon(
                        Kiwoo.sun,
                        size: 20.ss,
                        color: AppColors.YELLOW_CARD,
                      )
                    : Icon(
                        Kiwoo.moon,
                        size: 20.ss,
                        color: AppColors.BLUE,
                      ),
                horizontalSpaceLarge,
                circularBoul(result.firstLot),
                horizontalSpaceRegular,
                circularBoul(result.secondLot),
                horizontalSpaceRegular,
                circularBoul(result.thirdLot),
              ],
            )
          ],
        );
      },
      future: () => controller.callResultTirajApi(tirage),
      separatorBuilder: (context, index, item) {
        return verticalSpaceLarge;
      },
    );
  }

  Widget circularBoul(String boul) {
    return CircleAvatar(
      backgroundColor: AppColors.PRIMARY2,
      radius: 20,
      child: Text(boul),
    );
  }
}
