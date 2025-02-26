// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';

import 'app_colors.dart';
import 'app_theme.dart';
import 'font_family.dart';

class TextThemeHelper {
  static get buttonNormalWhite => theme.textTheme.titleSmall?.copyWith(
      fontFamily: FontPoppins.MEDIUM,
      color: FontColors.WHITE,
      fontSize: 18.fss);

  static get buttonNormalGreen => theme.textTheme.titleSmall?.copyWith(
      fontFamily: FontPoppins.MEDIUM,
      //fontWeight: FontWeight.w500,
      color: FontColors.PRIMARY,
      fontSize: 18.fss);

  static get welcomeTitle => theme.textTheme.titleSmall?.copyWith(
      fontSize: 20.fss,
      color: FontColors.BLACK,
      fontFamily: FontPoppins.REGULAR);

  static get textFieldTitle => theme.textTheme.titleSmall?.copyWith(
      fontSize: 16.fss,
      color: FontColors.BLACK_26,
      fontFamily: FontPoppins.REGULAR);
  static get textFieldStar => theme.textTheme.titleSmall?.copyWith(
      fontSize: 16.fss, color: FontColors.RED, fontFamily: FontPoppins.REGULAR);
  static TextStyle? get appNameLarge => theme.textTheme.labelLarge?.copyWith(
        fontSize: 28.fss,
        color: const Color.fromRGBO(111, 196, 87, 1),
        fontFamily: FontPoppins.BOLD,
      );

  static get authTitle => theme.textTheme.titleMedium?.copyWith(
      fontSize: 17.fss,
      color: const Color.fromARGB(255, 58, 58, 58), //FontColors.BLACK,
      fontFamily: FontPoppins.REGULAR);

  static get authHeadlineSmall => theme.textTheme.headlineSmall?.copyWith(
      fontSize: 24.fss,
      color: FontColors.BLACK,
      fontFamily: FontPoppins.MEDIUM);

  static get textFormField => theme.textTheme.titleMedium?.copyWith(
      fontSize: 15.fss,
      color: FontColors.BLACK,
      fontFamily: FontPoppins.REGULAR);

  static get textFormFieldHintStyle => theme.textTheme.titleMedium?.copyWith(
      fontSize: 15.fss,
      color: const Color.fromARGB(255, 110, 110, 110),
      fontFamily: FontPoppins.LIGHT);

  static get lableTextFormField => theme.textTheme.titleMedium?.copyWith(
      fontSize: 15.fss,
      color: FontColors.BLACK,
      fontFamily: FontPoppins.REGULAR);

  static get forgotPassword => theme.textTheme.titleMedium?.copyWith(
      fontSize: 17.fss,
      color: const Color.fromARGB(255, 55, 143, 30),
      fontFamily: FontPoppins.REGULAR);

  static get registerHere => theme.textTheme.titleMedium?.copyWith(
        decoration: TextDecoration.underline,
        fontSize: 17.fss,
        color: const Color.fromARGB(255, 53, 141, 28),
        fontFamily: FontPoppins.REGULAR,
      );

  static get validationTitle => theme.textTheme.titleMedium?.copyWith(
        fontSize: 17.fss,
        color: AppColors.WHITE,
        fontFamily: FontPoppins.REGULAR,
      );

  static get headlineLarge => theme.textTheme.headlineLarge?.copyWith(
        fontSize: 36.fss,
        fontFamily: FontPoppins.REGULAR,
      );

  static get loanLender => theme.textTheme.titleSmall?.copyWith(
      fontSize: 14.fss,
      color: FontColors.BLACK_26,
      fontFamily: FontPoppins.REGULAR);

  static get dailogTitle => theme.textTheme.titleSmall?.copyWith(
      fontSize: 18.fss,
      fontFamily: FontPoppins.BOLD,
      color: FontColors.PRIMARY1);

  static get dailogSubTitle => theme.textTheme.titleSmall?.copyWith(
        fontSize: 12.fss,
        fontFamily: FontPoppins.REGULAR,
      );
  static get dailogButton => theme.textTheme.titleSmall?.copyWith(
        fontSize: 16.fss,
        fontFamily: FontPoppins.SEMIBOLD,
        color: FontColors.PRIMARY1,
      );
  static get dailogButtonPrimary => theme.textTheme.titleSmall?.copyWith(
        fontSize: 16.fss,
        fontFamily: FontPoppins.SEMIBOLD,
        color: FontColors.WHITE,
      );
  static get headerLineListLable => theme.textTheme.titleMedium?.copyWith(
      fontSize: 17.fss,
      fontFamily: FontPoppins.MEDIUM,
      color: FontColors.BLACK);

  static get titleLR => theme.textTheme.titleMedium?.copyWith(
      fontSize: 15.fss,
      fontFamily: FontPoppins.MEDIUM,
      color: FontColors.BLACK);

  static get subTitleGreyLR => theme.textTheme.titleSmall?.copyWith(
        fontSize: 14.fss,
        color: FontColors.GREY,
        fontFamily: FontPoppins.REGULAR,
      );

  static get subTitleLR => theme.textTheme.titleSmall?.copyWith(
        fontSize: 13.fss,
        color: FontColors.BLACK,
        fontFamily: FontPoppins.REGULAR,
      );

  static get HLGTextStyle => theme.textTheme.titleMedium?.copyWith(
      fontSize: 14.fss,
      fontFamily: FontPoppins.MEDIUM,
      color: FontColors.BLACK);

  static get sendTextFieldTitle => theme.textTheme.titleSmall?.copyWith(
      fontSize: 15.fss,
      color: FontColors.BLACK_26,
      fontFamily: FontPoppins.REGULAR);

  static get sendLoantTextFormField => theme.textTheme.titleMedium?.copyWith(
      fontSize: 15.fss,
      color: FontColors.BLACK,
      fontFamily: FontPoppins.REGULAR);

  static get sendLoanTextFormFieldHintStyle =>
      theme.textTheme.titleMedium?.copyWith(
          fontSize: 15.fss,
          color: const Color.fromARGB(255, 110, 110, 110),
          fontFamily: FontPoppins.LIGHT);
}
