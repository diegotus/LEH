// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';

import '../core/utils/font_family.dart';

class ListTileCard extends StatelessWidget {
  final void Function()? onTap;
  final Widget? leading;
  final Widget? trailing;
  final String title;
  final String subTitle;
  final bool isThreeLine;

  const ListTileCard({
    super.key,
    this.onTap,
    this.leading,
    this.trailing,
    required this.title,
    required this.subTitle,
    this.isThreeLine = false,
  });
  @override
  Widget build(BuildContext context) {
    var contentPadding = const EdgeInsetsDirectional.only(start: 16.0, end: 0);
    // .subtract(EdgeInsets.only(right: 24));
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                onTap: onTap,
                leading: leading,
                contentPadding: contentPadding,
                title: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.fss,
                    color: const Color(0xFF1A1A1A),
                    fontFamily: FontPoppins.MEDIUM,
                  ),
                ),
                subtitle: Text(
                  subTitle,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.fss,
                    color: const Color(0xFF7A7A7A),
                    fontFamily: FontPoppins.REGULAR,
                  ),
                ),
                isThreeLine: isThreeLine,
              ),
            ),
            if (trailing != null) trailing!
          ],
        ),
      ),
    );
  }
}
