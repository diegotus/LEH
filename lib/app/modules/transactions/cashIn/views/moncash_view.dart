import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../../core/utils/actions/overlay.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/app_utility.dart';
import '../../../../core/utils/formatters/validation.dart';
import '../../../../core/utils/kiwoo_icons.dart';
import '../../../../global_widgets/input_field.dart';
import '../../../../global_widgets/list_builder_widget.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/cash_in_controller.dart';

class MoncashView extends GetWidget<CashInController> {
  const MoncashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Padding(
        padding: EdgeInsets.all(20.ss),
        child: FutureBuilderWithSearch(
          initialData: const {'fee': 0, 'amount': 0},
          pullRefresh: false,
          searchInput: (onChanged) {
            return inputWithLabel(
              label: AppStrings.AMOUNT,
              hintText: AppStrings.ENTER_AMOUNT,
              inputFormatters: [decimalNumberFormatter],
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              validator: (p0) {
                return isEmptyValidator(p0, AppStrings.PLS_ENTER_AMOUNT) ??
                    isBetweenValidator(
                      double.parse(p0!),
                      label: AppStrings.AMOUNT,
                      min: 100,
                    );
              },
              onSaved: (p0) {
                controller.amount = double.parse(p0!);
              },
              onChanged: (value) => onChanged(value ?? ''),
            );
          },
          future: futureSearch,
          futureBuilder: (context, data, isLoading, refreshFuture) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                verticalSpaceRegular,
                inputWithLabel(
                  label: "Fees",
                  hintText: "fees",
                  initialValue: "${data['fee'] ?? 0}",
                  initValueWithController: true,
                  inputFormatters: [decimalNumberFormatter],
                  suffixIconConstraints: const BoxConstraints(maxHeight: 48),
                  sufixIcon: isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(13),
                          child: FittedBox(child: CircularProgressIndicator()))
                      : null,
                  enabled: false,
                ),
                verticalSpaceRegular,
                inputWithLabel(
                  label: "Total",
                  hintText: "Total",
                  initValueWithController: true,
                  initialValue: "${(data['fee'] ?? 0) + (data['amount'] ?? 0)}",
                  inputFormatters: [decimalNumberFormatter],
                  suffixIconConstraints: const BoxConstraints(maxHeight: 48),
                  sufixIcon: isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(13),
                          child: FittedBox(child: CircularProgressIndicator()))
                      : null,
                  enabled: false,
                ),
                verticalSpaceRegular,
                IconButton(
                  focusColor: const Color(0xFF2196F3),
                  color: Colors.red,
                  splashRadius: 0.0001,
                  padding: EdgeInsets.zero,
                  splashColor: Colors.blue,
                  style: IconButton.styleFrom(
                    fixedSize: Size.fromWidth(100.ss * 2),
                    foregroundColor: Colors.red,
                    hoverColor: Colors.blue,
                  ),
                  onPressed: data.isEmpty || isLoading
                      ? null
                      : () async {
                          if (controller.formKey.currentState?.validate() ==
                              true) {
                            controller.formKey.currentState!.save();
                            // Get.toNamed("${Routes.TRANSACTION_RECEIPT}/moncash",
                            //     parameters: {"transactionId": "1102687"});
                            showOverlay(asyncFunction: controller.cashIn);
                          }
                        },
                  iconSize: 100.ss,
                  icon: SizedBox(
                    width: 100.ss * 2,
                    child: const Icon(
                      Kiwoo.mc_button_en2,
                    ),
                  ),
                ),
              ],
            );
          },
          isEmpty: (data) {
            return false;
          },
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> futureSearch([String? search]) async {
    return Get.find<CashInController>()
        .getFee(amount: double.tryParse(search ?? '0') ?? 0);
  }
}
