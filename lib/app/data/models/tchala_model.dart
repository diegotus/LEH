// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

List<TchalaModel> listTchalaModel(List str) {
  return str.map((el) => TchalaModel.fromMap(el)).toList();
}

class TchalaModel {
  final int id;
  final String label;
  final String description;
  final List<String> bouls;
  TchalaModel({
    required this.id,
    required this.label,
    required this.description,
    required this.bouls,
  });

  TchalaModel copyWith({
    int? id,
    String? label,
    String? description,
    List<String>? bouls,
  }) {
    return TchalaModel(
      id: id ?? this.id,
      label: label ?? this.label,
      description: description ?? this.description,
      bouls: bouls ?? this.bouls,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'label': label,
      'description': description,
      'bouls': bouls,
    };
  }

  factory TchalaModel.fromMap(Map<String, dynamic> map) {
    return TchalaModel(
      id: map['id'] as int,
      label: map['label'] as String,
      description: map['description'] as String,
      bouls: List<String>.from((map['bouls'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory TchalaModel.fromJson(String source) =>
      TchalaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TchalaModel(id: $id, label: $label, description: $description, bouls: $bouls)';
  }

  @override
  bool operator ==(covariant TchalaModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.label == label &&
        other.description == description &&
        listEquals(other.bouls, bouls);
  }

  @override
  int get hashCode {
    return id.hashCode ^ label.hashCode ^ description.hashCode ^ bouls.hashCode;
  }
}
