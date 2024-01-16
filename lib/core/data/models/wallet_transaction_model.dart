import 'dart:convert';

class WalletTransactionModel {
  final int? id;
  final int? originatedEntityId;
  final num? amount;
  final String? walletHistoryType;
  final bool? expired;
  final String? expiredDateTime;
  final String? createDateTime;
  WalletTransactionModel({
    this.id,
    this.originatedEntityId,
    this.amount,
    this.walletHistoryType,
    this.expired,
    this.expiredDateTime,
    this.createDateTime,
  });

  WalletTransactionModel copyWith({
    int? id,
    int? originatedEntityId,
    num? amount,
    String? walletHistoryType,
    bool? expired,
    String? expiredDateTime,
    String? createDateTime,
  }) {
    return WalletTransactionModel(
      id: id ?? this.id,
      originatedEntityId: originatedEntityId ?? this.originatedEntityId,
      amount: amount ?? this.amount,
      walletHistoryType: walletHistoryType ?? this.walletHistoryType,
      expired: expired ?? this.expired,
      expiredDateTime: expiredDateTime ?? this.expiredDateTime,
      createDateTime: createDateTime ?? this.createDateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'originatedEntityId': originatedEntityId,
      'amount': amount,
      'walletHistoryType': walletHistoryType,
      'expired': expired,
      'expiredDateTime': expiredDateTime,
      'createDateTime': createDateTime,
    };
  }

  factory WalletTransactionModel.fromMap(Map<String, dynamic> map) {
    return WalletTransactionModel(
      id: map['id']?.toInt(),
      originatedEntityId: map['originatedEntityId']?.toInt(),
      amount: map['amount'],
      walletHistoryType: map['walletHistoryType'],
      expired: map['expired'],
      expiredDateTime: map['expiredDateTime'],
      createDateTime: map['createDateTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletTransactionModel.fromJson(String source) {
    return WalletTransactionModel.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return 'WalletTransactionModel(id: $id, originatedEntityId: $originatedEntityId, amount: $amount, walletHistoryType: $walletHistoryType, expired: $expired, expiredDateTime: $expiredDateTime, createDateTime: $createDateTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WalletTransactionModel &&
        other.id == id &&
        other.originatedEntityId == originatedEntityId &&
        other.amount == amount &&
        other.walletHistoryType == walletHistoryType &&
        other.expired == expired &&
        other.expiredDateTime == expiredDateTime &&
        other.createDateTime == createDateTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        originatedEntityId.hashCode ^
        amount.hashCode ^
        walletHistoryType.hashCode ^
        expired.hashCode ^
        expiredDateTime.hashCode ^
        createDateTime.hashCode;
  }
}
