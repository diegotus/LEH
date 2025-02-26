// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:get/get_rx/get_rx.dart';

List<ContactData> listContactFromListMap(List data) {
  return data.map((el) => ContactData.fromMap(el)).toList();
}

class ContactData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? avatar;
  RxBool isSelected = false.obs;

  ContactData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.avatar,
  });

  ContactData copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? avatar,
    bool? isSelected,
  }) {
    return ContactData(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar,
    };
  }

  factory ContactData.fromMap(Map<String, dynamic> map) {
    return ContactData(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'],
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'],
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactData.fromJson(String source) =>
      ContactData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ContactData(id: $id, name: $name, email: $email, phone: $phone, avatar: $avatar, isSelected: ${isSelected.value})';
  }

  @override
  bool operator ==(covariant ContactData other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.avatar == avatar &&
        other.isSelected.value == isSelected.value;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        avatar.hashCode ^
        isSelected.value.hashCode;
  }
}
