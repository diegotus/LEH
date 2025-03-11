// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/formatters/extension.dart';
import 'package:sizing/sizing_extension.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_string.dart';
import '../../core/utils/app_utility.dart';
import '../../core/utils/font_family.dart';
import '../label_widget.dart';

final _buttonFilledStyle = FilledButton.styleFrom(
  iconColor: const Color(0xff434343),
  textStyle: _textStyleButton,
  backgroundColor: const Color(0xffEDEDF5),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
);

final _textStyleButton = TextStyle(
  fontFamily: FontPoppins.REGULAR,
  fontSize: 14.fss,
  color: const Color(0xff434343),
);

class BottomSheetOption<T> {
  T? value;
  String label;
  String? subLabel;
  IconData? icon;
  Color iconColor;
  FutureOr<T?> Function()? onPressed;
  bool returnOnpressed;
  Widget Function(T?, void Function()? onPressed)? buildWidget;
  BottomSheetOption({
    this.value,
    required this.label,
    this.icon,
    this.onPressed,
    this.returnOnpressed = true,
    this.buildWidget,
    this.iconColor = const Color(0xff434343),
  });
}

Future<T?> boomSheetOptions<T>({
  required List<BottomSheetOption<T>> options,
  Widget Function(BottomSheetOption<T>)? buildWidget,
  FutureOr<T?> Function(T?)? onItemPressedPressed,
}) {
  return Get.bottomSheet<T>(
    Container(
      width: 1.sw,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.CHOOSE_OPTION,
            style: _textStyleButton.copyWith(
              fontSize: 20.fss,
              fontFamily: FontPoppins.BOLD,
            ),
          ),
          verticalSpaceMedium,
          ListView.separated(
            shrinkWrap: true,
            itemCount: options.length,
            separatorBuilder: (context, index) => verticalSpaceSmall,
            itemBuilder: (context, index) {
              var option = options[index];
              onPressed() async {
                if (onItemPressedPressed != null) {
                  await onItemPressedPressed(option.value);
                  Get.close();
                } else if (option.onPressed != null) {
                  if (option.returnOnpressed) {
                    var resp = await option.onPressed!();
                    Get.backLegacy(result: resp);
                  } else {
                    Get.backLegacy();
                    option.onPressed!();
                  }
                } else {
                  Get.backLegacy(result: option.value ?? index);
                }
              }

              return buildWidget != null
                  ? buildWidget(option)
                  : option.buildWidget?.call(option.value, onPressed) ??
                      FilledButton.icon(
                        style: _buttonFilledStyle.copyWith(
                          iconColor: WidgetStateProperty.all<Color?>(
                            option.iconColor,
                          ),
                        ),
                        onPressed: onPressed,
                        icon: option.icon == null ? null : Icon(option.icon),
                        label: ListTile(
                          dense: true,
                          titleAlignment: ListTileTitleAlignment.center,
                          title: Text(
                            option.label,
                            style: _textStyleButton,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
            },
          ),
          verticalSpaceSmall,
          TextButton(
              onPressed: () {
                Get.closeOverlay();
              },
              child: Text(
                AppStrings.CANCEL,
                style: _textStyleButton.copyWith(
                  color: Colors.red,
                ),
              ))
        ],
      ),
    ),
    backgroundColor: Colors.white,
  );
}

Future<T?> bottomSheetWidget<T>(
    {required Widget child,
    double? elevation,
    bool persistent = true,
    ShapeBorder? shape,
    Clip? clipBehavior,
    Color? barrierColor,
    bool? ignoreSafeArea,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    RouteSettings? settings,
    Duration? enterBottomSheetDuration,
    Duration? exitBottomSheetDuration,
    Color backgroundColor = Colors.white}) {
  return Get.bottomSheet<T>(
    child,
    backgroundColor: backgroundColor,
    elevation: elevation,
    persistent: persistent,
    shape: shape,
    clipBehavior: clipBehavior,
    barrierColor: barrierColor,
    ignoreSafeArea: ignoreSafeArea,
    isScrollControlled: isScrollControlled,
    useRootNavigator: useRootNavigator,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    settings: settings,
    enterBottomSheetDuration: enterBottomSheetDuration,
    exitBottomSheetDuration: exitBottomSheetDuration,
  );
}

Future<T?> loanDetailsBottomSHet<T>({
  required String title,
  String? name,
  double? amount,
  double? offeredInterest,
  int? offeredTenure,
  DateTime? updatedAt,
  DateTime? nextDue,
}) {
  return Get.bottomSheet<T>(
    SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.ss, horizontal: 25.ss),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20.fss,
                fontFamily: FontPoppins.SEMIBOLD,
              ),
            ),
            verticalSpaceMedium,
            lableWidget(lbl: "Name", val: name),
            SizedBox(height: 8.ss),
            lableWidget(
              lbl: "Amount",
              val: "$amount HTG",
            ),
            SizedBox(height: 8.ss),
            lableWidget(
              lbl: "Tenure",
              val: "$offeredTenure Months",
            ),
            SizedBox(height: 8.ss),
            lableWidget(
              lbl: "Interest",
              val: "$offeredInterest %",
            ),
            SizedBox(height: 8.ss),
            lableWidget(
              lbl: "Loan Given On",
              val: updatedAt?.since(),
            ),
            SizedBox(height: 8.ss),
            lableWidget(
              lbl: "Next EMI Receive Date",
              val: nextDue?.afterSince('dd, MMM yyyy'),
            ),
            SizedBox(height: 8.ss),
            lableWidget(
              lbl: "Loan Complete Date",
              val: updatedAt
                  ?.calculateLoanCompletionDate(offeredTenure ?? 0)
                  .format('dd, MMM yyyy'),
            ),
          ],
        ),
      ),
    ),
    backgroundColor: AppColors.APP_BG,
  );
}
