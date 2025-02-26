// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'contact_list_model.dart';

class ValidationData {
  final int id;
  final ContactData senderInfo;
  final ContactData receiverInfo;
  final double fees;
  ValidationData({
    required this.id,
    required this.senderInfo,
    required this.receiverInfo,
    required this.fees,
  });

  ValidationData copyWith({
    int? id,
    ContactData? senderInfo,
    ContactData? receiverInfo,
    double? fees,
  }) {
    return ValidationData(
      id: id ?? this.id,
      senderInfo: senderInfo ?? this.senderInfo,
      receiverInfo: receiverInfo ?? this.receiverInfo,
      fees: fees ?? this.fees,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'senderInfo': senderInfo.toMap(),
      'receiverInfo': receiverInfo.toMap(),
      'fees': fees,
    };
  }

  factory ValidationData.fromMap(Map<String, dynamic> map) {
    return ValidationData(
      id: map['id'] as int,
      senderInfo:
          ContactData.fromMap(map['senderInfo'] as Map<String, dynamic>),
      receiverInfo:
          ContactData.fromMap(map['receiverInfo'] as Map<String, dynamic>),
      fees: double.tryParse("${map['fees']}") ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ValidationData.fromJson(String source) =>
      ValidationData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ValidationData(id: $id, senderInfo: $senderInfo, receiverInfo: $receiverInfo, fees: $fees)';
  }

  @override
  bool operator ==(covariant ValidationData other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.senderInfo == senderInfo &&
        other.receiverInfo == receiverInfo &&
        other.fees == fees;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        senderInfo.hashCode ^
        receiverInfo.hashCode ^
        fees.hashCode;
  }
}
