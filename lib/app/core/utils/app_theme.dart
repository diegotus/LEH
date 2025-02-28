import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haiti_lotri/app/core/utils/font_family.dart';
import 'package:sizing/sizing_extension.dart';

import 'app_colors.dart';

final TextStyle selectedStyle = TextStyle(
  fontFamily: FontPoppins.MEDIUM,
  color: AppColors.PRIMARY,
);
final TextStyle unselectedStyle = selectedStyle.copyWith(
  color: Colors.black,
);

ThemeData get theme => ThemeData(
      useMaterial3: true,
      fontFamily: FontPoppins.REGULAR,
      primaryColor: AppColors.PRIMARY,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: AppColors.APP_BG,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: TextStyle(
            fontFamily: FontPoppins.REGULAR,
            fontSize: 15,
          ),
        ),
      ),
      textTheme: TextTheme(
        labelLarge: TextStyle(
          color: AppColors.BLACK,
          fontFamily: FontPoppins.REGULAR,
          fontWeight: FontWeight.w400,
        ),
        titleSmall: TextStyle(
          color: AppColors.BLACK,
          fontFamily: FontPoppins.REGULAR,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: AppColors.BLACK,
          fontFamily: FontPoppins.REGULAR,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: AppColors.BLACK,
          //fontSize: getFontSize(10),
          fontFamily: FontPoppins.REGULAR,
          fontWeight: FontWeight.w400,
        ),
        titleLarge: TextStyle(
          color: AppColors.BLACK,
          //fontSize: getFontSize(22),
          fontFamily: FontPoppins.REGULAR,
          fontWeight: FontWeight.w700,
        ),
        labelSmall: TextStyle(
          color: AppColors.BLACK,
          //fontSize: getFontSize(10),
          fontFamily: FontPoppins.REGULAR,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          color: AppColors.BLACK,
          //fontSize: getFontSize(12),
          fontFamily: FontPoppins.REGULAR,
          fontWeight: FontWeight.w500,
        ),
        headlineSmall: TextStyle(
          color: AppColors.BLACK,
          //fontSize: getFontSize(24),
          fontFamily: FontPoppins.REGULAR,
          fontWeight: FontWeight.w700,
        ),
      ),
      colorScheme: ColorScheme.fromSwatch(
              primarySwatch: generateMaterialColor(AppColors.PRIMARY))
          .copyWith(surface: Colors.white),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.WHITE,
        elevation: 5,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontFamily: FontPoppins.REGULAR,
          fontSize: 12.fss,
          color: const Color.fromARGB(255, 26, 26, 26),
          fontWeight: FontWeight.w400,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: FontPoppins.REGULAR,
          fontSize: 12.fss,
          color: const Color.fromARGB(255, 151, 151, 151),
          fontWeight: FontWeight.w400,
        ),
        unselectedItemColor: const Color.fromARGB(255, 151, 151, 151),
        selectedItemColor: Colors.black,
        selectedIconTheme: IconThemeData(color: AppColors.PRIMARY2),
        showUnselectedLabels: true,
      ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: AppColors.PRIMARY2),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.PRIMARY2,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(textStyle: unselectedStyle),
    );
