// import 'package:flutter/cupertino.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';

class DateTimeUtility {
  static String parse({String? dateTime, String? returnFormat}) {
    DateTime dt = DateTime.parse(dateTime!).toLocal();
    DateFormat dateFormat = DateFormat(returnFormat);
    String returnDT = dateFormat.format(dt);
    return returnDT;
  }

  String parseTime({String? dateTime, String? returnFormat}) {
    DateFormat dtFor = DateFormat("HH:mm:ss");
    DateTime dt = dtFor.parse(dateTime!);
    DateFormat dateFormat = DateFormat(returnFormat);
    String returnDT = dateFormat.format(dt);
    return returnDT;
  }

  static DateTime convertDateFromString(String strDate) {
    DateTime todayDate = DateTime.parse(strDate);
    return todayDate.toLocal();
  }

  String getTimeFromTimeStamp(timeInMillis) {
    //int timeInMillis = 1586348737122;
    var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    String formattedDate =
        parse(dateTime: date.toString(), returnFormat: "hh:mm a");
    return formattedDate;
  }

  String getDateFromTimeStamp(timeInMillis) {
    //int timeInMillis = 1586348737122;
    var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    String formattedDate = DateFormat.yMMMd().format(date);
    return formattedDate;
  }

  DateTime openCloseFormat({String? dateTime}) {
    DateFormat dtFor = DateFormat("hh:mm");
    DateTime dt = dtFor.parse(dateTime!);
    return dt;
  }

  String parseToLocal(
      {String? dateTime, String? returnFormat, String? parseFormat}) {
    final dateNow = DateTime.now();
    if (dateTime == null) {
      return "";
    } else if (parseFormat != null) {
      DateTime formattedTime = DateFormat(
        parseFormat,
      ).parse(dateTime);
      formattedTime = formattedTime.add(dateNow.timeZoneOffset);
      Get.log("formattedTime:$formattedTime");
      DateFormat dateFormat = DateFormat(returnFormat);
      String returnDT = dateFormat.format(formattedTime);
      return returnDT;
    } else {
      DateTime dt = DateTime.parse(dateTime);
      dt = dt.add(dateNow.timeZoneOffset);
      DateFormat dateFormat = DateFormat(returnFormat);
      String returnDT = dateFormat.format(dt);
      return returnDT;
    }
  }

  String intToTimeLeft(int value) {
    int h, m, s;

    h = value ~/ 3600;

    m = ((value - h * 3600)) ~/ 60;

    s = value - (h * 3600) - (m * 60);
    if (value > 60 && value < 3600) {
      String result = "$m${"m "}$s${"s"}";

      return result;
    } else if (value >= 3600) {
      String result = m == 0 && s == 0
          ? "$h${"hr"}"
          : m == 0
              ? "$h${"hr "}$m${"m "}"
              : s == 0
                  ? "$h${"hr "}$s${"s"}"
                  : "$h${"hr "}$m${"m "}$s${"s"}";
      return result;
    } else {
      return "$value${"s"}";
    }
  }
}
