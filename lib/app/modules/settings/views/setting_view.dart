import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haiti_lotri/app/controllers/firebase_services.dart';
import 'package:haiti_lotri/app/core/utils/app_utility.dart';
import 'package:haiti_lotri/app/data/models/storage_box_model.dart';
import 'package:sizing/sizing.dart';

import '../../../../generated/locales.g.dart';
import '../../../controllers/app_services_controller.dart';
import '../../../core/utils/actions/overlay.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_string.dart';
import '../../../core/utils/cache_manager.dart';
import '../../../core/utils/font_family.dart';
import '../../../core/utils/kiwoo_icons.dart';
import '../../../global_widgets/app_bar.dart';
import '../../../global_widgets/avatar_network_image.dart';
import '../../../global_widgets/label_widget.dart' show lableWidgetTitle;
import '../../../global_widgets/modal/bottom_sheet.dart';
import '../../../global_widgets/progress_indicator.dart';
import '../../../routes/app_pages.dart';
import '../controllers/setting_controller.dart';
import 'profile_edit_view.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgetTitle(
          key: ObjectKey(AppStrings.SETTINGS),
          title: AppStrings.SETTINGS,
          homeIfCantPop: true),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0.ss,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            verticalSpaceRegular,
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xFFE8FFE2),
                  borderRadius: BorderRadius.circular(15)),
              child: Obx(
                () {
                  var avatar = controller.userDetails.value?.avatar;
                  var email = controller.userDetails.value?.email ?? '';
                  var userName = controller.userDetails.value?.name;
                  var phone = controller.userDetails.value?.phone;
                  return ListTile(
                    leading: AspectRatio(
                      aspectRatio: 1,
                      child: ClipOval(
                        child: avatarImage(
                          avatar,
                          cacheManager: CustomCacheManager.profilCacheManager,
                          imageBuilder: (p0, p1) => Image(image: p1),
                          placeHolder: const Icon(
                            Kiwoo.person,
                            size: 40,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      userName ?? "Vishal Chuahan",
                      style: TextStyle(
                        color: AppColors.BLACK,
                        fontSize: 16.fss,
                        fontFamily: FontPoppins.BOLD,
                      ),
                    ),
                    subtitle: Text.rich(
                      TextSpan(
                          text: (email.isNotEmpty)
                              ? email
                              : "vishal.chauhan@yopmail.co.in",
                          children: [
                            TextSpan(
                                text: phone?.isNotEmpty == true
                                    ? '\n$phone'
                                    : '\n+(509) 3000-0000')
                          ]),
                      style: TextStyle(
                        color: AppColors.BLACK.withOpacity(.6),
                        fontSize: 11.22.fss,
                        fontFamily: FontPoppins.REGULAR,
                      ),
                    ),
                  );
                },
              ),
            ),
            verticalSpaceMedium,
            lableWidgetTitle(
              title: AppStrings.EDIT_PROFILE,
              icon: Kiwoo.user_edit,
              ontap: () {
                Get.toNamed(
                  Routes.EDIT_PROFIL,
                );
              },
            ),
            verticalSpaceRegular,
            lableWidgetTitle(
              title: AppStrings.CHANGE_PASSWORD,
              icon: Kiwoo.lock,
              ontap: () {
                Get.toNamed(Routes.CHANGE_PASSWORD);
              },
            ),
            verticalSpaceRegular,
            lableWidgetTitle(
              title: AppStrings.language.tr,
              icon: Icons.language,
              ontap: () {
                boomSheetOptions<Locale>(
                    options: [
                      BottomSheetOption(
                          label: AppStrings.languageCode('fr'),
                          value: Locale("fr")),
                      BottomSheetOption(
                          label: AppStrings.languageCode('ht'),
                          value: Locale("ht")),
                    ],
                    onItemPressedPressed: (value) async {
                      if (value != null) {
                        await showOverlay(asyncFunction: () async {
                          await controller.updateUserInfo(value.languageCode);

                          //await 1.delay();
                        });
                      }
                    });
              },
              trailing: Text(
                AppStrings.languageCode(StorageBox.locale.val),
                style: TextStyle(
                  fontSize: 16.fss,
                  fontFamily: FontPoppins.MEDIUM,
                  color: AppColors.PRIMARY,
                ),
              ),
            ),
            verticalSpaceRegular,

            // lableWidgetTitle(
            //   title: AppStrings.ABOUT_US,
            //   icon: Kiwoo.info_square_outline,
            //   ontap: () {
            //     Get.toNamed(Routes.ABOUT);
            //   },
            // ),
            // Container(height: 15.ss),
            // lableWidgetTitle(
            //   title: AppStrings.PRIVACY_POLICY,
            //   icon: Kiwoo.sheild_done_outline,
            //   ontap: () {
            //     Get.toNamed(Routes.PRIVACY_POLICY);
            //   },
            // ),
            // Container(height: 15.ss),
            // lableWidgetTitle(
            //   title: AppStrings.TERMS_OF_USE,
            //   icon: Kiwoo.lock,
            //   ontap: () {
            //     Get.toNamed(Routes.TERMS_OF_USE);
            //   },
            // ),
            // Container(height: 15.ss),
            // lableWidgetTitle(
            //   title: AppStrings.HELP_CENTER,
            //   icon: Kiwoo.help_circled_alt,
            //   ontap: () {
            //     Get.toNamed(Routes.HELP_CENTER);
            //   },
            // ),
            Container(height: 15.ss),
            ListTile(
              leading: const Icon(
                Kiwoo.user_times,
                color: Color(0xFFF75555),
              ),
              title: Text(
                AppStrings.label_disable_account,
                style: TextStyle(
                  fontSize: 16.fss,
                  fontFamily: FontPoppins.MEDIUM,
                  color: const Color(0xFFF75555),
                ),
              ),
              onTap: () {},
            ),
            Container(height: 12.ss),
            ListTile(
              onTap: () {
                showOverlay(
                  asyncFunction: controller.signOut,
                );
              },
              leading: Icon(
                Kiwoo.logout,
                color: const Color(0xFFF75555),
                size: 20.ss,
              ),
              title: Text(
                AppStrings.LOGOUT,
                style: TextStyle(
                    fontSize: 16.fss,
                    fontFamily: FontPoppins.MEDIUM,
                    color: const Color(0xFFF75555)),
              ),
            ),
            Container(height: 15.ss),
          ],
        ),
      ),
    );
  }
}
