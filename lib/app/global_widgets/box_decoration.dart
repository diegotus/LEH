import 'package:flutter/material.dart';

import '../core/utils/app_colors.dart';

Gradient linearGradientBtnCTM() {
  return LinearGradient(
    colors: [AppColors.PRIMARY1, AppColors.PRIMARY2],
  );
}

BoxDecoration get boxDecorationBTN {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    gradient: LinearGradient(
      colors: [AppColors.PRIMARY1, AppColors.PRIMARY2],
    ),
  );
}

BoxDecoration get boxDecoratioAppBTN {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: const [0.35, 1],
      colors: [AppColors.PRIMARY1, AppColors.PRIMARY2],
    ),
  );
}

BoxDecoration get borderBTN {
  return BoxDecoration(
    border: Border.all(
      color: AppColors.PRIMARY1,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(30),
  );
}

BoxDecoration get appBarBoxDecoration {
  return BoxDecoration(
    borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
    // gradient: LinearGradient(
    //   begin: Alignment.topLeft,
    //   end: Alignment.topRight,
    //   colors: [AppColors.APPBAR_PRIMARY1, AppColors.APPBAR_PRIMARY2],
    //   stops: const [0, 1],
    // ),
  );
}

BoxDecoration get desktopAppBarBoxDecoration {
  return BoxDecoration(
    color: AppColors.APP_BG,
  );
}
