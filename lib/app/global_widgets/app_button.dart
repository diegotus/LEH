import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/text_teme_helper.dart';
import 'box_decoration.dart';

class AppButton extends StatelessWidget {
  final String? buttonText;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final Color? color;
  const AppButton({
    super.key,
    this.buttonText,
    this.onTap,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 55.ss,
      width: width ?? 330.ss,
      decoration: color == null ? boxDecoratioAppBTN : const BoxDecoration(),
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
            backgroundColor: color,
            disabledBackgroundColor:
                color != null ? null : Colors.white.withOpacity(0.5)),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child:
              Text(buttonText ?? "", style: TextThemeHelper.buttonNormalWhite),
        ),
      ),
    );
  }
}

class AppButton2 extends StatelessWidget {
  final String? buttonText;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final Color? color;
  const AppButton2({
    super.key,
    this.buttonText,
    this.onTap,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 55.ss,
      width: width ?? 330.ss,
      decoration: borderBTN,
      child: MaterialButton(
        onPressed: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child:
              Text(buttonText ?? "", style: TextThemeHelper.buttonNormalGreen),
        ),
      ),
    );
  }
}

class DaiLogButton extends StatelessWidget {
  final String? buttonText;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final Color? color;
  const DaiLogButton({
    super.key,
    this.buttonText,
    this.onTap,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 55.ss,
      width: width ?? 330.ss,
      decoration: borderBTN,
      child: MaterialButton(
        onPressed: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Text(buttonText ?? "", style: TextThemeHelper.dailogButton),
        ),
      ),
    );
  }
}

class CustomButtonChild extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final Color? color;
  final BoxDecoration? decoration;
  const CustomButtonChild({
    super.key,
    this.width,
    this.height,
    this.color,
    this.decoration,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: decoration,
      child: child,
    );
  }
}

class DaiLogButtonPrimary extends StatelessWidget {
  final String? buttonText;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final Color? color;
  const DaiLogButtonPrimary({
    super.key,
    this.buttonText,
    this.onTap,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 55.ss,
      width: width ?? 330.ss,
      child: MaterialButton(
        onPressed: onTap,
        color: color ?? AppColors.APPBAR_PRIMARY1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Text(buttonText ?? "",
              style: TextThemeHelper.dailogButtonPrimary),
        ),
      ),
    );
  }
}

customeAuthButton(
    {String? lableName, VoidCallback? onTap, double? height, double? width}) {
  return Center(
    child: Container(
      height: height ?? 55.ss,
      width: width ?? 330.ss,
      decoration: boxDecorationBTN,
      child: MaterialButton(
        onPressed: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(lableName ?? "", style: TextThemeHelper.buttonNormalWhite),
              Icon(Icons.arrow_right, color: AppColors.WHITE)
            ],
            // retreg t66  erte 65479 tertrf rtrty ert
          ),
        ),
      ),
    ),
  );
}

customeAuthButton2(
    {String? lableName, VoidCallback? onTap, double? height, double? width}) {
  return Center(
    child: Container(
      height: height ?? 55.ss,
      width: width ?? 330.ss,
      decoration: borderBTN,
      child: MaterialButton(
        onPressed: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(lableName ?? "", style: TextThemeHelper.buttonNormalGreen),
              Icon(Icons.arrow_right, color: AppColors.PRIMARY)
            ],
          ),
        ),
      ),
    ),
  );
}

customeAuthButtonLoading({double? height, double? width}) {
  return Center(
    child: Container(
      height: height ?? 55.ss,
      width: width ?? 330.ss,
      decoration: boxDecorationBTN,
      child: MaterialButton(
        onPressed: null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: CircularProgressIndicator(
                color: AppColors.WHITE,
              )),
        ),
      ),
    ),
  );
}
