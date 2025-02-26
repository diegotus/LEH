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
    return GetRouterOutlet.builder(
        route: Routes.LOTRI,
        builder: (context) {
          return Scaffold(
            body: GetRouterOutlet(
              anchorRoute: Routes.LOTRI,
              initialRoute: Routes.HOME,
            ),
            bottomNavigationBar: IndexedRouteBuilder(
                routes: const [
                  Routes.HOME,
                  Routes.GAMES,
                  Routes.TICKETS,
                  Routes.LOTO_RESULTS
                ],
                builder: (context, routes, index) {
                  final delegate = context.delegate;
                  return Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: AppColors.WHITE,
                      primaryColor: AppColors.PRIMARY2,
                      scaffoldBackgroundColor: Colors.red,
                      unselectedWidgetColor: Colors.red,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            spreadRadius: 0,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      height: 70,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)),
                        child: BottomNavigationBar(
                          backgroundColor: AppColors.WHITE,
                          elevation: 5,
                          type: BottomNavigationBarType.fixed,
                          iconSize: 26.ss,
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
                          unselectedItemColor:
                              const Color.fromARGB(255, 151, 151, 151),
                          selectedItemColor: Colors.black,
                          selectedIconTheme:
                              IconThemeData(color: AppColors.PRIMARY2),
                          showUnselectedLabels: true,
                          currentIndex: index,
                          onTap: (value) {
                            delegate.toNamed(routes[value]);
                          },
                        ),
                      ),
                    ),
                  );
                }),
          );
        });
  }
}
