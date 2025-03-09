import 'package:flutter/widgets.dart';
import 'package:haiti_lotri/app/core/utils/app_string.dart';
import 'package:sizing/sizing_extension.dart';

import 'package:haiti_lotri/app/core/utils/formatters/extension.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/app_utility.dart';
import '../core/utils/font_family.dart';
import '../core/utils/formatters/format_number.dart';
import '../core/utils/image_name.dart';
import '../data/models/account_balance.dart';

Widget accountDetailsCardWidget(
    {required Future<List<AccountBalanceModel>?> Function() future}) {
  return Container(
    height: 205.ss,
    width: 1.sw,
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      image: const DecorationImage(
        image: AssetImage(ImgName.CARD_IMG),
        fit: BoxFit.fill,
      ),
    ),
    child: FutureBuilder(
        future: future(),
        builder: (context, snapshot) {
          String? balance;
          if (snapshot.hasData) {
            balance = snapshot.data?.firstOrNull?.balance;
          }
          return Stack(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 30.ss, vertical: 20.ss),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.ACCOUNT_BALANCE,
                      style: TextStyle(
                          fontSize: 17.fss,
                          color: const Color.fromARGB(255, 122, 122, 122)),
                    ),
                    SizedBox(height: 5.ss),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          balance?.formatNumber ?? "--",
                          style: TextStyle(
                            fontSize: 25.fss,
                            fontFamily: FontPoppins.BOLD,
                            color: FontColors.BLACK,
                          ),
                        ),
                        Text(
                          toHLGCurrency().currencySymbol,
                          style: TextStyle(
                            fontSize: 16.fss,
                            fontFamily: FontPoppins.MEDIUM,
                            color: FontColors.BLACK,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14.vs),
                    Center(
                      child: Container(
                        height: 1,
                        width: .4.sw,
                        color: AppColors.PRIMARY1,
                      ),
                    ),
                    SizedBox(height: 15.ss),
                    Text(
                      AppStrings.IN_US_DOLLARS,
                      style: TextStyle(
                          fontSize: 17.fss,
                          color: const Color.fromARGB(255, 122, 122, 122)),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          balance?.toUS ?? "--",
                          style: TextStyle(
                            fontSize: 25.fss,
                            fontFamily: FontPoppins.BOLD,
                            color: FontColors.BLACK,
                          ),
                        ),
                        // Text(
                        //   "XML",
                        //   style: TextStyle(
                        //       fontSize: 16.fss,
                        //       fontFamily: FontFamily.POPPINS_MEDIUM,
                        //       color: FontColors.BLACK),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              if (snapshot.connectionState == ConnectionState.waiting) ...[
                Opacity(
                  opacity: 0.6,
                  child:
                      ModalBarrier(dismissible: false, color: AppColors.BLACK),
                ),
                Center(
                  child: loadingAnimation(),
                ),
              ]
            ],
          );
        }),
  );
}
