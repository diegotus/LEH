// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
  int? score;
  IdDoc? idDoc;
  VerificationStatus? idVerified;
  VerificationStatus? addressVerified;
  int? userId;
  String? addressDoc;
  AddressData? address;
  String? dob;
  int? income;
  String? incomeDoc;
  VerificationStatus? incomeVerified;
  VerificationStatus? occupationVerified;
  String? occupation;
  String? occupationDoc;
  ExtraInfo({
    this.score,
    this.idDoc,
    this.idVerified,
    this.addressVerified,
    this.userId,
    this.addressDoc,
    this.address,
    this.dob,
    this.income,
    this.incomeDoc,
    this.incomeVerified,
    this.occupationVerified,
    this.occupation,
    this.occupationDoc,
  });

  ExtraInfo copyWith({
    int? score,
    IdDoc? idDoc,
    VerificationStatus? idVerified,
    VerificationStatus? addressVerified,
    int? userId,
    String? addressDoc,
    AddressData? address,
    String? dob,
    int? income,
    String? incomeDoc,
    VerificationStatus? incomeVerified,
    VerificationStatus? occupationVerified,
    String? occupation,
    String? occupationDoc,
  }) {
    return ExtraInfo(
      score: score ?? this.score,
      idDoc: idDoc ?? this.idDoc,
      idVerified: idVerified ?? this.idVerified,
      addressVerified: addressVerified ?? this.addressVerified,
      userId: userId ?? this.userId,
      addressDoc: addressDoc ?? this.addressDoc,
      address: address ?? this.address,
      dob: dob ?? this.dob,
      income: income ?? this.income,
      incomeDoc: incomeDoc ?? this.incomeDoc,
      incomeVerified: incomeVerified ?? this.incomeVerified,
      occupationVerified: occupationVerified ?? this.occupationVerified,
      occupation: occupation ?? this.occupation,
      occupationDoc: occupationDoc ?? this.occupationDoc,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'score': score,
      'id_doc': idDoc?.toMap(),
      'id_verified': idVerified?.name,
      'address_verified': addressVerified?.name,
      'user_id': userId,
      'address_doc': addressDoc,
      'address': address?.toMap(),
      'dob': dob,
      'income': income,
      'income_doc': incomeDoc,
      'income_verified': incomeVerified?.name,
      'occupation_verified': occupationVerified?.name,
      'occupation': occupation,
      'occupation_doc': occupationDoc,
    };
  }

  factory ExtraInfo.fromMap(Map<String, dynamic> map) {
    return ExtraInfo(
      userId: map['user_id'] != null ? map['user_id'] as int : null,
      score: map['score'] != null ? map['score'] as int : null,
      idDoc: map['id_doc'] != null ? IdDoc.fromMap(map['id_doc']) : null,
      idVerified: map['id_verified'] != null
          ? VerificationStatus.fromString(map['id_verified'])
          : null,
      addressVerified: map['address_verified'] != null
          ? VerificationStatus.fromString(map['address_verified'])
          : null,
      addressDoc:
          map['address_doc'] != null ? map['address_doc'] as String : null,
      address:
          map['address'] != null ? AddressData.fromMap(map['address']) : null,
      dob: map['dob'] != null ? map['dob'] as String : null,
      income: map['income'] != null ? map['income'] as int : null,
      incomeDoc: map['income_doc'] != null ? map['income_doc'] as String : null,
      incomeVerified: map['income_verified'] != null
          ? VerificationStatus.fromString(map['income_verified'])
          : null,
      occupationVerified: map['occupation_verified'] != null
          ? VerificationStatus.fromString(map['occupation_verified'])
          : null,
      occupation:
          map['occupation'] != null ? map['occupation'] as String : null,
      occupationDoc: map['occupation_doc'] != null
          ? map['occupation_doc'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExtraInfo.fromJson(String source) =>
      ExtraInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ExtraInfo(score: $score, idDoc: $idDoc, idVerified: $idVerified, addressVerified: $addressVerified, userId: $userId, addressDoc: $addressDoc, address: $address, dob: $dob, income: $income, incomeDoc: $incomeDoc, incomeVerified: $incomeVerified, occupationVerified: $occupationVerified, occupation: $occupation, occupationDoc: $occupationDoc)';
  }

  @override
  bool operator ==(covariant ExtraInfo other) {
    if (identical(this, other)) return true;

    return other.score == score &&
        other.idDoc == idDoc &&
        other.idVerified == idVerified &&
        other.addressVerified == addressVerified &&
        other.userId == userId &&
        other.addressDoc == addressDoc &&
        other.address == address &&
        other.dob == dob &&
        other.income == income &&
        other.incomeDoc == incomeDoc &&
        other.incomeVerified == incomeVerified &&
        other.occupationVerified == occupationVerified &&
        other.occupation == occupation &&
        other.occupationDoc == occupationDoc;
  }

  @override
  int get hashCode {
    return score.hashCode ^
        idDoc.hashCode ^
        idVerified.hashCode ^
        addressVerified.hashCode ^
        userId.hashCode ^
        addressDoc.hashCode ^
        address.hashCode ^
        dob.hashCode ^
        income.hashCode ^
        incomeDoc.hashCode ^
        incomeVerified.hashCode ^
        occupationVerified.hashCode ^
        occupation.hashCode ^
        occupationDoc.hashCode;
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
