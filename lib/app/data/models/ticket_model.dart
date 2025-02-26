// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../core/utils/datetime_utility.dart';
import '../../core/utils/enums.dart';
import 'game_model.dart';

List<TicketModel> listTicketModel(List str) {
  return str.map((el) => TicketModel.fromMap(el)).toList();
}

List<BoulJweModel> listBoulJweModel(List str) {
  return str.map((el) => BoulJweModel.fromMap(el)).toList();
}

class TicketModel {
  int id;
  int userId;
  final DayTime dayTime;
  final Gametype type;
  final TirageName tirageName;
  final int? tirageId;
  final int? transactionId;
  final DateTime createdAt;
  final DateTime updatedAt;
  List<BoulJweModel> boulJwe;
  final List<String>? winningNumbers;

  TicketModel(
      {required this.id,
      required this.userId,
      required this.dayTime,
      required this.type,
      required this.tirageName,
      this.tirageId,
      this.transactionId,
      required this.createdAt,
      required this.updatedAt,
      required this.boulJwe,
      this.winningNumbers});
  int get totalWon =>
      boulJwe.where((element) => element.status == GameStatus.win).length;

  double get getAmountTotal =>
      boulJwe.fold(0, (result, el) => el.amount + result);
  TicketModel copyWith(
      {int? id,
      int? userId,
      DayTime? dayTime,
      Gametype? type,
      TirageName? tirageName,
      int? tirageId,
      int? transactionId,
      DateTime? createdAt,
      DateTime? updatedAt,
      List<BoulJweModel>? boulJwe,
      List<String>? winningNumbers}) {
    return TicketModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      dayTime: dayTime ?? this.dayTime,
      type: type ?? this.type,
      tirageName: tirageName ?? this.tirageName,
      tirageId: tirageId ?? this.tirageId,
      winningNumbers: winningNumbers ?? this.winningNumbers,
      transactionId: transactionId ?? this.transactionId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      boulJwe: boulJwe ?? this.boulJwe,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'dayTime': dayTime.name,
      'type': type.name,
      'tirageName': tirageName.name,
      'tirageId': tirageId,
      "winningNumbers": winningNumbers,
      'transactionId': transactionId,
      'boulJwe': boulJwe.map((x) => x.toMap()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory TicketModel.fromMap(Map<String, dynamic> map) {
    return TicketModel(
      id: map['id'] as int,
      userId: map['userId'] as int,
      dayTime: DayTime.fromString(map['dayTime']),
      type: Gametype.fromString(map['type']),
      tirageName: TirageName.fromString(map['tirageName']),
      tirageId: map['tirageId'],
      winningNumbers: map["Tirage"] != null
          ? Map<String, String>.from(map["Tirage"]).values.toList()
          : null,
      transactionId: map['transactionId'],
      boulJwe: listBoulJweModel(map['boulJwe']),
      createdAt: DateTimeUtility.convertDateFromString(map['createdAt']),
      updatedAt: DateTimeUtility.convertDateFromString(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TicketModel.fromJson(String source) =>
      TicketModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TicketModel(id: $id, userId: $userId, dayTime: $dayTime, type: $type, tirageName: $tirageName, tirageId: $tirageId, winningNumbers: $winningNumbers transactionId: $transactionId, createdAt: $createdAt, updatedAt: $updatedAt, boulJwe: $boulJwe)';
  }

  @override
  bool operator ==(covariant TicketModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.dayTime == dayTime &&
        other.type == type &&
        other.tirageName == tirageName &&
        other.tirageId == tirageId &&
        other.transactionId == transactionId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        listEquals(other.boulJwe, boulJwe) &&
        listEquals(other.winningNumbers, winningNumbers);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        dayTime.hashCode ^
        type.hashCode ^
        tirageName.hashCode ^
        tirageId.hashCode ^
        winningNumbers.hashCode ^
        transactionId.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        boulJwe.hashCode;
  }
}

class BoulJweModel {
  final int id;
  final int billetId;
  final String boul;
  final double amount;
  final GameStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  BoulJweModel({
    required this.id,
    required this.billetId,
    required this.boul,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  BoulJweModel copyWith({
    int? id,
    int? billetId,
    String? boul,
    double? amount,
    GameStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BoulJweModel(
      id: id ?? this.id,
      billetId: billetId ?? this.billetId,
      boul: boul ?? this.boul,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'billetId': billetId,
      'boul': boul,
      'amount': amount,
      'status': status.name,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory BoulJweModel.fromMap(Map<String, dynamic> map) {
    return BoulJweModel(
      id: map['id'] as int,
      billetId: map['billetId'] as int,
      boul: map['boul'] as String,
      amount: double.parse("${map['amount'] ?? 0}"),
      status: GameStatus.fromString(map['status']),
      createdAt: DateTimeUtility.convertDateFromString(map['createdAt']),
      updatedAt: DateTimeUtility.convertDateFromString(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BoulJweModel.fromJson(String source) =>
      BoulJweModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BoulJweModel(id: $id, billetId: $billetId, boul: $boul, amount: $amount, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant BoulJweModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.billetId == billetId &&
        other.boul == boul &&
        other.amount == amount &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        billetId.hashCode ^
        boul.hashCode ^
        amount.hashCode ^
        status.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }

  List<String> getboul(Gametype type) {
    switch (type) {
      case Gametype.bolet:
        return [boul];
      case Gametype.mariaj:
        RegExp exp = RegExp(r"\d{2}");
        Iterable<Match> matches = exp.allMatches(boul);
        return [...matches.map((m) => m.group(0)!)];
      case Gametype.lotto3:
        // TODO: Handle this case.
        throw UnimplementedError();
      case Gametype.lotto4:
        // TODO: Handle this case.
        throw UnimplementedError();
      case Gametype.lotto5:
        // TODO: Handle this case.
        throw UnimplementedError();
      case Gametype.lotto5p5:
        // TODO: Handle this case.
        throw UnimplementedError();
      case Gametype.royal5:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
    return [];
  }
}
