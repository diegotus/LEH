// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get_storage_pro/get_storage_pro.dart';

import 'user_detail_model.dart';

@gsp
class CurrentUser extends CommonDataClass<CurrentUser> {
  @override
  String get id => "currentUser";

  UserDetailModel? userDetails;
  int unReadNotification;

  CurrentUser({
    this.userDetails,
    this.unReadNotification = 0,
  });

  CurrentUser copyWith({
    UserDetailModel? userDetails,
    int? unReadNotification,
  }) {
    return CurrentUser(
      userDetails: userDetails ?? this.userDetails,
      unReadNotification: unReadNotification ?? this.unReadNotification,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userDetails': userDetails?.toMap(),
      'unReadNotification': unReadNotification,
    };
  }

  factory CurrentUser.fromMap(Map<String, dynamic> map) {
    return CurrentUser(
      userDetails: map['userDetails'] != null
          ? UserDetailModel.fromMap(map['userDetails'] as Map<String, dynamic>)
          : null,
      unReadNotification: map['unReadNotification'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentUser.fromJson(String source) =>
      CurrentUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CurrentUser(userDetails: $userDetails, unReadNotification: $unReadNotification)';

  @override
  bool operator ==(covariant CurrentUser other) {
    if (identical(this, other)) return true;

    return other.userDetails == userDetails &&
        other.unReadNotification == unReadNotification;
  }

  @override
  int get hashCode => userDetails.hashCode ^ unReadNotification.hashCode;
}

class UserData {
  int? id;
  String? authToken;
  String? name;
  String? email;
  List<Balance>? balances;

  UserData({
    this.id,
    this.authToken,
    this.name,
    this.email,
    this.balances,
  });

  UserData copyWith({
    int? id,
    String? authToken,
    String? name,
    String? email,
    List<Balance>? balances,
  }) {
    return UserData(
      id: id ?? this.id,
      authToken: authToken ?? this.authToken,
      name: name ?? this.name,
      email: email ?? this.email,
      balances: balances ?? this.balances,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      'auth_token': authToken,
      'name': name,
      'email': email,
      'balances': balances?.map((x) => x.toMap()).toList(),
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map["id"],
      authToken: map['auth_token'] != null ? map['auth_token'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      balances: List.from(map['balances'] ?? [])
          .map(
            (x) => Balance.fromMap(x as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserData(id: $id, authToken: $authToken, name: $name, email: $email, balances: $balances)';
  }

  @override
  bool operator ==(covariant UserData other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.authToken == authToken &&
        other.name == name &&
        other.email == email &&
        listEquals(other.balances, balances);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        authToken.hashCode ^
        name.hashCode ^
        email.hashCode ^
        balances.hashCode;
  }
}

class Balance {
  String balance;
  String buyingLiabilities;
  String sellingLiabilities;
  String assetType;

  Balance({
    required this.balance,
    required this.buyingLiabilities,
    required this.sellingLiabilities,
    required this.assetType,
  });

  Balance copyWith({
    String? balance,
    String? buyingLiabilities,
    String? sellingLiabilities,
    String? assetType,
  }) {
    return Balance(
      balance: balance ?? this.balance,
      buyingLiabilities: buyingLiabilities ?? this.buyingLiabilities,
      sellingLiabilities: sellingLiabilities ?? this.sellingLiabilities,
      assetType: assetType ?? this.assetType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'balance': balance,
      'buying_liabilities': buyingLiabilities,
      'selling_liabilities': sellingLiabilities,
      'asset_type': assetType,
    };
  }

  factory Balance.fromMap(Map<String, dynamic> map) {
    return Balance(
      balance: map['balance'],
      buyingLiabilities: map['buying_liabilities'],
      sellingLiabilities: map['selling_liabilities'],
      assetType: map['asset_type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Balance.fromJson(String source) =>
      Balance.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Balance(balance: $balance, buyingLiabilities: $buyingLiabilities, sellingLiabilities: $sellingLiabilities, assetType: $assetType)';
  }

  @override
  bool operator ==(covariant Balance other) {
    if (identical(this, other)) return true;

    return other.balance == balance &&
        other.buyingLiabilities == buyingLiabilities &&
        other.sellingLiabilities == sellingLiabilities &&
        other.assetType == assetType;
  }

  @override
  int get hashCode {
    return balance.hashCode ^
        buyingLiabilities.hashCode ^
        sellingLiabilities.hashCode ^
        assetType.hashCode;
  }
}
