import 'dart:convert';

import 'package:flutter/foundation.dart';

class PaymentSummaryModel {
  dynamic paymentMethod;
  TotalsModel? totalsModel;
  PaymentSummaryModel({
    required this.paymentMethod,
    this.totalsModel,
  });

  PaymentSummaryModel copyWith({
    dynamic paymentMethod,
    TotalsModel? totalsModel,
  }) {
    return PaymentSummaryModel(
      paymentMethod: paymentMethod ?? this.paymentMethod,
      totalsModel: totalsModel ?? this.totalsModel,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'PaymentMethod': paymentMethod,
      'TotalsModel': totalsModel?.toMap(),
    };
  }

  factory PaymentSummaryModel.fromMap(Map<String, dynamic> map) {
    return PaymentSummaryModel(
      paymentMethod: map['PaymentMethod'],
      totalsModel: map['TotalsModel'] != null
          ? TotalsModel.fromMap(map['TotalsModel'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentSummaryModel.fromJson(String source) =>
      PaymentSummaryModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'PaymentSummaryModel(PaymentMethod: $paymentMethod, TotalsModel: $totalsModel)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentSummaryModel &&
        other.paymentMethod == paymentMethod &&
        other.totalsModel == totalsModel;
  }

  @override
  int get hashCode => paymentMethod.hashCode ^ totalsModel.hashCode;
}

class TotalsModel {
  bool? isEditable;
  String? subTotal;
  dynamic subTotalDiscount;
  String? shipping;
  bool? requiresShipping;
  dynamic selectedShippingMethod;
  bool? hideShippingTotal;
  dynamic paymentMethodAdditionalFee;
  String? tax;
  List<TaxRate>? taxRates;
  bool? displayTax;
  bool? displayTaxRates;
  List<dynamic>? giftCards;
  dynamic orderTotalDiscount;
  int? redeemedRewardPoints;
  dynamic redeemedRewardPointsAmount;
  int? willEarnRewardPoints;
  String? orderTotal;
  CustomProperties? customProperties;
  TotalsModel({
    this.isEditable,
    this.subTotal,
    required this.subTotalDiscount,
    this.shipping,
    this.requiresShipping,
    required this.selectedShippingMethod,
    this.hideShippingTotal,
    required this.paymentMethodAdditionalFee,
    this.tax,
    this.taxRates,
    this.displayTax,
    this.displayTaxRates,
    this.giftCards,
    required this.orderTotalDiscount,
    this.redeemedRewardPoints,
    required this.redeemedRewardPointsAmount,
    this.willEarnRewardPoints,
    this.orderTotal,
    this.customProperties,
  });

  TotalsModel copyWith({
    bool? isEditable,
    String? subTotal,
    dynamic subTotalDiscount,
    String? shipping,
    bool? requiresShipping,
    dynamic selectedShippingMethod,
    bool? hideShippingTotal,
    dynamic paymentMethodAdditionalFee,
    String? tax,
    List<TaxRate>? taxRates,
    bool? displayTax,
    bool? displayTaxRates,
    List<dynamic>? giftCards,
    dynamic orderTotalDiscount,
    int? redeemedRewardPoints,
    dynamic redeemedRewardPointsAmount,
    int? willEarnRewardPoints,
    String? orderTotal,
    CustomProperties? customProperties,
  }) {
    return TotalsModel(
      isEditable: isEditable ?? this.isEditable,
      subTotal: subTotal ?? this.subTotal,
      subTotalDiscount: subTotalDiscount ?? this.subTotalDiscount,
      shipping: shipping ?? this.shipping,
      requiresShipping: requiresShipping ?? this.requiresShipping,
      selectedShippingMethod:
          selectedShippingMethod ?? this.selectedShippingMethod,
      hideShippingTotal: hideShippingTotal ?? this.hideShippingTotal,
      paymentMethodAdditionalFee:
          paymentMethodAdditionalFee ?? this.paymentMethodAdditionalFee,
      tax: tax ?? this.tax,
      taxRates: taxRates ?? this.taxRates,
      displayTax: displayTax ?? this.displayTax,
      displayTaxRates: displayTaxRates ?? this.displayTaxRates,
      giftCards: giftCards ?? this.giftCards,
      orderTotalDiscount: orderTotalDiscount ?? this.orderTotalDiscount,
      redeemedRewardPoints: redeemedRewardPoints ?? this.redeemedRewardPoints,
      redeemedRewardPointsAmount:
          redeemedRewardPointsAmount ?? this.redeemedRewardPointsAmount,
      willEarnRewardPoints: willEarnRewardPoints ?? this.willEarnRewardPoints,
      orderTotal: orderTotal ?? this.orderTotal,
      customProperties: customProperties ?? this.customProperties,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'IsEditable': isEditable,
      'SubTotal': subTotal,
      'SubTotalDiscount': subTotalDiscount,
      'Shipping': shipping,
      'RequiresShipping': requiresShipping,
      'SelectedShippingMethod': selectedShippingMethod,
      'HideShippingTotal': hideShippingTotal,
      'PaymentMethodAdditionalFee': paymentMethodAdditionalFee,
      'Tax': tax,
      'TaxRates': taxRates?.map((x) => x.toMap()).toList(),
      'DisplayTax': displayTax,
      'DisplayTaxRates': displayTaxRates,
      'GiftCards': giftCards,
      'OrderTotalDiscount': orderTotalDiscount,
      'RedeemedRewardPoints': redeemedRewardPoints,
      'RedeemedRewardPointsAmount': redeemedRewardPointsAmount,
      'WillEarnRewardPoints': willEarnRewardPoints,
      'OrderTotal': orderTotal,
      'CustomProperties': customProperties?.toMap(),
    };
  }

  factory TotalsModel.fromMap(Map<String, dynamic> map) {
    return TotalsModel(
      isEditable: map['IsEditable'],
      subTotal: map['SubTotal'],
      subTotalDiscount: map['SubTotalDiscount'],
      shipping: map['Shipping'],
      requiresShipping: map['RequiresShipping'],
      selectedShippingMethod: map['SelectedShippingMethod'],
      hideShippingTotal: map['HideShippingTotal'],
      paymentMethodAdditionalFee: map['PaymentMethodAdditionalFee'],
      tax: map['Tax'],
      taxRates: map['TaxRates'] != null
          ? List<TaxRate>.from(map['TaxRates']?.map((x) => TaxRate.fromMap(x)))
          : null,
      displayTax: map['DisplayTax'],
      displayTaxRates: map['DisplayTaxRates'],
      giftCards: List<dynamic>.from(map['GiftCards']),
      orderTotalDiscount: map['OrderTotalDiscount'],
      redeemedRewardPoints: map['RedeemedRewardPoints']?.toInt(),
      redeemedRewardPointsAmount: map['RedeemedRewardPointsAmount'],
      willEarnRewardPoints: map['WillEarnRewardPoints']?.toInt(),
      orderTotal: map['OrderTotal'],
      customProperties: map['CustomProperties'] != null
          ? CustomProperties.fromMap(map['CustomProperties'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TotalsModel.fromJson(String source) =>
      TotalsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TotalsModel(isEditable: $isEditable, subTotal: $subTotal, subTotalDiscount: $subTotalDiscount, shipping: $shipping, requiresShipping: $requiresShipping, selectedShippingMethod: $selectedShippingMethod, hideShippingTotal: $hideShippingTotal, paymentMethodAdditionalFee: $paymentMethodAdditionalFee, tax: $tax, taxRates: $taxRates, displayTax: $displayTax, displayTaxRates: $displayTaxRates, giftCards: $giftCards, orderTotalDiscount: $orderTotalDiscount, redeemedRewardPoints: $redeemedRewardPoints, redeemedRewardPointsAmount: $redeemedRewardPointsAmount, willEarnRewardPoints: $willEarnRewardPoints, orderTotal: $orderTotal, customProperties: $customProperties)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TotalsModel &&
        other.isEditable == isEditable &&
        other.subTotal == subTotal &&
        other.subTotalDiscount == subTotalDiscount &&
        other.shipping == shipping &&
        other.requiresShipping == requiresShipping &&
        other.selectedShippingMethod == selectedShippingMethod &&
        other.hideShippingTotal == hideShippingTotal &&
        other.paymentMethodAdditionalFee == paymentMethodAdditionalFee &&
        other.tax == tax &&
        listEquals(other.taxRates, taxRates) &&
        other.displayTax == displayTax &&
        other.displayTaxRates == displayTaxRates &&
        listEquals(other.giftCards, giftCards) &&
        other.orderTotalDiscount == orderTotalDiscount &&
        other.redeemedRewardPoints == redeemedRewardPoints &&
        other.redeemedRewardPointsAmount == redeemedRewardPointsAmount &&
        other.willEarnRewardPoints == willEarnRewardPoints &&
        other.orderTotal == orderTotal &&
        other.customProperties == customProperties;
  }

  @override
  int get hashCode {
    return isEditable.hashCode ^
        subTotal.hashCode ^
        subTotalDiscount.hashCode ^
        shipping.hashCode ^
        requiresShipping.hashCode ^
        selectedShippingMethod.hashCode ^
        hideShippingTotal.hashCode ^
        paymentMethodAdditionalFee.hashCode ^
        tax.hashCode ^
        taxRates.hashCode ^
        displayTax.hashCode ^
        displayTaxRates.hashCode ^
        giftCards.hashCode ^
        orderTotalDiscount.hashCode ^
        redeemedRewardPoints.hashCode ^
        redeemedRewardPointsAmount.hashCode ^
        willEarnRewardPoints.hashCode ^
        orderTotal.hashCode ^
        customProperties.hashCode;
  }
}

class TaxRate {
  String? rate;
  String? value;
  TaxRate({
    this.rate,
    this.value,
  });

  TaxRate copyWith({
    String? rate,
    String? value,
  }) {
    return TaxRate(
      rate: rate ?? this.rate,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Rate': rate,
      'Value': value,
    };
  }

  factory TaxRate.fromMap(Map<String, dynamic> map) {
    return TaxRate(
      rate: map['Rate'],
      value: map['Value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TaxRate.fromJson(String source) =>
      TaxRate.fromMap(json.decode(source));

  @override
  String toString() => 'TaxRate(Rate: $rate, Value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaxRate && other.rate == rate && other.value == value;
  }

  @override
  int get hashCode => rate.hashCode ^ value.hashCode;
}

class CustomProperties {
  final String? deductFromWallet;
  final bool? withdrawFromWallet;
  final bool? forceUseWalletCredit;
  final bool? useWalletCredit;
  final String? totalDiscount;
  final num? totalDiscountValue;
  CustomProperties({
    this.deductFromWallet,
    this.withdrawFromWallet,
    this.forceUseWalletCredit,
    this.useWalletCredit,
    this.totalDiscount,
    this.totalDiscountValue,
  });

  CustomProperties copyWith({
    String? deductFromWallet,
    bool? withdrawFromWallet,
    bool? forceUseWalletCredit,
    bool? useWalletCredit,
    String? totalDiscount,
    num? totalDiscountValue,
  }) {
    return CustomProperties(
      deductFromWallet: deductFromWallet ?? this.deductFromWallet,
      withdrawFromWallet: withdrawFromWallet ?? this.withdrawFromWallet,
      forceUseWalletCredit: forceUseWalletCredit ?? this.forceUseWalletCredit,
      useWalletCredit: useWalletCredit ?? this.useWalletCredit,
      totalDiscount: totalDiscount ?? this.totalDiscount,
      totalDiscountValue: totalDiscountValue ?? this.totalDiscountValue,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'DeductFromWallet': deductFromWallet,
      'WithdrawFromWallet': withdrawFromWallet,
      'ForceUseWalletCredit': forceUseWalletCredit,
      'UseWalletCredit': useWalletCredit,
      'TotalDiscount': totalDiscount,
      'TotalDiscountValue': totalDiscountValue,
    };
  }

  factory CustomProperties.fromMap(Map<String, dynamic> map) {
    return CustomProperties(
      deductFromWallet: map['DeductFromWallet'],
      withdrawFromWallet: map['WithdrawFromWallet'],
      forceUseWalletCredit: map['ForceUseWalletCredit'],
      useWalletCredit: map['UseWalletCredit'],
      totalDiscount: map['TotalDiscount'],
      totalDiscountValue: map['TotalDiscountValue'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomProperties.fromJson(String source) =>
      CustomProperties.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CustomProperties(DeductFromWallet: $deductFromWallet, WithdrawFromWallet: $withdrawFromWallet, ForceUseWalletCredit: $forceUseWalletCredit, UseWalletCredit: $useWalletCredit, TotalDiscount: $totalDiscount, TotalDiscountValue: $totalDiscountValue)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomProperties &&
        other.deductFromWallet == deductFromWallet &&
        other.withdrawFromWallet == withdrawFromWallet &&
        other.forceUseWalletCredit == forceUseWalletCredit &&
        other.useWalletCredit == useWalletCredit &&
        other.totalDiscount == totalDiscount &&
        other.totalDiscountValue == totalDiscountValue;
  }

  @override
  int get hashCode {
    return deductFromWallet.hashCode ^
        withdrawFromWallet.hashCode ^
        forceUseWalletCredit.hashCode ^
        useWalletCredit.hashCode ^
        totalDiscount.hashCode ^
        totalDiscountValue.hashCode;
  }
}
