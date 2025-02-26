import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_utility.dart';
import '../../../global_widgets/app_bar.dart';
import '../../../global_widgets/next_result_widget.dart';
import '../controllers/games_controller.dart';

class GamesView extends GetView<GamesController> {
  const GamesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidgetTitle(title: "Haiti Loto"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            verticalSpaceSmall,
            NextResultWidget(future: controller.callNextTiragesAPI),
            verticalSpaceSmall,
            Expanded(
              child: GridView.builder(
                  itemCount: controller.listGame.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    crossAxisCount: 2,
                    childAspectRatio: 4 / 2,
                  ),
                  itemBuilder: (context, index) {
                    var item = controller.listGame[index];
                    return InkWell(
                      onTap: item['onTap'],
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        color: AppColors.APPBAR_PRIMARY1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (item['image'] != null)
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: imageFromAssets(
                                        item['image'],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            Text(item['description']),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
