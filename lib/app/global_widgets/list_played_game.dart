import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/app_colors.dart';
import 'package:haiti_lotri/app/core/utils/formatters/extension.dart';
import 'package:sizing/sizing_extension.dart';

import '../core/utils/app_utility.dart';
import '../core/utils/font_family.dart';
import '../data/models/game_model.dart';

class ListPlayedGame extends StatelessWidget {
  const ListPlayedGame(
      {super.key, this.games = const [], this.onDelete, this.primary = false});
  final List<GameTirageModel> games;
  final bool primary;
  final void Function(GameTirageModel game)? onDelete;
  double get totalAmount => games.fold(0.0, (result, el) => el.amount + result);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.builder(
          shrinkWrap: true,
          primary: primary,
          itemCount: games.length,
          padding: EdgeInsets.only(top: 10),
          itemBuilder: (context, index) {
            final item = games[index];
            return ListTile(
              dense: true,
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...item.getboul.map(
                    (el) => CircleAvatar(
                      backgroundColor: Colors.grey.shade400,
                      radius: 15,
                      child: Text(el),
                    ),
                  )
                ],
              ),
              title: Text.rich(
                TextSpan(text: item.type.name.capitalize, children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: SizedBox(width: 35),
                  ),
                  if (item.option != null)
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.ss),
                        decoration: ShapeDecoration(
                          color: AppColors.PRIMARY3,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // Adds BorderRadius
                          ),
                        ),
                        child: Text(
                          item.option!.miniName,
                          style: TextStyle(
                              color: FontColors.PRIMARY,
                              fontFamily: FontPoppins.BOLD,
                              fontSize: 18.fs),
                        ),
                      ),
                    ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: SizedBox(width: 45),
                  ),
                  TextSpan(text: item.tirageName!.name),
                ]),
              ),
              subtitle: Text(item.amount.toHLG),
              trailing: onDelete != null
                  ? IconButton(
                      onPressed: () => onDelete!(item),
                      icon: Icon(Icons.delete))
                  : null,
            );
          },
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              color: Colors.grey,
              endIndent: 30,
              indent: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Total",
                  style: TextStyle(
                    fontFamily: FontPoppins.BOLD,
                    fontSize: 25.fs,
                  ),
                ),
                Text(
                  totalAmount.toHLG,
                  style: TextStyle(
                    fontFamily: FontPoppins.BOLD,
                    fontSize: 25.fs,
                  ),
                )
              ],
            ),
            verticalSpaceSmall,
          ],
        )
      ],
    );
  }
}
