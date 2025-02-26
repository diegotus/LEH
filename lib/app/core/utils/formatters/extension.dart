import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haiti_lotri/app/data/models/ticket_model.dart';
import 'package:intl/intl.dart';

import '../enums.dart';
import 'format_number.dart';

extension NumberFormat on num {
  String get toHLG => toHLGCurrency().format(this);
  String get toHLGCompact {
    return "${toHLGCurrency().currencySymbol} $formatNumberCompact";
  }

  String get toUS => toUsCurrency.format(this / 138);
  String get formatNumber => numberFormater.format(this);
  String get formatNumberCompact {
    var formater = numberFormater;
    if (this > 100000) {
      formater = numberFormaterCompact;
    }

    return formater.format(this);
  }
}

extension NumberStringFormat on String? {
  double get _toDouble => (double.tryParse(this ?? '0') ?? 0);
  String get toHLG => _toDouble.toHLG;
  String get toHLGCompact => _toDouble.toHLGCompact;
  String get toUS => _toDouble.toUS;
  String get formatNumber => _toDouble.formatNumber;
}

extension StringExtention on String? {
  String? get snakeCase => GetUtils.snakeCase(this, separator: '_');
}

extension DateTimeExtention on DateTime {
  String format(String format, {String? locale}) {
    return DateFormat(format, locale).format(this);
  }

  String since() {
    // Convert the provided UTC DateTime to local time
    final localDateTime = isUtc ? toLocal() : this;
    final now = DateTime.now();
    final timeFormat = DateFormat('kk:mm');
    var diffDays = now.difference(localDateTime).inDays;
    if (diffDays == 0) {
      return timeFormat.format(localDateTime);
    } else if (diffDays == 1) {
      // If the date is yesterday, show "Yesterday" and the time
      return 'Yesterday';
    } else if (diffDays < 7) {
      // IF date is in te last 6 days show the day name
      return DateFormat.EEEE().format(localDateTime);
    } else {
      // Otherwise, show the full date
      return DateFormat('dd/MM/yy').format(localDateTime);
    }
  }

  Duration toDuration() {
    // Convert the provided UTC DateTime to local time
    final localDateTime = isUtc ? toLocal() : this;
    final now = DateTime.now();
    var seconds = localDateTime.difference(now).inSeconds;
    return Duration(seconds: seconds);
  }

  String afterSince([String format = 'dd/MM/yy']) {
    // Convert the provided UTC DateTime to local time
    final localDateTime = isUtc ? toLocal() : this;
    final now = DateTime.now();
    final timeFormat = DateFormat('kk:mm');
    var diffDays = localDateTime.difference(now).inDays;
    if (diffDays == 0) {
      return timeFormat.format(localDateTime);
    } else if (diffDays == 1) {
      // If the date is yesterday, show "Yesterday" and the time
      return 'Tomorrow';
    } else if (diffDays < 7) {
      // IF date is in te last 6 days show the day name
      return DateFormat.EEEE().format(localDateTime);
    } else {
      // Otherwise, show the full date
      return DateFormat(format).format(localDateTime);
    }
  }

  DateTime calculateLoanCompletionDate(int tenure) {
    DateTime loanCompletionDate = DateTime(
      year,
      month + tenure,
      day,
    );
    return loanCompletionDate;
  }
}

extension TicketExtention on TicketModel {
  String? getWinningMultiple(String boul) {
    String? returnString;
    switch (type) {
      case Gametype.bolet:
        const price = ["x50", "x20", "x10"];
        var index = winningNumbers?.indexWhere((value) => value.endsWith(boul));
        if (index != null && index - 1 > -1) return price[index];

      case Gametype.mariaj:
        var exp = RegExp(r'\d{2}');
        if (exp
            .allMatches(boul)
            .every((el) => winningNumbers?.contains(el.group(0)) ?? false)) {
          return "x2000";
        }

      case Gametype.lotto3:
        if (winningNumbers?[0] == boul) {
          return "500X";
        }
      case Gametype.lotto4:
        if (winningNumbers?.skip(1).join() == boul) {
          return "5,000X";
        }

      case Gametype.lotto5:
        returnString = "25,000X";
        continue returnString;
      case Gametype.lotto5p5:
        returnString = "200,464G";
        continue returnString;
      returnString:
      case Gametype.royal5:
        returnString ??= "1,021,649G";
        if (winningNumbers?.sublist(0, 2).join() == boul) {
          return returnString;
        }
    }
    return null;
  }
}
