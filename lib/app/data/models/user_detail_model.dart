// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ui';

import '../../core/utils/enums.dart';
import 'contact_list_model.dart';

class UserDetailModel extends ContactData {
  String? createdAt;
  String? updatedAt;
  ExtraInfo? extraInfo;
  String? hasNotificationToken;
  UserDetailModel({
    super.id,
    super.avatar,
    super.name,
    super.email,
    super.phone,
    this.createdAt,
    this.updatedAt,
    this.extraInfo,
    this.hasNotificationToken,
  });

  @override
  UserDetailModel copyWith({
    int? id,
    String? avatar,
    String? name,
    String? email,
    String? phone,
    String? createdAt,
    String? updatedAt,
    ExtraInfo? extraInfo,
    bool? isSelected,
    String? hasNotificationToken, //has_notification_token
  }) {
    return UserDetailModel(
      id: id ?? this.id,
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      hasNotificationToken: hasNotificationToken ?? this.hasNotificationToken,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      extraInfo: extraInfo ?? this.extraInfo,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'avatar': avatar,
      'name': name,
      'email': email,
      'phone': phone,
      'has_notification_token': hasNotificationToken,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'extra_info': extraInfo?.toMap(),
    };
  }

  factory UserDetailModel.fromMap(Map<String, dynamic> map) {
    return UserDetailModel(
      id: map['id'] != null ? map['id'] as int : null,
      avatar: map['avatar'],
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      hasNotificationToken: map['has_notification_token'],
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
      extraInfo: map['extra_info'] != null
          ? ExtraInfo.fromMap(map['extra_info'] as Map<String, dynamic>)
          : null,
    );
  }
  @override
  String toJson() => json.encode(toMap());

  factory UserDetailModel.fromJson(String source) =>
      UserDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserDetailModel(id: $id, avatar: $avatar, name: $name, email: $email, phone: $phone, has_notification_token: $hasNotificationToken, createdAt: $createdAt, updatedAt: $updatedAt, extraInfo: $extraInfo)';
  }

  @override
  bool operator ==(covariant UserDetailModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.avatar == avatar &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.hasNotificationToken == hasNotificationToken &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.extraInfo == extraInfo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        avatar.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        hasNotificationToken.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        extraInfo.hashCode;
  }
}

class ExtraInfo {
  AddressData? address;
  String? dob;
  Locale locale;
  ExtraInfo({
    this.address,
    this.dob,
    this.locale = const Locale('fr'),
  });

  ExtraInfo copyWith({
    AddressData? address,
    String? dob,
    Locale? locale,
  }) {
    return ExtraInfo(
        address: address ?? this.address,
        dob: dob ?? this.dob,
        locale: locale ?? this.locale);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address?.toMap(),
      'dob': dob,
      'locale': locale.languageCode,
    };
  }

  factory ExtraInfo.fromMap(Map<String, dynamic> map) {
    return ExtraInfo(
      address:
          map['address'] != null ? AddressData.fromMap(map['address']) : null,
      dob: map['dob'] != null ? map['dob'] as String : null,
      locale: Locale(map['locale'] ?? 'fr'),
    );
  }

  String toJson() => json.encode(toMap());

  factory ExtraInfo.fromJson(String source) =>
      ExtraInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ExtraInfo( address: $address, dob: $dob, locale: ${locale.languageCode})';
  }

  @override
  bool operator ==(covariant ExtraInfo other) {
    if (identical(this, other)) return true;

    return other.address == address &&
        other.dob == dob &&
        other.locale == locale;
  }

  @override
  int get hashCode {
    return address.hashCode ^ dob.hashCode ^ locale.hashCode;
  }
}

class AddressData {
  String? address;
  String? city;
  String? state;
  String? countr;
  int? pincode;

  AddressData({
    this.address,
    this.city,
    this.state,
    this.countr,
    this.pincode,
  });

  AddressData copyWith({
    String? address,
    String? city,
    String? state,
    String? countr,
    int? pincode,
  }) {
    return AddressData(
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      countr: countr ?? this.countr,
      pincode: pincode ?? this.pincode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'city': city,
      'state': state,
      'countr': countr,
      'pincode': pincode,
    };
  }

  factory AddressData.fromMap(Map<String, dynamic> map) {
    return AddressData(
      address: map['address'] != null ? map['address'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      state: map['state'] != null ? map['state'] as String : null,
      countr: map['countr'] != null ? map['countr'] as String : null,
      pincode: map['pincode'] != null ? map['pincode'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressData.fromJson(String source) =>
      AddressData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddressData(address: $address, city: $city, state: $state, countr: $countr, pincode: $pincode)';
  }

  @override
  bool operator ==(covariant AddressData other) {
    if (identical(this, other)) return true;

    return other.address == address &&
        other.city == city &&
        other.state == state &&
        other.countr == countr &&
        other.pincode == pincode;
  }

  @override
  int get hashCode {
    return address.hashCode ^
        city.hashCode ^
        state.hashCode ^
        countr.hashCode ^
        pincode.hashCode;
  }
}

class IdDoc {
  String? front;
  String? back;
  String? face;
  IdDoc({
    this.front,
    this.back,
    this.face,
  });

  IdDoc copyWith({
    String? front,
    String? back,
    String? face,
  }) {
    return IdDoc(
      front: front ?? this.front,
      back: back ?? this.back,
      face: face ?? this.face,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'front': front,
      'back': back,
      'face': face,
    };
  }

  factory IdDoc.fromMap(Map<String, dynamic> map) {
    return IdDoc(
      front: map['front'] != null ? map['front'] as String : null,
      back: map['back'] != null ? map['back'] as String : null,
      face: map['face'] != null ? map['face'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory IdDoc.fromJson(String source) =>
      IdDoc.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'IdDoc(front: $front, back: $back, face: $face)';

  @override
  bool operator ==(covariant IdDoc other) {
    if (identical(this, other)) return true;

    return other.front == front && other.back == back && other.face == face;
  }

  @override
  int get hashCode => front.hashCode ^ back.hashCode ^ face.hashCode;
}
