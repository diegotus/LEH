import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/formatters/extension.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_utility.dart';
import '../../../core/utils/font_family.dart';
import '../../../global_widgets/app_bar.dart';
import '../../../global_widgets/app_button.dart';
import '../../../global_widgets/list_builder_widget.dart';
import '../../../data/models/payment_receipt_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/transactions_controller.dart';

final _titleStile = TextStyle(
  fontSize: 12.fss,
  color: FontColors.BLUE_FADE,
  fontFamily: FontPoppins.REGULAR,
);

class TransactionCashDetailView extends GetView<TransactionsController> {
  const TransactionCashDetailView({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    final containData = false.obs;
    return Scaffold(
      appBar: AppBarWidgetTitle(
        title: '',
        height: 50,
        predicate: (route) =>
            Get.currentRoute != Routes.CASH_IN ||
            Get.currentRoute != Routes.CASH_OUT,
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
        child: FutureDataBuilder<PaymentReceiptData>(
            isEmpty: (p0) => p0 == null,
            future: () async {
              return controller.getTransactionDetail(id).then((val) {
                if (val != null) {
                  containData.value = true;
                }
                return val;
              });
            },
            futureBuilder: (context, item, _) {
              List<Map<String, dynamic>> listMap = [
                {'title': "Amount", "value": item.amount.toHLG},
                {'title': "Fee", "value": item.fees.toHLG},
                {'title': "tax", "value": item.tax.toHLG},
                {
                  'title': "from",
                  "value": item.senderInfo.name,
                  'subtitle': item.senderInfo.phone
                },
                {
                  'title': "To",
                  "value": item.receiverInfo.name,
                  'subtitle': item.receiverInfo.phone
                },
              ];
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
                                "Transaction Details",
                                style: _titleStile.copyWith(
                                  fontFamily: FontPoppins.BOLD,
                                  fontSize: 17.fss,
                                ),
                              ),
                              Text(
                                  item.createdAt.format("MMM dd, yyyy hh:MM a"),
                                  style: _titleStile.copyWith(
                                    fontFamily: FontPoppins.REGULAR,
                                    fontSize: 16.fss,
                                  )),
                              Text("ID # ${item.id.toString().padLeft(6, '0')}",
                                  style: _titleStile.copyWith(
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
                                          style: _titleStile,
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            text: currentVal['value'],
                                            children: [
                                              if (currentVal['subtitle'] !=
                                                  null)
                                                TextSpan(
                                                    text:
                                                        "\n${currentVal['subtitle']}")
                                            ],
                                          ),
                                          textAlign: TextAlign.end,
                                          style: _titleStile,
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
                            child: const Icon(Icons.person),
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpaceLarge,
                  //footer
                  AppButton(
                    buttonText: "Back",
                    onTap: Get.back,
                  ),
                ],
              );
            }),
      ),
    );
  }
}
