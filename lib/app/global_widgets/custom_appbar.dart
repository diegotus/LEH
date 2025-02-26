// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/font_family.dart';
import '../core/utils/kiwoo_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final BuildContext contextMain;
  final String title;
  final bool isLeftShow;
  //final bool isRightShow;
  final bool isNavigationBg;
//   final IconData rightIcon;
  List<Widget> actions;
  final GestureTapCallback onPressedLeft;
  //final GestureTapCallback onPressedRight;

  CustomAppBar(
      this.contextMain,
      this.title,
      this.isLeftShow,
      //this.isRightShow,
      this.isNavigationBg,
      //this.rightIcon,
      this.actions,
      this.onPressedLeft,
      // this.onPressedRight,
      {super.key})
      : preferredSize = isNavigationBg
            ? const Size.fromHeight(60.0)
            : const Size.fromHeight(0.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          colors: [AppColors.APPBAR_PRIMARY1, AppColors.APPBAR_PRIMARY2],
          stops: const [0, 1],
        ),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        leading: isLeftShow
            ? Padding(
                padding: const EdgeInsets.only(left: 10),
                child: IconButton(
                  icon: Icon(
                    Kiwoo.arrow_left,
                    size: 18.ss,
                    //    scale: 3.5,
                  ),
                  onPressed: () {
                    Get.back(result: true);
                    onPressedLeft();
                  },
                ),
              )
            : null,
        centerTitle: true,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.LBL_TITLE_NAV,
            fontSize: 20,
            fontFamily: FontPoppins.SEMIBOLD,
          ),
        ),
        actions: actions,

        //    <Widget>[
        //      isRightShow
        //          ? IconButton(
        //              icon: Icon(
        //                rightIcon,
        //                color: AppColors.NAV_ICON,
        //              ),
        //              tooltip: "logout",
        //              onPressed: () {
        //                onPressedRight();
        //              },
        //            )
        //          : Container(),
        //    ],
      ),
    );
  }
}
