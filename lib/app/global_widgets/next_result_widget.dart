import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/app_colors.dart';
import 'package:haiti_lotri/app/core/utils/app_string.dart';
import 'package:haiti_lotri/app/core/utils/formatters/extension.dart';
import 'package:haiti_lotri/app/data/models/tirage_model.dart';
import 'package:haiti_lotri/app/global_widgets/count_down.dart';
import 'package:haiti_lotri/app/global_widgets/list_builder_widget.dart';
import 'package:haiti_lotri/app/modules/games/providers/lotto_game_provider.dart';
import 'package:sizing/sizing_extension.dart';

import '../core/utils/app_utility.dart';
import '../core/utils/font_family.dart';
import '../core/utils/image_name.dart';

class NextResultController extends GetxController {
  late final LottoGameProvider provider;
  List<NextTirageModel> previousResult = [];
  @override
  onInit() {
    provider = Get.putOrFind(() => LottoGameProvider());
    super.onInit();
  }

  Future<List<NextTirageModel>> callNextTiragesAPI() async {
    if (previousResult.isNotEmpty) return previousResult;
    var response = await provider.getNextTirageApi();
    if (response?.isSuccess == true) {
      previousResult = listNextTirageModel(response!.data);
      return previousResult;
    }
    return [];
  }
}

class NextResultWidget extends GetWidget<NextResultController> {
  const NextResultWidget({
    super.key,
  });
  @override
  get controller => Get.put(NextResultController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125.ss,
      width: 1.sw,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage(ImgName.CARD_IMG),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            child: ListTile(
              dense: true,
              title: Text(
                AppStrings.NEXT_TIRAGE,
                style: TextStyle(
                  color: FontColors.PRIMARY,
                  fontFamily: FontPoppins.BOLD,
                ),
              ),
              subtitle: Text(
                DateTime.now()
                    .format("dd MMMM yyyy", locale: Get.locale?.toLanguageTag())
                    .capitalize,
                style: TextStyle(
                  color: FontColors.PRIMARY,
                  fontFamily: FontPoppins.LIGHT,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 140.ss,
            child: Center(
              child: ListBuilderWidget<NextTirageModel>.future(
                  padding: EdgeInsets.zero,
                  future: controller.callNextTiragesAPI,
                  pullRefresh: false,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, el, refreshFuture, [_]) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.ss),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Text(
                              el.name,
                              style: TextStyle(
                                color: FontColors.PRIMARY,
                                fontFamily: FontPoppins.BOLD,
                              ),
                            ),
                          ),
                          CountDownWidget(
                            title: el.name,
                            duration: el.date.toDuration(),
                            onDone: () {
                              controller.previousResult.clear();
                              return refreshFuture!();
                            },
                            style: TextStyle(
                              color: FontColors.PRIMARY,
                              fontFamily: FontPoppins.BOLD,
                            ),
                            animationBuilder: (animation, style) =>
                                _CountdownBox(
                              animation: animation,
                              style: style,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
          horizontalSpaceMedium
        ],
      ),
    );
  }
}

class _CountdownBox extends CountDownAnimationBuilder {
  const _CountdownBox({required super.animation, super.style});

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);
    String hour = clockTimer.inHours.remainder(24).toString().padLeft(2, '0');
    String minutes =
        clockTimer.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconde =
        clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0');

    final text = [
      horizontalSpaceTiny,
      Text(
        ":",
        style: TextStyle(
            fontSize: 20.fss,
            color: FontColors.WHITE,
            fontFamily: FontPoppins.BOLD,
            shadows: [
              Shadow(
                blurRadius: 8.0,
                color: const Color.fromARGB(255, 2, 111, 5),
              ),
            ]),
      ),
      horizontalSpaceTiny,
    ];
    return Row(
      children: [
        box(hour),
        ...text,
        box(minutes),
        ...text,
        box(seconde),
      ],
    );
  }

  Widget box(String text) {
    return Container(
      width: 25.ss,
      height: 25.ss,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }
}
