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
  String? authToken;
  UserDetailModel? userDetails;

  UserData({
    this.authToken,
    this.userDetails,
  });

  UserData copyWith({
    String? authToken,
    UserDetailModel? userDetails,
  }) {
    return UserData(
      authToken: authToken ?? this.authToken,
      userDetails: userDetails ?? this.userDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'auth_token': authToken,
      'userDetails': userDetails?.toMap()
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      authToken: map['auth_token'] != null ? map['auth_token'] as String : null,
      userDetails: UserDetailModel.fromMap(map),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserData(authToken: $authToken, userDetails: $userDetails)';
  }

  @override
  bool operator ==(covariant UserData other) {
    if (identical(this, other)) return true;

    return other.authToken == authToken && other.userDetails == userDetails;
  }

  @override
  int get hashCode {
    return authToken.hashCode ^ userDetails.hashCode;
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
