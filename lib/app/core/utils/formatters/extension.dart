import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/app_string.dart';
import 'package:haiti_lotri/app/data/models/ticket_model.dart';
import 'package:intl/intl.dart';

import '../../../data/models/game_model.dart';
import '../enums.dart';
import 'format_number.dart';

extension NumberFormat on num {
  String get toHLG => toHLGCurrency().format(this);
  String get toHLGCompact {
    return "${toHLGCurrency().currencySymbol} $formatNumberCompact";
  }

  String get toUS => toUsCurrency.format(this / 138);
  String get formatNumber => numberFormater.format(this);
  String get formatDecimal => decimalFormater.format(this);
  String get formatNumberCompact {
    var formater = decimalFormater;
    if (this > 100000) {
      formater = numberFormaterCompact;
    }

    return formater.format(this);
  }
}

extension NumberStringFormat on String? {
  double get _toDouble => (double.tryParse("$this") ?? 0);
  int get _toInt => (int.tryParse('$this') ?? 0);
  String get toHLG => _toDouble.toHLG;
  String get toHLGCompact => _toDouble.toHLGCompact;
  String get toUS => _toDouble.toUS;
  String get formatDouble => _toDouble.formatDecimal;
  String get formatNumber => _toInt.formatNumber;
}

extension StringExtention on String? {
  String? get snakeCase => GetUtils.snakeCase(this, separator: '_');
}

extension DateTimeExtention on DateTime {
  String format(String format, {String? locale}) {
    return DateFormat(format, locale ?? Get.locale?.countryCode).format(this);
  }

  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  DateTime get endOfDay {
    return DateTime(year, month, day, 23, 59, 59, 999, 999);
  }

  String dateToGTMFormat() {
    // Get the current date and time
    String formattedDate =
        DateFormat("yyyy-MM-dd HH:mm:ss").format(this); // Format the date
    String timeZoneOffset = this.timeZoneOffset.isNegative ? "-" : "+";

    // Append GMT with offset (hours and minutes)
    String localGmt = "$formattedDate GMT"
        "$timeZoneOffset${this.timeZoneOffset.inHours.abs().toString().padLeft(2, '0')}:"
        "${(this.timeZoneOffset.inMinutes.abs() % 60).toString().padLeft(2, '0')}";

    return localGmt;
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
      return AppStrings.YESTERDAY;
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

//TODO dont forget to create a list boul view widget on details
extension TicketExtention on TicketModel {
  String? getWinningMultiple(String boul, GameStatus status) {
    String? returnString;
    if (status == GameStatus.win) {
      switch (type) {
        case Gametype.bolet:
          const price = ["X50", "X20", "X10"];
          var index =
              winningNumbers?.indexWhere((value) => value.endsWith(boul));
          if (index != null && index > -1) return price[index];
          break;
        case Gametype.mariaj:
          return "x2000";
        case Gametype.lotto3:
          return "500X";
        case Gametype.lotto4:
          return "5,000X";
        case Gametype.lotto5:
          returnString = "25,000X";
          continue returnString;
        case Gametype.lotto5p5:
          returnString = "200,464G";
          continue returnString;
        returnString:
        case Gametype.royal5:
          returnString ??= "1,021,649G";
          return returnString;
      }
    } else {
      switch (type) {
        case Gametype.bolet:
        case Gametype.mariaj:
        case Gametype.lotto3:
        case Gametype.lotto4:
        case Gametype.lotto5:
          return status == GameStatus.lost ? "X0" : "...";
        case Gametype.lotto5p5:
        case Gametype.royal5:
          return status == GameStatus.lost ? '0G' : "...";
      }
    }
    return null;
  }

  bool _areElementsInDifferentPositions(List<String> arr1, List<String> arr2) {
    // Create a copy of arr2 to keep track of used elements
    List<String> arr2Copy = List.from(arr2);

    return arr1.every((element) {
      int index = arr2Copy.indexOf(element);
      if (index != -1) {
        arr2Copy.removeAt(index);
        return true;
      }
      return false;
    });
  }
}

extension BoulJweModelExtention on BoulJweModel {
  List<String> getboul(Gametype type) {
    return _getboul(boul, type);
  }
}

extension GameTirageExtention on GameTirageModel {
  List<String> get getboul {
    return _getboul(boul, type);
  }
}

List<String> _getboul(String boul, Gametype type) {
  print("the bpudl $boul $type");
  RegExp? exp;
  switch (type) {
    case Gametype.bolet:
    case Gametype.lotto3:
      return [boul];
    case Gametype.mariaj:
    case Gametype.lotto4:
      exp = RegExp(r"\d{2}");
      continue regExp;
    regExp:
    case Gametype.lotto5:
    case Gametype.lotto5p5:
    case Gametype.royal5:
      exp ??= RegExp(r"\d{2,3}");
      Iterable<Match> matches = exp.allMatches(boul);
      var boules = [...matches.map((m) => m.group(0)!)];

      return boules;
  }
}
