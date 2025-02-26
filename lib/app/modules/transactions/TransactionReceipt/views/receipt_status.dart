// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:haiti_lotri/app/core/utils/formatters/extension.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/kiwoo_icons.dart';
import '../../../../core/utils/text_style.dart';

class _ReceiptStatusData {
  IconData icon;
  MaterialColor color;
  String title;
  String subtitle;
  _ReceiptStatusData.success({
    this.icon = Kiwoo.check_circle,
    this.color = Colors.green,
    this.title = "Payment Successfull",
    this.subtitle = "Successful paid %s",
  });
  _ReceiptStatusData.failed({
    this.icon = Kiwoo.times_circle,
    this.color = Colors.red,
    this.title = "Payment Unsuccessfull",
    this.subtitle = "Unsuccessful paid %s",
  });
}

class ReceiptStatus extends StatelessWidget {
  const ReceiptStatus({
    super.key,
    required this.amount,
    required this.status,
  });

  final double amount;
  final TransactionStatus status;
  _ReceiptStatusData get _data {
    if (status == TransactionStatus.success) {
      return _ReceiptStatusData.success();
    }
    return _ReceiptStatusData.failed();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: _data.color.shade50,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              _data.icon,
              color: _data.color,
              size: 50,
            ),
          ),
        ),
        verticalSpaceSmall,
        Text(
          _data.title,
          style: transactionTitleDetailStyle.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20.fss,
          ),
        ),
        Text(
          _data.subtitle.trArgs([amount.toHLG]),
          style: transactionTitleDetailStyle.copyWith(
            fontSize: 18.fss,
          ),
        ),
      ],
    );
  }
}
