import 'package:flutter/material.dart';
import 'package:sizing/sizing_extension.dart';

import '../core/utils/font_family.dart';

class NotificationIconCount extends StatelessWidget {
  final Icon icon;
  final int count;

  const NotificationIconCount(
      {required this.icon, required this.count, super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        icon,
        if (count > 0)
          Positioned(
            right: -5,
            top: -5,
            child: CircleAvatar(
              radius: 8.ss,
              backgroundColor: Colors.red,
              child: Text(
                '$count',
                style:
                    TextStyle(fontFamily: FontPoppins.MEDIUM, fontSize: 8.ss),
              ),
            ),
          )
      ],
    );
  }
}
