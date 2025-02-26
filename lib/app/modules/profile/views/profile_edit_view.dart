// ignore_for_file: deprecated_member_use, avoid_print, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../core/utils/actions/overlay.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_string.dart';
import '../../../core/utils/app_utility.dart' show TypeMessage, showMsg;
import '../../../core/utils/cache_manager.dart';
import '../../../core/utils/device_manager/screen_constants.dart';
import '../../../core/utils/font_family.dart';
import '../../../core/utils/kiwoo_icons.dart';
import '../../../core/utils/pick_files.dart/pick_image.dart';
import '../../../global_widgets/app_bar.dart';
import '../../../global_widgets/avatar_network_image.dart';
import '../../../global_widgets/modal/bottom_sheet.dart';
import '../controllers/profile_controller.dart';

class EditProfileView extends GetView<ProfileController> {
  const EditProfileView({super.key});
  String get fullName => controller.userDetails.value!.name!;
  String get email => controller.userDetails.value!.email!;
  String get phoneNumber => controller.userDetails.value!.phone!;

  @override
  Widget build(BuildContext context) {
    // controller.getValuefromLocal();

    return Scaffold(
      appBar: AppBarWidgetTitle(
        title: AppStrings.EDIT_PROFILE,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.ss),
        child: ListView(
          children: [
            Container(
              height: 24.ss,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 5, color: AppColors.PRIMARY2),
                      borderRadius: BorderRadius.circular(80.ss)),
                  child: CircleAvatar(
                    radius: 70.ss,
                    backgroundColor: AppColors.WHITE,
                    child: ClipOval(
                      child: Obx(() {
                        var avatar = controller.userDetails.value?.avatar;
                        return avatarImage(
                          avatar,
                          cacheManager: CustomCacheManager.profilCacheManager,
                          imageBuilder: (context, imageProvider) {
                            return Image(
                                image: imageProvider, fit: BoxFit.cover);
                          },
                          placeHolder: Icon(
                            Kiwoo.person,
                            size: 120.ss,
                            color: AppColors.PRIMARY2,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 100.ss,
                  child: IconButton.filled(
                    onPressed: () async {
                      var imagesource =
                          await boomSheetOptions<ImageSources>(options: [
                        BottomSheetOption(
                            label: 'Upload from Gallery/File',
                            icon: Kiwoo.image,
                            onPressed: () {
                              return ImageSources.gallery;
                            }),
                        BottomSheetOption(
                            label: 'Take a Photo',
                            icon: Kiwoo.image,
                            onPressed: () {
                              return ImageSources.camera;
                            })
                      ]);
                      if (imagesource != null) {
                        var data = await PickFile.imageFile(
                          imageQuality: 20,
                          maxFileSizeInMb: 2,
                          source: imagesource,
                          crop: true,
                          cropperToolbarTitle: "Crop Profil Picture",
                        ).onError((error, s) {
                          showMsg(error as String, type: TypeMessage.error);
                          return null;
                        });

                        if (data == null) return;
                        showOverlay(
                          asyncFunction: () => controller.uploadFile(data),
                        );
                      }
                    },
                    icon: const Icon(Icons.edit),
                  ),
                )
              ],
            ),
            Container(
              height: 48.ss,
            ),
            Text(
              'Full Name',
              style: TextStyle(
                color: const Color(0xFF111A24),
                fontSize: 14.fss,
                fontFamily: FontPoppins.SEMIBOLD,
              ),
            ),
            Container(
              height: 8.ss,
            ),
            TextFormField(
              initialValue: fullName,
              keyboardType: TextInputType.text,
              autofocus: false,
              enabled: false,
              // inputFormatters: [
              //   FilteringTextInputFormatter.deny(
              //       RegExp(r'[!@#$%^&*().?":{}|<>0-9]'))
              // ],
              // validator: controller.validateName,
              maxLines: 1,
              cursorColor: AppColors.PRIMARY,
              textInputAction: TextInputAction.next,

              style: TextStyle(
                color: const Color(0xFF111A24),
                fontSize: 14.fss,
                //   fontFamily: FontPoppins.REGULAR
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.WHITE,
                errorMaxLines: 2,
                hintText: "Full Name",
                hintStyle: TextStyle(
                    color: const Color(0xFF6C7E8E),
                    fontSize: 14.fss,
                    fontFamily: FontPoppins.REGULAR),
                errorStyle: TextStyle(
                    color: const Color(0xFFE8503A),
                    fontSize: 12.fss,
                    fontFamily: FontPoppins.REGULAR),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(Kiwoo.person),
                ),
                contentPadding: EdgeInsets.all(ScreenConstant.sizeMedium),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: AppColors.PRIMARY,
                      width: 1,
                      style: BorderStyle.solid),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: Color(0xFFEAF0F5),
                      width: 1,
                      style: BorderStyle.solid),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: Color(0xFFEAF0F5),
                      width: 1,
                      style: BorderStyle.solid),
                ),
                errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: Color(0xFFE8503A),
                      width: 1,
                      style: BorderStyle.solid),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: Color(0xFFE8503A),
                      width: 1,
                      style: BorderStyle.solid),
                ),
              ),
            ),
            Container(
              height: 16.ss,
            ),
            Text(
              'Email',
              style: TextStyle(
                color: const Color(0xFF111A24),
                fontSize: 14.fss,
                fontFamily: FontPoppins.SEMIBOLD,
              ),
            ),
            Container(
              height: 8.ss,
            ),
            TextFormField(
              initialValue: email,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              enabled: false,
              maxLines: 1,
              cursorColor: AppColors.PRIMARY,
              textInputAction: TextInputAction.next,
              style: TextStyle(
                  color: const Color(0xFF111A24),
                  fontSize: 14.fss,
                  fontFamily: FontPoppins.REGULAR),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.withOpacity(.2),
                hintText: "exemple@email.com",
                hintStyle: TextStyle(
                    color: const Color(0xFF6C7E8E),
                    fontSize: 14.fss,
                    fontFamily: FontPoppins.REGULAR),
                errorStyle: TextStyle(
                    color: const Color(0xFFE8503A),
                    fontSize: 12.fss,
                    fontFamily: FontPoppins.REGULAR),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(13.0),
                  child: Icon(Kiwoo.mail),
                ),
                contentPadding: EdgeInsets.all(ScreenConstant.sizeMedium),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: AppColors.PRIMARY,
                      width: 1,
                      style: BorderStyle.solid),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: Colors.grey, width: 1, style: BorderStyle.solid),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: Color(0xFFEAF0F5),
                      width: 1,
                      style: BorderStyle.solid),
                ),
                errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: Color(0xFFE8503A),
                      width: 1,
                      style: BorderStyle.solid),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: Color(0xFFE8503A),
                      width: 1,
                      style: BorderStyle.solid),
                ),
              ),
            ),
            Container(
              height: 16.ss,
            ),
            Text(
              'Contact Number',
              style: TextStyle(
                color: const Color(0xFF111A24),
                fontSize: 14.fss,
                fontFamily: FontPoppins.SEMIBOLD,
              ),
            ),
            Container(
              height: 8.ss,
            ),
            TextFormField(
              initialValue: phoneNumber,
              keyboardType: TextInputType.text,
              autofocus: false,
              enabled: false,
              maxLines: 1,
              cursorColor: AppColors.PRIMARY,
              textInputAction: TextInputAction.next,
              style: TextStyle(
                color: const Color(0xFF111A24),
                fontSize: 14.fss,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.WHITE,
                errorMaxLines: 2,
                hintText: "Contact Number",
                hintStyle: TextStyle(
                    color: const Color(0xFF6C7E8E),
                    fontSize: 14.fss,
                    fontFamily: FontPoppins.REGULAR),
                errorStyle: TextStyle(
                    color: const Color(0xFFE8503A),
                    fontSize: 12.fss,
                    fontFamily: FontPoppins.REGULAR),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.call,
                    color: AppColors.APPBAR_PRIMARY1,
                  ),
                ),
                contentPadding: EdgeInsets.all(ScreenConstant.sizeMedium),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: AppColors.PRIMARY,
                      width: 1,
                      style: BorderStyle.solid),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: Color(0xFFEAF0F5),
                      width: 1,
                      style: BorderStyle.solid),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: Color(0xFFEAF0F5),
                      width: 1,
                      style: BorderStyle.solid),
                ),
                errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: Color(0xFFE8503A),
                      width: 1,
                      style: BorderStyle.solid),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: Color(0xFFE8503A),
                      width: 1,
                      style: BorderStyle.solid),
                ),
              ),
            ),
            Container(
              height: 16.ss,
            ),
          ],
        ),
      ),
    );
  }
}
