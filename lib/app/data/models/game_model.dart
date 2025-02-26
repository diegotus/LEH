// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../core/utils/datetime_utility.dart';
import '../../core/utils/enums.dart';

List<GameTirageModel> listGameTirageModel(List str) {
  return str.map((el) => GameTirageModel.fromMap(el)).toList();
}

class GameTirageModel {
  Gametype type;
  TirageName? tirageName;
  String boul;
  double amount;
  GameTirageModel({
    required this.type,
    this.tirageName,
    required this.boul,
    required this.amount,
  });
  static empty() => GameTirageModel(
        type: Gametype.bolet,
        tirageName: TirageName.FL,
        amount: 0,
        boul: '',
      );

  GameTirageModel copyWith({
    Gametype? type,
    TirageName? tirageName,
    String? boul,
    double? amount,
  }) {
    return GameTirageModel(
      type: type ?? this.type,
      tirageName: tirageName ?? this.tirageName,
      boul: boul ?? this.boul,
      amount: amount ?? this.amount,
    );
  }

  List<String> get getboul {
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
        exp ??= RegExp(r"\d{2,3}");
        Iterable<Match> matches = exp.allMatches(boul);
        return [...matches.map((m) => m.group(0)!)];
      case Gametype.lotto5p5:
        // TODO: Handle this case.
        throw UnimplementedError();
      case Gametype.royal5:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
    return [];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type.name,
      'tirageName': tirageName?.name,
      'boul': boul,
      'amount': amount,
    };
  }

  factory GameTirageModel.fromMap(Map<String, dynamic> map) {
    return GameTirageModel(
      type: Gametype.fromString(map['type']),
      tirageName: TirageName.fromString(map['tirageName']),
      boul: map['boul'],
      amount: double.parse("${map['amount']}"),
    );
  }

  String toJson() => json.encode(toMap());

  factory GameTirageModel.fromJson(String source) =>
      GameTirageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GameTirageModel(type: $type, tirageName: $tirageName, boul: $boul, amount: $amount)';
  }

  @override
  bool operator ==(covariant GameTirageModel other) {
    if (identical(this, other)) return true;

    return other.type == type &&
        other.tirageName == tirageName &&
        other.boul == boul &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        tirageName.hashCode ^
        boul.hashCode ^
        amount.hashCode;
  }
}
