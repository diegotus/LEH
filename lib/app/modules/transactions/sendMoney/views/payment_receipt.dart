import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/formatters/extension.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/font_family.dart';
import '../../../../global_widgets/app_button.dart';
import '../../../../data/models/payment_receipt_model.dart';
import '../../../../routes/app_pages.dart';

final _titleStile = TextStyle(
  fontSize: 12.fss,
  color: FontColors.BLUE_FADE,
  fontFamily: FontPoppins.REGULAR,
);

class PaymentReceipt extends GetView {
  const PaymentReceipt({super.key, required this.receipt});
  final PaymentReceiptData receipt;
  List<Map<String, dynamic>> get listMap => [
        {'title': "Amount", "value": receipt.amount.toHLG},
        {'title': "Fee", "value": receipt.fees.toHLG},
        {'title': "tax", "value": receipt.tax.toHLG},
        {
          'title': "from",
          "value": receipt.senderInfo.name,
          'subtitle': receipt.senderInfo.phone
        },
        {
          'title': "To",
          "value": receipt.receiverInfo?.name,
          'subtitle': receipt.receiverInfo?.phone
        },
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
        child: Column(
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
                          "Successful Transaction",
                          style: _titleStile.copyWith(
                            fontFamily: FontPoppins.BOLD,
                            fontSize: 17.fss,
                          ),
                        ),
                        Text("ID # ${receipt.id.toString().padLeft(6, '0')}",
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
                                  bottom:
                                      (index == listMap.length - 1 ? 10 : 0) +
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
                                        if (currentVal['subtitle'] != null)
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
            Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
                horizontalSpaceRegular,
                IconButton(onPressed: () {}, icon: const Icon(Icons.save)),
                horizontalSpaceRegular,
                Expanded(
                  child: AppButton(
                    buttonText: "HOME",
                    height: 40,
                    onTap: () => Get.offAllNamed(Routes.HOME),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/*
 Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 0.05.sw, vertical: 15),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        horizontalSpaceSmall,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "Frantzly Dumeny Jean jacques",
                                      style: _titleStile.copyWith(
                                        fontSize: 13.fss,
                                        fontFamily: FontFamily.POPPINS_BOLD,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    10000.toHLG,
                                    style: _titleStile.copyWith(
                                      fontSize: 13.fss,
                                      fontFamily: FontFamily.POPPINS_BOLD,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Recipient",
                                    style: _titleStile.copyWith(
                                      fontSize: 13.fss,
                                      fontFamily: FontFamily.POPPINS_REGULAR,
                                    ),
                                  ),
                                  Text(
                                    "Amount",
                                    style: _titleStile.copyWith(
                                      fontSize: 13.fss,
                                      fontFamily: FontFamily.POPPINS_REGULAR,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (
                      _,
                      index,
                    ) {
                      var currentEl = listMap[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${currentEl['title']}",
                              style: _titleStile,
                            ),
                            Text(
                              "${currentEl['value']}",
                              style: _titleStile,
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return verticalSpaceMedium;
                    },
                    itemCount: listMap.length,
                  )
                ],
              ),
            
*/
