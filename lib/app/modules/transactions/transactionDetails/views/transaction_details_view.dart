import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/formatters/extension.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/font_family.dart';
import '../../../../core/utils/function.dart';
import '../../../../core/utils/kiwoo_icons.dart';
import '../../../../core/utils/text_style.dart';
import '../../../../data/models/payment_receipt_model.dart';
import '../../../../data/models/transaction_model.dart';
import '../../../../global_widgets/app_bar.dart';
import '../../../../global_widgets/app_button.dart';
import '../../../../global_widgets/list_builder_widget.dart';
import '../../../../global_widgets/modal/bottom_sheet.dart';
import '../../../../global_widgets/ticket_widget.dart';
import '../controllers/transaction_details_controller.dart';

class TransactionDetailsView extends GetView<TransactionDetailsController> {
  const TransactionDetailsView({super.key});

  Widget build(BuildContext context) {
    final containData = false.obs;
    return Scaffold(
      appBar: AppBarWidgetTitle(
        title: '',
        height: 50,
        actions: [
          Obx(
            () => Visibility(
              visible: containData.isTrue,
              child:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            ),
          ),
          Obx(
            () => Visibility(
              visible: containData.isTrue,
              child: IconButton(onPressed: () {}, icon: const Icon(Icons.save)),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
        child: FutureDataBuilder<TransactionModel>(
            isEmpty: (p0) => p0 == null,
            future: () {
              return controller.getTransactionDetail().then((val) {
                if (val != null) {
                  containData.value = true;
                }
                return val;
              });
            },
            futureBuilder: (context, item, _) {
              var direction = item.direction(controller.phone);
              List<Map<String, dynamic>> listMap = [
                {
                  'title': AppStrings.TRANSACTION_TYPE,
                  "value": item.type.translate
                },
                {'title': "Method", "value": item.method.name},
                {
                  'title': "Direction",
                  "value": "directionName_${direction.name}".tr,
                },
                {'title': AppStrings.AMOUNT, "value": item.amount.toHLG},
                {'title': AppStrings.FEE, "value": item.fees.toHLG},
                {'title': AppStrings.TAX, "value": item.tax.toHLG},
              ];

              IconData? icon;
              double? iconSize;

              switch (item.type) {
                case TransactionType.lotoPlay:
                  icon = Kiwoo.dice;
                  listMap.removeRange(1, 3);
                  // iconSize = 0.1.sw;
                  continue transactionIcon;
                transactionIcon:
                case TransactionType.lotoWin:
                  iconSize = 0.15.sw;
                  icon ??= Kiwoo.win;
                  listMap.add({
                    "title": AppStrings.MORE_INFO,
                    "value": () {
                      bottomSheetWidget(
                          backgroundColor: AppColors.APP_BG,
                          child: TicketWidget(
                            future: () => controller.callTicketApi(item.id),
                          ));
                    },
                  });
                  break;
                case TransactionType.cash:
                  {
                    if (item.method == TransactionMethod.p2p) {
                      var user = direction == Direction.inbound
                          ? item.receiver
                          : item.user;
                      listMap.add({
                        "title": 'direPreposition_${direction.name}'.tr,
                        "value": user!.name,
                        'subtitle': user.phone
                      });
                    }
                  }
                default:
                  listMap.addAll([
                    {
                      'title': AppStrings.FROM,
                      "value": item.user?.name,
                      'subtitle': item.user?.phone
                    },
                    {
                      'title': AppStrings.TO,
                      "value": item.receiver?.name,
                      'subtitle': item.receiver?.phone
                    },
                  ]);
                  break;
              }

              return Column(
                children: [
                  //header
                  const SafeArea(child: verticalSpaceLarge),
                  //body

                  SizedBox(
                    width: 1.sw - .03.sw * 2,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(color: AppColors.PRIMARY),
                          ),
                          child: Column(
                            children: [
                              verticalSpaceLarge,
                              Text(
                                AppStrings.TRANSACTION_DETAIL,
                                style: titleDetailStyle.copyWith(
                                  fontFamily: FontPoppins.BOLD,
                                  fontSize: 17.fss,
                                ),
                              ),
                              Text(
                                  item.createdAt.format("MMM dd, yyyy hh:MM a"),
                                  style: titleDetailStyle.copyWith(
                                    fontFamily: FontPoppins.REGULAR,
                                    fontSize: 16.fss,
                                  )),
                              Text("ID # ${item.id.toString().padLeft(6, '0')}",
                                  style: titleDetailStyle.copyWith(
                                    fontFamily: FontPoppins.REGULAR,
                                    fontSize: 16.fss,
                                  )),
                              ListView.separated(
                                shrinkWrap: true,
                                primary: false,
                                itemCount: listMap.length,
                                itemBuilder: (context, index) {
                                  var currentVal = listMap[index];

                                  return Padding(
                                    padding: EdgeInsets.only(
                                        left: .06.sw,
                                        right: .06.sw,
                                        top: 0.01.sh,
                                        bottom: (index == listMap.length - 1
                                                ? 10
                                                : 0) +
                                            0.01.sh),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          currentVal['title'],
                                          textAlign: TextAlign.start,
                                          style: titleDetailStyle,
                                        ),
                                        currentVal['value'] is Function
                                            ? TextButton(
                                                onPressed: currentVal['value'],
                                                child:
                                                    Text(AppStrings.CLICK_HERE))
                                            : Text.rich(
                                                TextSpan(
                                                  text: currentVal['value'],
                                                  children: [
                                                    if (currentVal[
                                                            'subtitle'] !=
                                                        null)
                                                      TextSpan(
                                                          text:
                                                              "\n${currentVal['subtitle']}")
                                                  ],
                                                ),
                                                textAlign: TextAlign.end,
                                                style: titleDetailStyle,
                                              )
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    color: AppColors.PRIMARY,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: -0.08.sw,
                          child: CircleAvatar(
                            radius: 0.09.sw,
                            child: Icon(
                              icon,
                              size: iconSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpaceLarge,
                  //footer
                  AppButton(
                    buttonText: AppStrings.BACK,
                    onTap: Get.back,
                  ),
                ],
              );
            }),
      ),
    );
  }
}
