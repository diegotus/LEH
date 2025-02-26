// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:haiti_lotri/app/core/utils/enums.dart';

import '../../core/utils/datetime_utility.dart';

List<NextTirageModel> listNextTirageModel(List str) {
  return str.map((el) => NextTirageModel.fromMap(el)).toList();
}

List<ResultTirageModel> listResultTirageModel(List str) {
  return str.map((el) => ResultTirageModel.fromMap(el)).toList();
}

class NextTirageModel {
  String name;
  DateTime date;
  NextTirageModel({
    required this.name,
    required this.date,
  });

  NextTirageModel copyWith({
    String? name,
    DateTime? date,
  }) {
    return NextTirageModel(
      name: name ?? this.name,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'date': date.toIso8601String(),
    };
  }

  factory NextTirageModel.fromMap(Map<String, dynamic> map) {
    return NextTirageModel(
      name: map['name'] as String,
      date: DateTimeUtility.convertDateFromString(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory NextTirageModel.fromJson(String source) =>
      NextTirageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'NextTirageModel(name: $name, date: $date)';

  @override
  bool operator ==(covariant NextTirageModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.date == date;
  }

  @override
  int get hashCode => name.hashCode ^ date.hashCode;
}

class ResultTirageModel {
  final DayTime dayTime;
  final String firstLot;
  final String secondLot;
  final String thirdLot;
  final DateTime createdAt;

  ResultTirageModel({
    required this.dayTime,
    required this.firstLot,
    required this.secondLot,
    required this.thirdLot,
    required this.createdAt,
  });

  ResultTirageModel copyWith({
    DayTime? dayTime,
    String? firstLot,
    String? secondLot,
    String? thirdLot,
    DateTime? createdAt,
  }) {
    return ResultTirageModel(
      dayTime: dayTime ?? this.dayTime,
      firstLot: firstLot ?? this.firstLot,
      secondLot: secondLot ?? this.secondLot,
      thirdLot: thirdLot ?? this.thirdLot,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dayTime': dayTime.name,
      'firstLot': firstLot,
      'secondLot': secondLot,
      'thirdLot': thirdLot,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ResultTirageModel.fromMap(Map<String, dynamic> map) {
    return ResultTirageModel(
      dayTime: DayTime.fromString(map['dayTime']),
      firstLot: map['firstLot'],
      secondLot: map['secondLot'],
      thirdLot: map['thirdLot'],
      createdAt: DateTimeUtility.convertDateFromString(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultTirageModel.fromJson(String source) =>
      ResultTirageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ResultTirageModel(dayTime: $dayTime, firstLot: $firstLot, secondLot: $secondLot, thirdLot: $thirdLot, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant ResultTirageModel other) {
    if (identical(this, other)) return true;

    return other.dayTime == dayTime &&
        other.firstLot == firstLot &&
        other.secondLot == secondLot &&
        other.thirdLot == thirdLot &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return dayTime.hashCode ^
        firstLot.hashCode ^
        secondLot.hashCode ^
        thirdLot.hashCode ^
        createdAt.hashCode;
  }
}
