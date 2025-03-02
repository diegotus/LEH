import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../app_string.dart';

String? isValidEmail(String? string) {
  if ((string ?? '').isEmpty) {
    return AppStrings.PLS_ENTER_EMAILID;
  }
  if (!string!.isEmail == true) {
    return AppStrings.PLS_ENTER_VALID_EMAILID;
  }
  return null;
}

MaskTextInputFormatter phoneFormateur() => MaskTextInputFormatter(
      mask: r'+#',
      filter: {"#": RegExp(r'[0-9]*')},
      type: MaskAutoCompletionType.lazy,
    );

MaskTextInputFormatter haitiPhoneFormateur() => MaskTextInputFormatter(
      mask: r'509 $# ## ## ##',
      filter: {"#": RegExp(r'[0-9]'), r"$": RegExp(r'3|4')},
      type: MaskAutoCompletionType.lazy,
    );

// validMobile(String value) {
//   String patttern = r'(^509 (3|4)[0-9](\s[0-9]{2}){3}$)';
//   RegExp regExp = RegExp(patttern);
//   if (value.isEmpty) {
//     return false;
//   } else if (!regExp.hasMatch(value)) {
//     return false;
//   }
//   return true;
// }

// specialCharacterNotAllow(String value) {
//   String patttern = r"^[a-zA-Z0-9]+$";
//   RegExp regExp = RegExp(patttern);
//   if (value.isEmpty) {
//     return false;
//   } else if (!regExp.hasMatch(value)) {
//     return false;
//   }
//   return true;
// }

checkYear(String value) {
  DateFormat formate = DateFormat('yyyy');
  RegExp regExp = RegExp(formate.toString());
  if (value.isEmpty) {
    return false;
  } else if (!regExp.hasMatch(value)) {
    return false;
  }
  return true;
}

String? validPassword(String? value) {
  String patttern = r'(^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$!%*?&;]).{8,}$)';
  RegExp regExp = RegExp(patttern);
  var error = isEmptyValidator(value, AppStrings.PLS_ENTER_PASSWORD);
  if (error != null) {
    return error;
  } else if (value!.length < 8 || value.length > 20) {
    error = AppStrings.PLS_ENTER_PASSWORD_MUST_BE_LONG;
  } else if (!regExp.hasMatch(value)) {
    error = AppStrings.PASSWORD_INVALID;
  }
  return error;
}

final decimalNumberFormatter =
    FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,10})?'));
final numberFormatter = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));

String? isEmptyValidator(String? value, [String? onEmpty]) {
  if ((value ?? '').isEmpty) {
    return onEmpty ?? AppStrings.onEmpty;
  }
  return null;
}

String? isBetweenValidator(
  num value, {
  num? min,
  num? max,
  String? label,
}) {
  final start = label ?? 'value';
  if (min != null && value < min) {
    return "$start should not me less then $min";
  } else if (max != null && value > max) {
    return "$start should not me more then $max";
  }
  return null;
}
