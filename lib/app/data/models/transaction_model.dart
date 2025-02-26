// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/datetime_utility.dart';
import '../../core/utils/enums.dart';
import 'contact_list_model.dart';

class TransactionModel {
  final int id;
  final TransactionType type;
  ContactData contact;
  ContactData user;
  double amount;
  TransactionMethod method;
  double fees;
  DateTime createdAt;

  TransactionModel(
      {required this.id,
      required this.type,
      required this.contact,
      required this.user,
      required this.amount,
      required this.fees,
      required this.createdAt,
      required this.method});

  TransactionModel copyWith({
    int? id,
    TransactionType? type,
    ContactData? contact,
    ContactData? user,
    double? amount,
    double? fees,
    DateTime? createdAt,
    TransactionMethod? method,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      type: type ?? this.type,
      contact: contact ?? this.contact,
      user: user ?? this.user,
      amount: amount ?? this.amount,
      fees: fees ?? this.fees,
      createdAt: createdAt ?? this.createdAt,
      method: method ?? this.method,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type.toMap(),
      'contact': contact.toMap(),
      'user': user.toMap(),
      'amount': amount,
      'fees': fees,
      'createdAt': createdAt.millisecondsSinceEpoch,
      "method": method,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
        id: map['id'],
        type: TransactionType.fromMap(map['type']),
        contact: ContactData.fromMap(map['contact']),
        user: ContactData.fromMap(map['user']),
        fees: double.parse(map['fees'].toString()),
        amount: double.parse(map['amount'].toString()),
        createdAt: DateTimeUtility.convertDateFromString(map['created_at']),
        method: TransactionMethod.fromMap(map['method']));
  }

  static List<TransactionModel> fromList(List data) {
    return data.map((el) => TransactionModel.fromMap(el)).toList();
  }

  Direction direction(String? id) {
    if (contact.phone == id) {
      return Direction.inbound;
    } else {
      return Direction.outbound;
    }
  }

  Map<String, String> getTitle(Direction direction) {
    final titleLockKey = 'NOTIFICATION_TITLE_${type.name.toUpperCase()}';
    final bodyLockKey = 'NOTIFICATION_BODY_${type.name.toUpperCase()}';
    var bodyLocArgs = <String>[];
    var titleLocArgs = <String>[];
    var directionText = '';

    if (type == TransactionType.transfer) {
      directionText = direction == Direction.inbound ? '_RECEIVED' : '_SENT';
    } else if (type == TransactionType.cash) {
      directionText = direction == Direction.inbound ? '_IN' : '_OUT';
    }
    if ([TransactionType.lotoPlay, TransactionType.lotoWin].contains(type)) {
      bodyLocArgs.addAll([amount.toString(), "${contact.name}"]);
    }
    if (type == TransactionType.cash) {
      titleLocArgs.add(method.name.toUpperCase());
      bodyLocArgs.add(method.name.toUpperCase());
    } else {
      if (direction == Direction.inbound) {
        bodyLocArgs.add('${user.name} - ${user.phone}');
      } else {
        bodyLocArgs.add('${contact.name} - ${contact.phone}');
      }
    }

    return {
      'title': '$titleLockKey$directionText'.trArgs(titleLocArgs),
      'body': '$bodyLockKey$directionText'.trArgs(bodyLocArgs),
    };
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TransactionModel(id: $id, type: $type, method: $method, contact: $contact, user: $user, amount: $amount, fees: $fees, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant TransactionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.type == type &&
        other.method == method &&
        other.contact == contact &&
        other.user == user &&
        other.amount == amount &&
        other.fees == fees &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        method.hashCode ^
        contact.hashCode ^
        user.hashCode ^
        amount.hashCode ^
        fees.hashCode ^
        createdAt.hashCode;
  }
}
