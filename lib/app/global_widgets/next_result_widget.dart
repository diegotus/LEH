import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/app_colors.dart';
import 'package:haiti_lotri/app/core/utils/app_string.dart';
import 'package:haiti_lotri/app/core/utils/formatters/extension.dart';
import 'package:haiti_lotri/app/data/models/tirage_model.dart';
import 'package:haiti_lotri/app/global_widgets/count_down.dart';
import 'package:haiti_lotri/app/global_widgets/list_builder_widget.dart';
import 'package:sizing/sizing_extension.dart';

import '../core/utils/app_utility.dart';
import '../core/utils/font_family.dart';
import '../core/utils/image_name.dart';

class NextResultWidget extends GetView {
  const NextResultWidget({
    super.key,
    required this.future,
  });
  final Future<List<NextTirageModel>?> Function()? future;

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
            width: 150.ss,
            child: ListBuilderWidget<NextTirageModel>.future(
                future: future,
                pullRefresh: false,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, el, refreshFuture, [_]) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          el.name,
                          style: TextStyle(
                            color: FontColors.PRIMARY,
                            fontFamily: FontPoppins.BOLD,
                          ),
                        ),
                        horizontalSpaceSmall,
                        CountDownWidget(
                          title: el.name,
                          duration: el.date.toDuration(),
                          onDone: () => refreshFuture!(),
                          style: TextStyle(
                            color: FontColors.PRIMARY,
                            fontFamily: FontPoppins.BOLD,
                          ),
                          animationBuilder: (animation, style) => _CountdownBox(
                            animation: animation,
                            style: style,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
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
      width: 30,
      height: 30,
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
