import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';

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
import '../../../global_widgets/progress_indicator.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';
import 'profile_edit_view.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgetTitle(title: AppStrings.PROFILE, homeIfCantPop: true),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0.ss,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Container(
              height: 23.ss,
            ),
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xFFE8FFE2),
                  borderRadius: BorderRadius.circular(5)),
              child: Obx(
                () {
                  var avatar = controller.userDetails.value?.avatar;
                  var email = controller.userDetails.value?.email ?? '';
                  var userName = controller.userDetails.value?.name;
                  var userScore =
                      controller.userDetails.value?.extraInfo?.score;
                  return ListTile(
                    leading: ClipOval(
                      child: AspectRatio(
                        aspectRatio: 1,
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
                    subtitle: Text(
                      (email.isNotEmpty)
                          ? email
                          : "vishal.chauhan@yopmail.co.in",
                      style: TextStyle(
                        color: AppColors.BLACK.withOpacity(.6),
                        fontSize: 11.22.fss,
                        fontFamily: FontPoppins.REGULAR,
                      ),
                    ),
                    trailing: SizedBox(
                      height: 85,
                      width: 45,
                      child: RadialGaugeProgressBar2(
                        inContainer: false,
                        scoreTextSize: 6,
                        scoreStatusTextSize: 4,
                        progress: (userScore ?? 0) /
                            850, // Progress based on credit score
                        creditScore: userScore,
                        height: 85,
                        width: 45,
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 20.ss,
            ),
            lableWidgetTitle(
              title: "Edit Profile",
              icon: Kiwoo.user_edit,
              ontap: () {
                Get.to(
                  () => const EditProfileView(),
                  fullscreenDialog: true,
                  routeName: "/profile/edit_profil",
                );
              },
            ),
            Container(height: 15.ss),
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: lableWidgetTitle(
                title: "Change Password",
                icon: Kiwoo.lock,
                ontap: () {
                  Get.toNamed(Routes.CHANGE_PASSWORD);
                },
              ),
            ),
            Container(height: 15.ss),
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
                "Deactivate My Account",
                style: TextStyle(
                    fontSize: 16.fss,
                    fontFamily: FontPoppins.MEDIUM,
                    color: const Color(0xFFF75555)),
              ),
              onTap: () {},
            ),
            Container(height: 12.ss),
            ListTile(
              onTap: () {
                showOverlay(
                  asyncFunction:
                      Get.find<AppServicesController>().clearCurrentUser,
                );
              },
              leading: Icon(
                Kiwoo.logout,
                color: const Color(0xFFF75555),
                size: 20.ss,
              ),
              title: Text(
                "Logout",
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
