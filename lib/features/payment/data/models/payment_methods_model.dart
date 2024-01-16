import 'dart:convert';

import 'package:flutter/foundation.dart';

class PaymentMethodsModel {
  Model? model;
  dynamic redirectToMethod;
  dynamic id;
  PaymentMethodsModel({
    this.model,
    required this.redirectToMethod,
    required this.id,
  });

  PaymentMethodsModel copyWith({
    Model? model,
    dynamic redirectToMethod,
    dynamic id,
  }) {
    return PaymentMethodsModel(
      model: model ?? this.model,
      redirectToMethod: redirectToMethod ?? this.redirectToMethod,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'model': model?.toMap(),
      'redirect_to_method': redirectToMethod,
      'id': id,
    };
  }

  factory PaymentMethodsModel.fromMap(Map<String, dynamic> map) {
    return PaymentMethodsModel(
      model: map['model'] != null ? Model.fromMap(map['model']) : null,
      redirectToMethod: map['redirect_to_method'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethodsModel.fromJson(String source) =>
      PaymentMethodsModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'PaymentMethodsModel(model: $model, redirect_to_method: $redirectToMethod, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentMethodsModel &&
        other.model == model &&
        other.redirectToMethod == redirectToMethod &&
        other.id == id;
  }

  @override
  int get hashCode => model.hashCode ^ redirectToMethod.hashCode ^ id.hashCode;
}

class Model {
  List<PaymentMethod>? paymentMethods;
  bool? displayRewardPoints;
  int? rewardPointsBalance;
  dynamic rewardPointsAmount;
  bool? rewardPointsEnoughToPayForOrder;
  bool? useRewardPoints;
  Model({
    this.paymentMethods,
    this.displayRewardPoints,
    this.rewardPointsBalance,
    required this.rewardPointsAmount,
    this.rewardPointsEnoughToPayForOrder,
    this.useRewardPoints,
  });

  Model copyWith({
    List<PaymentMethod>? paymentMethods,
    bool? displayRewardPoints,
    int? rewardPointsBalance,
    dynamic rewardPointsAmount,
    bool? rewardPointsEnoughToPayForOrder,
    bool? useRewardPoints,
  }) {
    return Model(
      paymentMethods: paymentMethods ?? this.paymentMethods,
      displayRewardPoints: displayRewardPoints ?? this.displayRewardPoints,
      rewardPointsBalance: rewardPointsBalance ?? this.rewardPointsBalance,
      rewardPointsAmount: rewardPointsAmount ?? this.rewardPointsAmount,
      rewardPointsEnoughToPayForOrder: rewardPointsEnoughToPayForOrder ??
          this.rewardPointsEnoughToPayForOrder,
      useRewardPoints: useRewardPoints ?? this.useRewardPoints,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'payment_methods': paymentMethods?.map((x) => x.toMap()).toList(),
      'display_reward_points': displayRewardPoints,
      'reward_points_balance': rewardPointsBalance,
      'reward_points_amount': rewardPointsAmount,
      'reward_points_enough_to_pay_for_order': rewardPointsEnoughToPayForOrder,
      'use_reward_points': useRewardPoints,
    };
  }

  factory Model.fromMap(Map<String, dynamic> map) {
    return Model(
      paymentMethods: map['payment_methods'] != null
          ? List<PaymentMethod>.from(
              map['payment_methods']?.map((x) => PaymentMethod.fromMap(x)))
          : null,
      displayRewardPoints: map['display_reward_points'],
      rewardPointsBalance: map['reward_points_balance']?.toInt(),
      rewardPointsAmount: map['reward_points_amount'],
      rewardPointsEnoughToPayForOrder:
          map['reward_points_enough_to_pay_for_order'],
      useRewardPoints: map['use_reward_points'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Model.fromJson(String source) => Model.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Model(payment_methods: $paymentMethods, display_reward_points: $displayRewardPoints, reward_points_balance: $rewardPointsBalance, reward_points_amount: $rewardPointsAmount, reward_points_enough_to_pay_for_order: $rewardPointsEnoughToPayForOrder, use_reward_points: $useRewardPoints)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Model &&
        listEquals(other.paymentMethods, paymentMethods) &&
        other.displayRewardPoints == displayRewardPoints &&
        other.rewardPointsBalance == rewardPointsBalance &&
        other.rewardPointsAmount == rewardPointsAmount &&
        other.rewardPointsEnoughToPayForOrder ==
            rewardPointsEnoughToPayForOrder &&
        other.useRewardPoints == useRewardPoints;
  }

  @override
  int get hashCode {
    return paymentMethods.hashCode ^
        displayRewardPoints.hashCode ^
        rewardPointsBalance.hashCode ^
        rewardPointsAmount.hashCode ^
        rewardPointsEnoughToPayForOrder.hashCode ^
        useRewardPoints.hashCode;
  }
}

class PaymentMethod {
  String? paymentMethodSystemName;
  String? name;
  String? description;
  dynamic fee;
  bool? selected;
  String? logoUrl;
  PaymentMethod({
    this.paymentMethodSystemName,
    this.name,
    this.description,
    required this.fee,
    this.selected,
    this.logoUrl,
  });

  PaymentMethod copyWith({
    String? paymentMethodSystemName,
    String? name,
    String? description,
    dynamic fee,
    bool? selected,
    String? logoUrl,
  }) {
    return PaymentMethod(
      paymentMethodSystemName:
          paymentMethodSystemName ?? this.paymentMethodSystemName,
      name: name ?? this.name,
      description: description ?? this.description,
      fee: fee ?? this.fee,
      selected: selected ?? this.selected,
      logoUrl: logoUrl ?? this.logoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'payment_method_system_name': paymentMethodSystemName,
      'name': name,
      'description': description,
      'fee': fee,
      'selected': selected,
      'logo_url': logoUrl,
    };
  }

  factory PaymentMethod.fromMap(Map<String, dynamic> map) {
    return PaymentMethod(
      paymentMethodSystemName: map['payment_method_system_name'],
      name: map['name'],
      description: map['description'],
      fee: map['fee'],
      selected: map['selected'],
      logoUrl: map['logo_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethod.fromJson(String source) =>
      PaymentMethod.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PaymentMethod(payment_method_system_name: $paymentMethodSystemName, name: $name, description: $description, fee: $fee, selected: $selected, logo_url: $logoUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentMethod &&
        other.paymentMethodSystemName == paymentMethodSystemName &&
        other.name == name &&
        other.description == description &&
        other.fee == fee &&
        other.selected == selected &&
        other.logoUrl == logoUrl;
  }

  @override
  int get hashCode {
    return paymentMethodSystemName.hashCode ^
        name.hashCode ^
        description.hashCode ^
        fee.hashCode ^
        selected.hashCode ^
        logoUrl.hashCode;
  }
}
