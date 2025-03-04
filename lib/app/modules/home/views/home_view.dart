import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_string.dart';
import '../../../core/utils/app_utility.dart';
import '../../../core/utils/font_family.dart';
import '../../../core/utils/image_name.dart';
import '../../../core/utils/kiwoo_icons.dart';
import '../../../global_widgets/account_balance_widget.dart';
import '../../../global_widgets/app_bar.dart';
import '../../../global_widgets/progress_indicator.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.APP_BG,
      appBar: AppBarWidget(),
      drawer: Drawer(),
      body: ListView(
        padding: EdgeInsets.only(left: 15.0, right: 15, top: 15, bottom: 75),
        children: [
          accountDetailsCardWidget(
            future: controller.appServiceController.getUserBalance,
          ),
          verticalSpaceRegular,
          serviceListWidget(),
          verticalSpaceRegular,
          contactCardWidget()
        ],
      ),
    );
  }

  Widget creditDataScoreWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Text(
              "${controller.userDetails.value?.extraInfo?.score}",
              style: TextStyle(
                fontSize: 24.fss,
                fontFamily: FontPoppins.SEMIBOLD,
              ),
            ),
            verticalSpaceTiny,
            Container(
              padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
              decoration: BoxDecoration(
                color: AppColors.PRIMARY_BG,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                controller.categorizeCreditScore(
                    controller.userDetails.value?.extraInfo?.score ?? 0),
                style: TextStyle(
                  fontSize: 11.fss,
                  fontFamily: FontPoppins.SEMIBOLD,
                  color: FontColors.PRIMARY1,
                ),
              ),
            )
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4, left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Credit Score",
                  style: TextStyle(
                    color: FontColors.GREY,
                    fontSize: 15.fss,
                  ),
                ),

                LayoutBuilder(
                  builder: (context, constraints) {
                    return Center(
                      child: CreditScoreProgressBar(
                        creditScore:
                            controller.userDetails.value?.extraInfo?.score ?? 0,
                        containerWidth: constraints.maxWidth,
                      ),
                    );
                  },
                ),
                // Center(
                //   child: CreditScoreProgressBar(creditScore: 720 ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget serviceListWidget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              AppStrings.SERVICE_AT_YOU_FINGERTIPS,
              style: TextStyle(
                color: FontColors.BLACK,
                fontSize: 17.fss,
                fontFamily: FontPoppins.MEDIUM,
              ),
            ),
          ),
          verticalSpaceSmall,
          GridView.builder(
            itemCount: controller.serviceListTmp.length,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 3,
              childAspectRatio: 2 / 2.5,
            ),
            itemBuilder: (context, index) {
              var currentData = controller.serviceListTmp[index];
              return GestureDetector(
                onTap: () {
                  if (currentData["onTap"] != null) {
                    currentData["onTap"]();
                  }
                },
                child: Card(
                  elevation: 4,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AppColors.CARD_PRIMARY,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 5.ss,
                        ),
                        (currentData["MaterialIcon"] == "")
                            ? Icon(
                                currentData["icon"],
                                size: 40.ss,
                              )
                            : Icon(
                                currentData["MaterialIcon"],
                                color: Colors.black,
                                size: 30.ss,
                              ),
                        Text(
                          currentData["label"],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: FontColors.BLACK,
                              fontSize: 14.fss,
                              fontFamily: FontPoppins.SEMIBOLD),
                        ),
                        SizedBox(
                          height: 5.ss,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget contactCardWidget() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImgName.CARD_SMALL_IMG),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.PRIMARY3,
            foregroundColor: AppColors.BLACK,
            radius: 30,
            child: Icon(Kiwoo.head_phone, size: 40.fss),
          ),
          Flexible(
            child: Text.rich(
              TextSpan(children: [
                TextSpan(
                  text: "${AppStrings.FOR_ANY_ASSISTANCE_PLEASE} ",
                ),
                WidgetSpan(
                  child: InkWell(
                    onTap: () {
                      var uri = Uri.parse("tel:+50944168552");
                      canLaunchUrl(uri).then((resp) {
                        if (resp) {
                          launchUrl(uri);
                        }
                      });
                    },
                    child: Text(
                      "+509 4416-8552",
                      style: TextStyle(
                        fontSize: 17.fss,
                        fontFamily: FontPoppins.MEDIUM,
                        color: const Color.fromARGB(255, 49, 173, 0),
                      ),
                    ),
                  ),
                )
              ]),
              style: TextStyle(
                fontSize: 17.fss,
                fontFamily: FontPoppins.SEMIBOLD,
                color: FontColors.BLACK,
                // overflow: TextOverflow.clip,
              ),
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
