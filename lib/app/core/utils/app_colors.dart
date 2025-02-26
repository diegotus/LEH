// ignore_for_color: non_app_identifier_names

// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  static Color PRIMARY = const Color.fromARGB(255, 48, 136, 23);
  static Color PRIMARY1 = const Color.fromARGB(255, 48, 136, 23);
  static Color PRIMARY2 = const Color.fromARGB(255, 95, 191, 67);
  static Color PRIMARY3 = const Color(0xffe8ffe2);
  static Color adsa = Color.fromARGB(255, 111, 196, 87);
  static Color WHITE = Colors.white;
  static Color APP_BG = const Color.fromARGB(255, 245, 234, 234);
  static Color TEXT_FORM_FIELD =
      Color(0xFFEAF0F5); //const Color.fromARGB(255, 243, 243, 243);
  static Color BLACK = Colors.black;
  static Color SUBTITLE = Colors.black45;

  static Color APPBAR_PRIMARY1 = const Color.fromARGB(255, 57, 146, 32);
  static Color APPBAR_PRIMARY2 = const Color.fromARGB(255, 93, 189, 66);
  static Color PRIMARY_BG = Color.fromARGB(255, 236, 255, 231);
  static Color STATUS_BAR = const Color.fromARGB(255, 48, 136, 23);
  static Color APP_BAR_BG = STATUS_BAR;
  static Color LBL_TITLE_NAV = Colors.white;
  // static Color NAV_ICON = Colors.white;
  static Color SUCCESS = const Color.fromARGB(255, 95, 191, 67);
  // static Color FAIL = Colors.red;
  static Color CARD_PRIMARY = const Color.fromARGB(255, 232, 255, 226);
  static Color YELLOW_CARD = const Color.fromARGB(255, 255, 241, 170);

  static Color BLUE = const Color.fromARGB(255, 7, 3, 124);
}

class FontColors {
  static Color PRIMARY = const Color.fromARGB(255, 48, 136, 23);
  static Color PRIMARY1 = const Color.fromARGB(255, 57, 146, 32);
  static Color PRIMARY2 = const Color.fromARGB(255, 95, 191, 67);
  static Color WHITE = Colors.white;
  static Color BLACK = Colors.black;
  static Color BLACK_26 = const Color.fromARGB(255, 26, 26, 26);
  static Color RED = Colors.red;
  //static Color GREY = Colors.grey;
  static Color GREY = const Color.fromARGB(255, 122, 122, 122);
  static Color GREY_140 = const Color.fromARGB(255, 140, 140, 140);
  static Color BLUE_FADE = Color.fromARGB(255, 12, 36, 71);
}

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);
