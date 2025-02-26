// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

List<AccountBalanceModel> listAccountModelFromMap(List str) {
  return str.map((el) => AccountBalanceModel.fromMap(el)).toList();
}

String registerModelToJson(List<AccountBalanceModel> data) =>
    json.encode(data.map((el) => el.toJson()));

class AccountBalanceModel {
  String? balance;
  String? limit;
  String? buyingLiabilities;
  String? sellingLiabilities;
  String? sponsor;
  int? lastModifiedLedger;
  bool? isAuthorized;
  bool? isAuthorizedToMaintainLiabilities;
  String? assetType;
  String? assetCode;
  String? assetIssuer;
  AccountBalanceModel({
    this.balance,
    this.limit,
    this.buyingLiabilities,
    this.sellingLiabilities,
    this.sponsor,
    this.lastModifiedLedger,
    this.isAuthorized,
    this.isAuthorizedToMaintainLiabilities,
    this.assetType,
    this.assetCode,
    this.assetIssuer,
  });

  AccountBalanceModel copyWith({
    String? balance,
    String? limit,
    String? buyingLiabilities,
    String? sellingLiabilities,
    String? sponsor,
    int? lastModifiedLedger,
    bool? isAuthorized,
    bool? isAuthorizedToMaintainLiabilities,
    String? assetType,
    String? assetCode,
    String? assetIssuer,
  }) {
    return AccountBalanceModel(
      balance: balance ?? this.balance,
      limit: limit ?? this.limit,
      buyingLiabilities: buyingLiabilities ?? this.buyingLiabilities,
      sellingLiabilities: sellingLiabilities ?? this.sellingLiabilities,
      sponsor: sponsor ?? this.sponsor,
      lastModifiedLedger: lastModifiedLedger ?? this.lastModifiedLedger,
      isAuthorized: isAuthorized ?? this.isAuthorized,
      isAuthorizedToMaintainLiabilities: isAuthorizedToMaintainLiabilities ??
          this.isAuthorizedToMaintainLiabilities,
      assetType: assetType ?? this.assetType,
      assetCode: assetCode ?? this.assetCode,
      assetIssuer: assetIssuer ?? this.assetIssuer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'balance': balance,
      'limit': limit,
      'buying_liabilities': buyingLiabilities,
      'selling_liabilities': sellingLiabilities,
      'sponsor': sponsor,
      'last_modified_ledger': lastModifiedLedger,
      'is_authorized': isAuthorized,
      'is_authorized_to_maintain_liabilities':
          isAuthorizedToMaintainLiabilities,
      'asset_type': assetType,
      'asset_code': assetCode,
      'asset_issuer': assetIssuer,
    };
  }

  factory AccountBalanceModel.fromMap(Map<String, dynamic> map) {
    return AccountBalanceModel(
      balance: map['balance'] != null ? map['balance'] as String : null,
      limit: map['limit'] != null ? map['limit'] as String : null,
      buyingLiabilities: map['buying_liabilities'] != null
          ? map['buying_liabilities'] as String
          : null,
      sellingLiabilities: map['selling_liabilities'] != null
          ? map['selling_liabilities'] as String
          : null,
      sponsor: map['sponsor'] != null ? map['sponsor'] as String : null,
      lastModifiedLedger: map['last_modified_ledger'] != null
          ? map['last_modified_ledger'] as int
          : null,
      isAuthorized:
          map['is_authorized'] != null ? map['is_authorized'] as bool : null,
      isAuthorizedToMaintainLiabilities:
          map['is_authorized_to_maintain_liabilities'] != null
              ? map['is_authorized_to_maintain_liabilities'] as bool
              : null,
      assetType: map['asset_type'] != null ? map['asset_type'] as String : null,
      assetCode: map['asset_code'] != null ? map['asset_code'] as String : null,
      assetIssuer:
          map['asset_issuer'] != null ? map['asset_issuer'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountBalanceModel.fromJson(String source) =>
      AccountBalanceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AccountBalanceModel(balance: $balance, limit: $limit, buyingLiabilities: $buyingLiabilities, sellingLiabilities: $sellingLiabilities, sponsor: $sponsor, lastModifiedLedger: $lastModifiedLedger, isAuthorized: $isAuthorized, isAuthorizedToMaintainLiabilities: $isAuthorizedToMaintainLiabilities, assetType: $assetType, assetCode: $assetCode, assetIssuer: $assetIssuer)';
  }

  @override
  bool operator ==(covariant AccountBalanceModel other) {
    if (identical(this, other)) return true;

    return other.balance == balance &&
        other.limit == limit &&
        other.buyingLiabilities == buyingLiabilities &&
        other.sellingLiabilities == sellingLiabilities &&
        other.sponsor == sponsor &&
        other.lastModifiedLedger == lastModifiedLedger &&
        other.isAuthorized == isAuthorized &&
        other.isAuthorizedToMaintainLiabilities ==
            isAuthorizedToMaintainLiabilities &&
        other.assetType == assetType &&
        other.assetCode == assetCode &&
        other.assetIssuer == assetIssuer;
  }

  @override
  int get hashCode {
    return balance.hashCode ^
        limit.hashCode ^
        buyingLiabilities.hashCode ^
        sellingLiabilities.hashCode ^
        sponsor.hashCode ^
        lastModifiedLedger.hashCode ^
        isAuthorized.hashCode ^
        isAuthorizedToMaintainLiabilities.hashCode ^
        assetType.hashCode ^
        assetCode.hashCode ^
        assetIssuer.hashCode;
  }
}
