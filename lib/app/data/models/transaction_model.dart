// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:get/get.dart';

import '../../core/utils/datetime_utility.dart';
import '../../core/utils/enums.dart';
import 'contact_list_model.dart';

class TransactionModel {
  final int id;
  final TransactionType type;
  ContactData? receiver;
  ContactData? user;
  double amount;
  TransactionMethod method;
  double fees;
  DateTime createdAt;
  final double tax;

  TransactionModel({
    required this.id,
    required this.type,
    required this.receiver,
    required this.user,
    required this.amount,
    required this.fees,
    required this.tax,
    required this.createdAt,
    required this.method,
  }) : assert(receiver != null || user != null,
            "$receiver or $user must not null");

  TransactionModel copyWith({
    int? id,
    TransactionType? type,
    ContactData? receiver,
    ContactData? user,
    double? amount,
    double? fees,
    double? tax,
    DateTime? createdAt,
    TransactionMethod? method,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      type: type ?? this.type,
      receiver: receiver ?? this.receiver,
      user: user ?? this.user,
      amount: amount ?? this.amount,
      fees: fees ?? this.fees,
      tax: tax ?? this.tax,
      createdAt: createdAt ?? this.createdAt,
      method: method ?? this.method,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type.toMap(),
      'receiver': receiver?.toMap(),
      'user': user?.toMap(),
      'amount': amount,
      'fees': fees,
      'tax': tax,
      'createdAt': createdAt.millisecondsSinceEpoch,
      "method": method,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
        id: map['id'],
        type: TransactionType.fromMap(map['type']),
        receiver: map['receiver'] != null
            ? ContactData.fromMap(map['receiver'])
            : null,
        user: map['user'] != null ? ContactData.fromMap(map['user']) : null,
        fees: double.parse(map['fees'].toString()),
        tax: double.tryParse("${map['tax']}") ?? 0,
        amount: double.parse(map['amount'].toString()),
        createdAt: DateTimeUtility.convertDateFromString(map['created_at']),
        method: TransactionMethod.fromMap(map['method']));
  }

  static List<TransactionModel> fromList(List data) {
    return data.map((el) => TransactionModel.fromMap(el)).toList();
  }

  Direction direction(String? id) {
    // if (type == TransactionType.lotoPlay) return Direction.outbound;
    if (receiver?.phone == id) {
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
      titleLocArgs.add(method.name.toUpperCase());
      bodyLocArgs.add(method.name.toUpperCase());
    }
    bodyLocArgs.add(amount.toString());

    if (![
      TransactionType.cash,
      TransactionType.lotoPlay,
      TransactionType.lotoWin
    ].contains(type)) {
      ContactData userSelected;
      if (direction == Direction.inbound) {
        userSelected = user!;
      } else {
        userSelected = receiver!;
      }
      bodyLocArgs.add('${userSelected.name}');
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
    return 'TransactionModel(id: $id, type: $type, method: $method, receiver: $receiver, user: $user, amount: $amount, fees: $fees,  tax: $tax, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant TransactionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.type == type &&
        other.method == method &&
        other.receiver == receiver &&
        other.user == user &&
        other.amount == amount &&
        other.fees == fees &&
        other.tax == tax &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        method.hashCode ^
        receiver.hashCode ^
        user.hashCode ^
        amount.hashCode ^
        fees.hashCode ^
        tax.hashCode ^
        createdAt.hashCode;
  }
}
