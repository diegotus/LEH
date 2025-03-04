import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/image_name.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../generated/locales.g.dart';
import 'app_colors.dart';
import 'app_string.dart';
import 'app_utility.dart';
import 'kiwoo_icons.dart';
import 'text_teme_helper.dart';

class PresentationPageHeader extends GetWidget {
  const PresentationPageHeader(
      {super.key, required this.pageTitle, this.headerTopMargin});
  final String pageTitle;
  final double? headerTopMargin;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: headerTopMargin ?? 90.ss),
        Center(
          child: Column(
            children: [
              Image.asset(ImgName.LOGO, width: 100.ss),
              verticalSpaceSmall,
              Text(
                AppStrings.SLOGAN.tr,
                textAlign: TextAlign.center,
                style: TextThemeHelper.authTitle,
              ),
            ],
          ),
        ),
        verticalSpaceRegular,
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.ss,
          ),
          child: Text(
            pageTitle,
            textAlign: TextAlign.center,
            style: TextThemeHelper.authHeadlineSmall,
          ),
        ),
      ],
    );
  }
}

class PresentationHeaderLogo extends GetWidget {
  const PresentationHeaderLogo(
      {super.key, required this.pageTitle, this.headerTopMargin});
  final String pageTitle;
  final double? headerTopMargin;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: headerTopMargin ?? 90.ss),
        Center(
          child: Image.asset(ImgName.LOGO, width: 90.ss),
        ),
        verticalSpaceRegular,
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.ss,
          ),
          child: Text(
            pageTitle,
            textAlign: TextAlign.center,
            style: TextThemeHelper.appNameLarge?.copyWith(fontSize: 13.fs),
          ),
        ),
      ],
    );
  }
}
