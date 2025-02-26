// ignore_for_file: constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
double heightMQ(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 932) * screenHeight; //800.0
}

// Get the proportionate height as per screen size
double widthMQ(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 430) * screenWidth; // 375.0
}

//--------------------------------------------------------------------------------------//
double getFontSize(double px) {
  return getSize(px);
}

double getSize(double px) {
  var height = getVerticalSize(px);
  var width = getHorizontalSize(px);
  if (height < width) {
    return height.toInt().toDouble();
  } else {
    return width.toInt().toDouble();
  }
}

double getVerticalSize(double px) {
  return ((px * height) / (FIGMA_DESIGN_HEIGHT - FIGMA_DESIGN_STATUS_BAR));
}

double getHorizontalSize(double px) {
  return ((px * width) / FIGMA_DESIGN_WIDTH);
}

const num FIGMA_DESIGN_WIDTH = 430; //360
const num FIGMA_DESIGN_HEIGHT = 932; //800
const num FIGMA_DESIGN_STATUS_BAR = 0;

get height {
  num statusBar =
      MediaQueryData.fromView(WidgetsBinding.instance.window).viewPadding.top;
  num bottomBar = MediaQueryData.fromView(WidgetsBinding.instance.window)
      .viewPadding
      .bottom;
  num screenHeight = size.height - statusBar - bottomBar;
  return screenHeight;
}

get width {
  return size.width;
}

MediaQueryData mediaQueryData = MediaQueryData.fromView(ui.window);
Size size = WidgetsBinding.instance.window.physicalSize /
    WidgetsBinding.instance.window.devicePixelRatio;
//--------------------------------------------------------------------------------------//
