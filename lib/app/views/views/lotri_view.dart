import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
                        const BottomNavigationBarItem(
                          icon: Icon(
                            Icons.home,
                          ),
                          label: 'Akey',
                        ),
                        // const BottomNavigationBarItem(
                        //   icon: Icon(
                        //     Icons.wallet,
                        //   ),
                        //   label: 'Bous',
                        // ),
                        const BottomNavigationBarItem(
                          icon: Icon(
                            Icons.wallet,
                          ),
                          label: 'Jwe',
                        ),
                        const BottomNavigationBarItem(
                          icon: Icon(
                            Icons.airplane_ticket,
                          ),
                          label: 'Biyè',
                        ),
                        const BottomNavigationBarItem(
                          icon: Icon(
                            Icons.dangerous,
                          ),
                          label: 'Rezilta',
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
