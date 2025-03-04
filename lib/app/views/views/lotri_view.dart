import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/app_string.dart';
import 'package:sizing/sizing_extension.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/font_family.dart';
import '../../routes/app_pages.dart';

class LotriView extends GetView {
  const LotriView({super.key});
  @override
  Widget build(BuildContext context) {
    print("the rooutes ${Get.rootController.rootDelegate.pageSettings?.name}");
    return GetRouterOutlet.builder(
        route: Routes.LOTRI,
        builder: (context) {
          return Scaffold(
            body: GetRouterOutlet(
              anchorRoute: Routes.LOTRI,
              initialRoute: Routes.HOME,
            ),
            extendBody: true,
            backgroundColor: Colors.white,
            bottomNavigationBar: Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    spreadRadius: 0,
                    blurRadius: 8,
                  ),
                ],
              ),
              height: 70,
              child: IndexedRouteBuilder(
                  routes: const [
                    Routes.HOME,
                    Routes.GAMES,
                    Routes.TICKETS,
                    Routes.LOTO_RESULTS
                  ],
                  builder: (context, routes, index) {
                    final delegate = context.delegate;
                    return BottomNavigationBar(
                      iconSize: 26.ss,
                      items: <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                          icon: const Icon(
                            Icons.home,
                          ),
                          label: AppStrings.HOME,
                        ),
                        // const BottomNavigationBarItem(
                        //   icon: Icon(
                        //     Icons.wallet,
                        //   ),
                        //   label: 'Bous',
                        // ),
                        BottomNavigationBarItem(
                          icon: const Icon(
                            Icons.wallet,
                          ),
                          label: AppStrings.PLAY,
                        ),
                        BottomNavigationBarItem(
                          icon: const Icon(
                            Icons.airplane_ticket,
                          ),
                          label: AppStrings.TICKERT,
                        ),
                        BottomNavigationBarItem(
                          icon: const Icon(
                            Icons.dangerous,
                          ),
                          label: AppStrings.RESULT,
                        ),
                      ],
                      currentIndex: index,
                      onTap: (value) {
                        delegate.toNamed(routes[value]);
                      },
                    );
                  }),
            ),
          );
        });
  }
}
