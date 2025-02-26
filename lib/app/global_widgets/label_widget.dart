import 'package:flutter/material.dart';
import 'package:sizing/sizing_extension.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/font_family.dart';
import '../core/utils/kiwoo_icons.dart';

Widget lableWidget({String? lbl, String? val, Color? color}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: 135.ss,
        // color: Colors.amber,
        child: Text(
          lbl ?? "",
          style: TextStyle(
            fontSize: 15.fss,
            color: color ?? const Color(0xFF787878),
            fontFamily: FontPoppins.MEDIUM,
          ),
        ),
      ),
      Container(
        width: 152.ss,
        //color: Colors.blue,
        alignment: Alignment.centerRight,
        child: Text(
          val ?? "",
          style: TextStyle(
            fontSize: 15.fss,
            color: color ?? const Color(0xFF4A4A4A),
            fontFamily: FontPoppins.MEDIUM,
          ),
        ),
      ),
    ],
  );
}

Widget lableWidgetTitle({String? title, IconData? icon, VoidCallback? ontap}) {
  return ListTile(
    onTap: ontap,
    leading: Icon(
      icon,
      color: AppColors.APPBAR_PRIMARY1,
      size: 25.ss,
    ),
    title: Text(
      title ?? "",
      style: TextStyle(
          fontSize: 15.fss,
          fontFamily: FontPoppins.MEDIUM,
          color: const Color(0xff181D27)),
    ),
    trailing: const Icon(
      Kiwoo.angle_right,
    ),
  );
}
