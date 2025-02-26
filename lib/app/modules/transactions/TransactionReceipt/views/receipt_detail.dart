import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:haiti_lotri/app/core/utils/formatters/extension.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/font_family.dart';
import '../../../../core/utils/text_style.dart';

class ReceiptDetail extends StatelessWidget {
  const ReceiptDetail({
    super.key,
    required this.date,
    required this.type,
    required this.method,
    required this.amount,
    required this.fee,
    required this.status,
  });
  final DateTime date;
  final TransactionType type;
  final TransactionMethod method;
  final double amount;
  final double fee;
  final TransactionStatus status;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: BorderSide(
          color: FontColors.BLUE_FADE,
        ),
      ),
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Transactiond Details",
              style: transactionTitleDetailStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 17.fss,
              ),
            ),
            verticalSpaceMedium,
            rowTable("Date", date.format("DD, MMM yyyy")),
            verticalSpaceSmall,
            rowTable("Type Of Transaction", type.name.toUpperCase()),
            verticalSpaceSmall,
            rowTable("Transaction Method", method.name.toUpperCase()),
            verticalSpaceSmall,
            rowTable("Amount", amount.toHLG),
            verticalSpaceSmall,
            rowTable("Fee", fee.toHLG),
            verticalSpaceSmall,
            rowTable(
              "Status",
              status.name.capitalize ??
                  TransactionStatus.failed.name.capitalize!,
            ),
          ],
        ),
      ),
    );
  }

  Widget rowTable(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style: transactionTitleDetailStyle,
        ),
        Text.rich(
          TextSpan(
            text: value,
            // children: [
            //   if (currentVal['subtitle'] != null)
            //     TextSpan(text: "\n${currentVal['subtitle']}")
            // ],
          ),
          textAlign: TextAlign.end,
          style: transactionTitleDetailStyle.copyWith(
              fontFamily: FontPoppins.BOLD),
        )
      ],
    );
  }
}
