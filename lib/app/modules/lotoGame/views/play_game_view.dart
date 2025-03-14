import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/app_string.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../core/utils/actions/overlay.dart';
import '../../../core/utils/app_utility.dart';
import '../../../core/utils/enums.dart';
import '../../../core/utils/font_family.dart';
import '../../../core/utils/formatters/validation.dart';
import '../../../core/utils/kiwoo_icons.dart';
import '../../../core/utils/text_style.dart';
import '../../../data/models/game_model.dart';
import '../../../global_widgets/app_bar.dart';
import '../../../global_widgets/app_button.dart';
import '../../../global_widgets/input_field.dart';
import '../../../global_widgets/list_played_game.dart';
import '../../../global_widgets/next_result_widget.dart';
import '../controllers/play_game_controller.dart';

class PlayGame extends GetView<PlayGameController> {
  const PlayGame({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidgetTitle(title: AppStrings.PLAY),
        persistentFooterAlignment: AlignmentDirectional.center,
        persistentFooterButtons: [
          Obx(() {
            var isEmpty = controller.game.isEmpty;
            return AppButton(
                buttonText: AppStrings.PLAY,
                onTap: isEmpty
                    ? null
                    : () {
                        showOverlay(asyncFunction: controller.callJweGameApi);
                      });
          })
        ],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              NextResultWidget(key: ValueKey("nextresult")),
              verticalSpaceSmall,
              SizedBox(
                height: 220.ss,
                // width: 1.sw,
                child: CarouselView(
                  itemExtent: 0.95.sw,
                  itemSnapping: true,
                  shrinkExtent: 0.95.sw,
                  enableSplash: false,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  controller: controller.carouselController,
                  backgroundColor: Colors.red,
                  children: [
                    boletWidget(),
                    maryajWidget(),
                    lotto3Widget(),
                    lotto4Widget(),
                    lotto5Widget(),
                    lotto5p5Widget(),
                    royal5Widget(),
                  ],
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Card(
                    child: Obx(() {
                      print("game length ${controller.game.length}");
                      return ListPlayedGame(
                        games: [...controller.game],
                        onDelete: (game) => controller.game.remove(game),
                      );
                    }),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget boletWidget() {
    GameTirageModel tirage =
        GameTirageModel(type: Gametype.bolet, boul: '', amount: 0);
    return customBoletWidget(tirage.type, "50X 20X 10X", [
      boulInput(
        length: 2,
        onSaved: (value) {
          tirage.boul = value!;
          controller.tempGameTirage = tirage;
        },
      ),
      horizontalSpaceMedium,
      mizInput(
        onSaved: (value) {
          tirage.amount = double.parse(value!);
          controller.tempGameTirage = tirage;
        },
      ),
    ]);
  }

  Widget maryajWidget() {
    GameTirageModel tirage =
        GameTirageModel(type: Gametype.mariaj, boul: '', amount: 0);

    return customBoletWidget(tirage.type, "1000X", [
      boulInput(
        length: 2,
        onSaved: (value) {
          tirage.boul = value!;
          controller.tempGameTirage = tirage;
        },
      ),
      Icon(
        Kiwoo.close,
        color: Colors.white,
      ),
      boulInput(
        length: 2,
        onSaved: (value) {
          tirage.boul += value!;
          controller.tempGameTirage = tirage;
        },
      ),
      horizontalSpaceMedium,
      mizInput(
        onSaved: (value) {
          tirage.amount = double.parse(value!);
          controller.tempGameTirage = tirage;
        },
      ),
    ]);
  }

  Widget lotto3Widget() {
    GameTirageModel tirage =
        GameTirageModel(type: Gametype.lotto3, boul: '', amount: 0);
    return customBoletWidget(tirage.type, "500X", [
      boulInput(
        length: 3,
        onSaved: (value) {
          tirage.boul = value!;
          controller.tempGameTirage = tirage;
        },
      ),
      horizontalSpaceMedium,
      mizInput(
        onSaved: (value) {
          tirage.amount = double.parse(value!);
          controller.tempGameTirage = tirage;
        },
      ),
    ]);
  }

  Widget lotto4Widget() {
    GameTirageModel tirage =
        GameTirageModel(type: Gametype.lotto4, boul: '', amount: 0);
    return customBoletWidget(tirage.type, "5,000X", [
      boulInput(
        length: 2,
        onSaved: (value) {
          tirage.boul = value!;
          controller.tempGameTirage = tirage;
        },
      ),
      horizontalSpaceTiny,
      boulInput(
        length: 2,
        onSaved: (value) {
          tirage.boul += value!;
          controller.tempGameTirage = tirage;
        },
      ),
      horizontalSpaceMedium,
      mizInput(
        onSaved: (value) {
          tirage.amount = double.parse(value!);
          controller.tempGameTirage = tirage;
        },
      ),
    ]);
  }

  Widget lotto5Widget() {
    GameTirageModel tirage =
        GameTirageModel(type: Gametype.lotto5, boul: '', amount: 0);
    return customBoletWidget(tirage.type, "25,000X", [
      boulInput(
        length: 3,
        onSaved: (value) {
          tirage.boul = value!;
          controller.tempGameTirage = tirage;
        },
      ),
      horizontalSpaceTiny,
      boulInput(
        length: 2,
        onSaved: (value) {
          tirage.boul += value!;
          controller.tempGameTirage = tirage;
        },
      ),
      horizontalSpaceMedium,
      mizInput(
        onSaved: (value) {
          tirage.amount = double.parse(value!);
          controller.tempGameTirage = tirage;
        },
      ),
    ]);
  }

  Widget lotto5p5Widget() {
    GameTirageModel tirage =
        GameTirageModel(type: Gametype.lotto5p5, boul: '', amount: 5);

    return customBoletWidget(tirage.type, "200,464G", [
      boulInput(
        length: 3,
        onSaved: (value) {
          tirage.boul = value!;
          controller.tempGameTirage = tirage;
        },
      ),
      horizontalSpaceTiny,
      boulInput(
        length: 2,
        onSaved: (value) {
          tirage.boul += value!;
          controller.tempGameTirage = tirage;
        },
        autoFocus: false,
      ),
    ]);
  }

  Widget royal5Widget() {
    GameTirageModel tirage =
        GameTirageModel(type: Gametype.royal5, boul: '', amount: 25);
    return customBoletWidget(tirage.type, "1,021,649G", [
      boulInput(
        length: 3,
        onSaved: (value) {
          tirage.boul = value!;
          controller.tempGameTirage = tirage;
        },
      ),
      horizontalSpaceTiny,
      boulInput(
        length: 2,
        onSaved: (value) {
          tirage.boul += value!;
          controller.tempGameTirage = tirage;
        },
        autoFocus: false,
      ),
    ]);
  }

  Future changeFocus(
      String inputValue, int length, BuildContext context) async {
    final FocusScopeNode focus = FocusScope.of(context);
    if (inputValue.length == length) focus.nextFocus();
  }

  Widget boulInput(
      {required void Function(String?) onSaved,
      int length = 2,
      TextInputAction? textInputAction,
      bool autoFocus = true}) {
    return Builder(builder: (context) {
      return SizedBox(
        height: 50.ss,
        width: 60.ss,
        child: CustomInputFormField(
          contentPadding: EdgeInsets.all(8),
          hintText: AppStrings.PICK,
          onChanged: (mk) {
            if (autoFocus) changeFocus(mk, length, context);
          },
          textInputAction: textInputAction ?? TextInputAction.done,
          style: TextStyle(
            height: 2.ss,
          ),
          errorStyle: TextStyle(fontSize: 0),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 134, 61, 61), width: 2),
          ),
          textAlign: TextAlign.center,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          validator: (p0) {
            return isLength(p0, equal: length);
          },
          onSaved: onSaved,
          inputFormatters: [
            numberFormatter,
            LengthLimitingTextInputFormatter(length),
          ],
        ),
      );
    });
  }

  Widget mizInput({required void Function(String?) onSaved}) {
    return SizedBox(
      width: 85,
      height: 50.ss,
      child: CustomInputFormField(
        contentPadding: EdgeInsets.all(8),
        textAlign: TextAlign.center,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        hintText: AppStrings.BET,
        style: TextStyle(
          height: 2.ss,
        ),
        errorStyle: TextStyle(fontSize: 0),
        inputFormatters: [decimalNumberFormatter],
        validator: (p0) {
          return isEmptyValidator(p0) ??
              isBetweenValidator(double.parse(p0!), min: 1);
        },
        onSaved: onSaved,
      ),
    );
  }

  Widget customBoletWidget(
      Gametype type, String description, List<Widget> children) {
    final formKey = GlobalKey<FormState>();
    List<TirageName> listTirage = [];
    List<BoulOption> listOptions = [];
    return Form(
      key: formKey,
      child: Column(
        children: [
          Container(
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  type.description,
                  style: titleDetailStyle.copyWith(
                    color: Colors.white,
                    fontSize: 40.fss,
                    fontFamily: FontPoppins.BOLD,
                  ),
                ),
                horizontalSpaceMedium,
                Card(
                  // padding: EdgeInsets.all(5),
                  color: Colors.white30,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      description,
                      style: TextStyle(
                          fontFamily: FontPoppins.ITALIC,
                          fontSize: 13.fs,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          verticalSpaceSmall,
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          ),
          if ([Gametype.lotto4, Gametype.lotto5].contains(type))
            Row(
              children: [
                typeGame('${AppStrings.option} 1', initialValue: true,
                    onSaved: (value) {
                  if (value == true) {
                    listOptions.add(BoulOption.option1);
                  } else {
                    listOptions.remove(BoulOption.option1);
                  }
                }),
                typeGame('${AppStrings.option} 2', onSaved: (value) {
                  if (value == true) {
                    listOptions.add(BoulOption.option2);
                  } else {
                    listOptions.remove(BoulOption.option2);
                  }
                }),
                typeGame('${AppStrings.option} 3', onSaved: (value) {
                  if (value == true) {
                    listOptions.add(BoulOption.option3);
                  } else {
                    listOptions.remove(BoulOption.option3);
                  }
                }),
              ],
            ),
          Row(
            children: [
              typeGame(AppStrings.DRAW("NY"), initialValue: true,
                  onSaved: (value) {
                if (value == true) {
                  listTirage.add(TirageName.NY);
                } else {
                  listTirage.remove(TirageName.NY);
                }
              }),
              typeGame(AppStrings.DRAW("FL"), onSaved: (value) {
                if (value == true) {
                  listTirage.add(TirageName.FL);
                } else {
                  listTirage.remove(TirageName.FL);
                }
              }),
              typeGame(AppStrings.DRAW("GA"), onSaved: (value) {
                if (value == true) {
                  listTirage.add(TirageName.GA);
                } else {
                  listTirage.remove(TirageName.GA);
                }
              }),
            ],
          ),
          SizedBox(
            width: double.infinity,
            height: 35.ss,
            child: FilledButton(
              style: FilledButton.styleFrom(
                padding: EdgeInsets.all(5),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.zero)),
              ),
              onPressed: children.isEmpty
                  ? null
                  : () {
                      if (formKey.currentState?.validate() == true) {
                        formKey.currentState?.save();
                        for (var el in listTirage) {
                          if (listOptions.isEmpty) {
                            print(
                                "game length adding ${controller.game.length}");
                            controller.game.add(controller.tempGameTirage!
                                .copyWith(tirageName: el));
                          } else {
                            print("option length ${listOptions.length}");
                            for (var op in listOptions) {
                              controller.game.add(controller.tempGameTirage!
                                  .copyWith(tirageName: el, option: op));
                            }
                          }
                        }
                        listTirage.clear();
                        listOptions.clear();
                      }
                    },
              child: Text(
                AppStrings.ADD,
                style: TextStyle(
                  fontFamily: FontPoppins.BOLD,
                  fontSize: 15.fs,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget typeGame(String name,
      {void Function(bool?)? onSaved, bool initialValue = false}) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: TextStyle(
                fontSize: 18.fs,
                fontFamily: FontPoppins.REGULAR,
                color: Colors.white),
          ),
          SizedBox(
            width: 30.ss,
            child: CustomCheckBoxForm(
              initialValue: initialValue,
              onSaved: onSaved,
              side: BorderSide(color: Colors.white, width: 2),
            ),
          )
        ],
      ),
    );
  }
}
