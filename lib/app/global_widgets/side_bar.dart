import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/presentation_page_header.dart';
import '../routes/app_pages.dart';

class SideBarWidget extends GetView {
  const SideBarWidget({super.key, required this.appScreen});
  final Widget appScreen;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            color: AppColors.WHITE,
            width: 200.ss,
            child: Column(
              children: [
                DrawerHeader(
                  child: FittedBox(
                    child: PresentationHeaderLogo(
                      pageTitle: 'Jwe Pouw Genyen',
                      headerTopMargin: 10.ss,
                    ),
                  ),
                ),
                //mennu header
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.home,
                        ),
                        title: Text("Aket"),
                        onTap: () => Get.toNamed(Routes.HOME),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.wallet,
                        ),
                        title: Text("Jwe"),
                        // onTap: () => Get.toNamed(Routes.LOTTO_GAME),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.airplane_ticket,
                        ),
                        title: Text("Biyè"),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.dangerous,
                        ),
                        title: Text("Rezilta"),
                      ),
                    ],
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.dangerous,
                      ),
                      title: Text("Profil"),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.dangerous,
                      ),
                      title: Text("Reglaj"),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(child: appScreen)
        ],
      ),
    );
  }
}
