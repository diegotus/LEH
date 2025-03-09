import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/app_string.dart';
import 'package:sizing/sizing_extension.dart';

import '../controllers/app_services_controller.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/app_utility.dart';
import '../core/utils/cache_manager.dart';
import '../core/utils/font_family.dart';
import '../core/utils/kiwoo_icons.dart';
import '../routes/app_pages.dart';
import 'avatar_network_image.dart';
import 'box_decoration.dart';
import 'notification_icon_count.dart';

class AppBarWidget extends GetResponsiveView<AppServicesController>
    implements PreferredSizeWidget {
  AppBarWidget({super.key});

  @override
  Widget? desktop() {
    final textColor = AppColors.PRIMARY;
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 90.ss,
      flexibleSpace: Container(decoration: desktopAppBarBoxDecoration),
      title: Text(
        AppStrings.APP_NAME.tr,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          fontSize: 23.fss,
          color: textColor,
          fontFamily: FontPoppins.BOLD,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: InkWell(
            onTap: () {
              // Get.toNamed(Routes.NOTIFICATIONS);
            },
            child: Obx(() {
              var newNotifCount = 0.obs;
              // var newNotifCount = controller.notifications
              //     .fold(0, (value, element) => value + (!element.read ? 1 : 0));
              return NotificationIconCount(
                icon: Icon(Kiwoo.bell, size: 30.ss, color: textColor),
                count: newNotifCount.value,
              );
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(
                () {
                  var avatar = controller.userDetails.value?.avatar;
                  // avatar = "18tCBcK1_BjZpu_vXdhoRJXzr3KwNvy_C";
                  return Container(
                    height: 55.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: textColor,
                    ),
                    child: avatarImage(
                      avatar,
                      cacheManager: CustomCacheManager.profilCacheManager,
                      placeHolder: const Center(
                        child: Icon(
                          Kiwoo.person,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                            shape: BoxShape.rectangle,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              horizontalSpaceSmall,
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.WELCOME.tr,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 13.fss,
                      color: textColor,
                      fontFamily: FontPoppins.LIGHT,
                    ),
                  ),
                  verticalSpaceTiny,
                  Obx(() {
                    var userDetails = controller.userDetails.value;
                    return Text(
                      "${userDetails?.name!}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 15.fss,
                        color: textColor,
                        fontFamily: FontPoppins.MEDIUM,
                      ),
                    );
                  }),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget? tablet() {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 90.ss,
      flexibleSpace: Container(decoration: appBarBoxDecoration),
      titleSpacing: 0,
      leading: DrawerButton(),
      title: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 2, 15),
        child: Row(
          children: [
            Obx(
              () {
                var avatar = controller.userDetails.value?.avatar;
                // avatar = "18tCBcK1_BjZpu_vXdhoRJXzr3KwNvy_C";
                return Container(
                  height: 55.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: avatarImage(
                    avatar,
                    cacheManager: CustomCacheManager.profilCacheManager,
                    placeHolder: const Center(
                      child: Icon(
                        Kiwoo.person,
                        size: 40,
                        color: Colors.green,
                      ),
                    ),
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.rectangle,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            horizontalSpaceSmall,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 270.s,
                  child: Text(
                    AppStrings.WELCOME,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 14.fss,
                      color: FontColors.WHITE,
                      fontFamily: FontPoppins.LIGHT,
                    ),
                  ),
                ),
                verticalSpaceTiny,
                SizedBox(
                  width: 270.s,
                  child: Obx(() {
                    var userDetails = controller.userDetails.value;
                    return Text(
                      "${userDetails?.name!}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 17.fss,
                        color: FontColors.WHITE,
                        fontFamily: FontPoppins.MEDIUM,
                      ),
                    );
                  }),
                ),
              ],
            )
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: InkWell(
            onTap: () {
              // Get.toNamed(Routes.NOTIFICATIONS);
            },
            child: Obx(() {
              var newNotifCount = 0.obs;
              // var newNotifCount = controller.notifications
              //     .fold(0, (value, element) => value + (!element.read ? 1 : 0));
              return NotificationIconCount(
                icon: Icon(Kiwoo.bell, size: 30.ss, color: Colors.white),
                count: newNotifCount.value,
              );
            }),
          ),
        )
      ],
    );
  }

  @override
  Widget phone() {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 90.ss,
      flexibleSpace: Container(decoration: appBarBoxDecoration),
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 2, 15),
        child: Row(
          children: [
            Obx(
              () {
                var avatar = controller.userDetails.value?.avatar;
                // avatar = "18tCBcK1_BjZpu_vXdhoRJXzr3KwNvy_C";
                return Container(
                  height: 55.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: avatarImage(
                    avatar,
                    cacheManager: CustomCacheManager.profilCacheManager,
                    placeHolder: const Center(
                      child: Icon(
                        Kiwoo.person,
                        size: 40,
                        color: Colors.green,
                      ),
                    ),
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.rectangle,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            horizontalSpaceSmall,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 270.s,
                  child: Text(
                    AppStrings.WELCOME,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 14.fss,
                      color: FontColors.WHITE,
                      fontFamily: FontPoppins.LIGHT,
                    ),
                  ),
                ),
                verticalSpaceTiny,
                SizedBox(
                  width: 270.s,
                  child: Obx(() {
                    var userDetails = controller.userDetails.value;
                    return Text(
                      "${userDetails?.name!}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 17.fss,
                        color: FontColors.WHITE,
                        fontFamily: FontPoppins.MEDIUM,
                      ),
                    );
                  }),
                ),
              ],
            )
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: InkWell(
            onTap: () {
              // Get.toNamed(Routes.NOTIFICATIONS);
            },
            child: Obx(() {
              var newNotifCount = 0.obs;
              // var newNotifCount = controller.notifications
              //     .fold(0, (value, element) => value + (!element.read ? 1 : 0));
              return NotificationIconCount(
                icon: Icon(Kiwoo.bell, size: 30.ss, color: Colors.white),
                count: newNotifCount.value,
              );
            }),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.square(90.ss);
}

class AppBarWidgetTitle extends GetWidget<AppServicesController>
    implements PreferredSizeWidget {
  const AppBarWidgetTitle({
    super.key,
    required this.title,
    this.actions,
    this.height,
    this.predicate,
    this.homeIfCantPop = false,
  });
  final String title;
  final List<Widget>? actions;
  final double? height;
  final bool Function(GetPage<dynamic>)? predicate;
  final bool homeIfCantPop;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      toolbarHeight: 90.ss,
      flexibleSpace: Container(decoration: appBarBoxDecoration),
      titleSpacing: 0,
      leading: Navigator.canPop(context) ||
              Get.searchDelegate(null).canBack ||
              homeIfCantPop
          ? IconButton(
              icon: const Icon(Kiwoo.arrow_left),
              onPressed: () {
                if (!Navigator.canPop(context) &&
                    !Get.searchDelegate(null).canBack &&
                    homeIfCantPop) {
                  Get.offAndToNamed(Routes.HOME);
                  return;
                } else {
                  if (predicate != null) {
                    Get.until(predicate!);
                  } else {
                    Get.back();
                  }
                }
              },
            )
          : null,
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
    );
  }

  @override
  Size get preferredSize => Size.square(height ?? 90.ss);
}

class AppBarWithWidgetTitle extends GetWidget<AppServicesController>
    implements PreferredSizeWidget {
  const AppBarWithWidgetTitle(
      {super.key,
      required this.title,
      this.actions,
      this.height,
      this.predicate,
      this.homeIfCantPop = false,
      this.toolbarHeight,
      required this.child});
  final String title;
  final List<Widget>? actions;
  final double? height;
  final bool Function(GetPage<dynamic>)? predicate;
  final bool homeIfCantPop;
  final Widget child;
  final double? toolbarHeight;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      toolbarHeight: toolbarHeight ?? 90.ss,
      flexibleSpace: Container(decoration: appBarBoxDecoration),
      leading: Navigator.canPop(context) ||
              !Get.searchDelegate(null).canBack ||
              homeIfCantPop
          ? IconButton(
              icon: const Icon(Kiwoo.arrow_left),
              onPressed: () {
                if (!Navigator.canPop(context) &&
                    !Get.searchDelegate(null).canBack &&
                    homeIfCantPop) {
                  Get.offAndToNamed(Routes.HOME);
                  return;
                } else {
                  if (predicate != null) {
                    Get.until(predicate!);
                  } else {
                    Get.back();
                  }
                }
              },
            )
          : null,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.LBL_TITLE_NAV,
              fontSize: 20,
              fontFamily: FontPoppins.SEMIBOLD,
            ),
          ),
          verticalSpaceMedium,
          child
        ],
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.square(height ?? 90.ss);
}
