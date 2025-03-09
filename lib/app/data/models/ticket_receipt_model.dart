// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../core/utils/datetime_utility.dart';
import '../../core/utils/enums.dart';
import 'contact_list_model.dart';
import 'ticket_model.dart';
import 'transaction_model.dart';

class TicketReceiptModel extends TransactionModel {
  final List<TicketModel> billets;
  TicketReceiptModel({
    required this.billets,
    required super.id,
    required super.type,
    required super.contact,
    required super.user,
    required super.amount,
    required super.fees,
    required super.tax,
    required super.createdAt,
    required super.method,
  });

  @override
  TicketReceiptModel copyWith({
    int? id,
    TransactionType? type,
    ContactData? contact,
    TransactionMethod? method,
    ContactData? user,
    double? amount,
    double? fees,
    double? tax,
    DateTime? createdAt,
    List<TicketModel>? billets,
  }) {
    return TicketReceiptModel(
      id: id ?? this.id,
      type: type ?? this.type,
      contact: contact ?? this.contact,
      user: user ?? this.user,
      amount: amount ?? this.amount,
      fees: fees ?? this.fees,
      tax: tax ?? this.tax,
      method: method ?? this.method,
      createdAt: createdAt ?? this.createdAt,
      billets: billets ?? this.billets,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ...super.toMap(),
      'Billet': billets.map((x) => x.toMap()).toList(),
    };
  }

  factory TicketReceiptModel.fromMap(Map<String, dynamic> map) {
    return TicketReceiptModel(
      id: map['id'],
      type: TransactionType.fromMap(map['type']),
      method: TransactionMethod.fromMap(map['method']),
      contact: ContactData.fromMap(map['contact'] ?? {}),
      user: ContactData.fromMap(map['user'] ?? {}),
      fees: double.parse(map['fees'].toString()),
      tax: double.tryParse("${map['tax']}") ?? 0,
      amount: double.parse(map['amount'].toString()),
      createdAt: DateTimeUtility.convertDateFromString(map['created_at']),
      billets: List<TicketModel>.from(
        (map['Billet'] ?? []).map<TicketModel>(
          (x) => TicketModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory TicketReceiptModel.fromJson(String source) =>
      TicketReceiptModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TicketReceiptModel(id: $id, type: $type, method:$method, contact: $contact, user: $user, amount: $amount, fees: $fees, tax: $tax, createdAt: $createdAt, billets: $billets)';

  @override
  bool operator ==(covariant TicketReceiptModel other) {
    if (identical(this, other)) return true;

    return super == other && listEquals(other.billets, billets);
  }

  @override
  int get hashCode => super.hashCode ^ billets.hashCode;
}
