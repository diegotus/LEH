// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

enum OTPType {
  register,
  forgotPassword,
}

enum SortDirection { asc, desc }

enum Direction {
  inbound,
  outbound;

  static Direction fromMap(int? index) {
    return Direction.values.elementAtOrNull(index ?? -1) ?? outbound;
  }

  int toMap() => index;
}

enum NotificationType {
  chat,
  loanRequest,
  newLoanOffer,
  loanOfferAccepted,
  loanOfferRejected,
  loanAcceted,
  cashIn,
  unKnow;

  static NotificationType fromMap(String? name) {
    return NotificationType.values.firstWhere(
      (el) => el.name == name,
      orElse: () => unKnow,
    );
  }
}

enum TransactionType {
  transfer,
  lotoPlay,
  lotoWin,
  cash,
  payment;

  static TransactionType fromMap(String? name) {
    return TransactionType.values.firstWhere(
      (el) => el.name == name,
      orElse: () => transfer,
    );
  }

  String toMap() => name;
  String get translate => "transactionType_$name".tr;
}

enum TransactionMethod {
  moncash,
  natcash,
  bank,
  card,
  p2p;

  static TransactionMethod fromMap(String? name) {
    return TransactionMethod.values.firstWhere(
      (el) => el.name == name,
      orElse: () => p2p,
    );
  }

  String toMap() => name;
}

enum TransactionStatus {
  pending,
  failed,
  success;

  static TransactionStatus fromMap(String? name) {
    return TransactionStatus.values.firstWhere((el) => el.name == name);
  }

  String toMap() => name;
}

enum VerificationStatus {
  none,
  pending,
  verified,
  verifiedby1,
  rejected;

  static VerificationStatus? fromString(String name) {
    return VerificationStatus.values
            .firstWhereOrNull((el) => el.name == name) ??
        none;
  }

  bool get isVerified {
    return this == verified || this == verifiedby1 ? true : false;
  }

  bool get isPending => this == pending;
  String get textStatus {
    switch (this) {
      case VerificationStatus.none:
        return "Verification Required";
      case VerificationStatus.pending:
        return "Verification Pending";
      case VerificationStatus.verified:
        return "Verified";
      case VerificationStatus.verifiedby1:
        return "Verified by Someone";
      case VerificationStatus.rejected:
        return "Rejected";
    }
  }
}

enum Gametype {
  bolet,
  mariaj,
  lotto3,
  lotto4,
  lotto5,
  lotto5p5,
  royal5;

  static Gametype fromString(String name) {
    return Gametype.values.firstWhereOrNull((el) => el.name == name) ?? bolet;
  }
}

enum TirageName {
  NY,
  FL,
  GA;

  static TirageName fromString(String name) {
    return TirageName.values.firstWhereOrNull((el) => el.name == name) ?? NY;
  }
}

enum DayTime {
  midi,
  soir,
  fullDay;

  static DayTime fromString(String name) {
    return DayTime.values.firstWhereOrNull((el) => el.name == name) ?? midi;
  }
}

enum GameStatus {
  pending,
  win,
  lost;

  static GameStatus fromString(String name) {
    return GameStatus.values.firstWhereOrNull((el) => el.name == name) ??
        pending;
  }
}
