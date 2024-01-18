import 'dart:convert';

import 'package:flutter/foundation.dart';

class ConfirmOrderModel {
  Model? model;
  dynamic redirectToMethod;
  dynamic id;
  ConfirmOrderModel({
    this.model,
    required this.redirectToMethod,
    required this.id,
  });

  ConfirmOrderModel copyWith({
    Model? model,
    dynamic redirectToMethod,
    dynamic id,
  }) {
    return ConfirmOrderModel(
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

  factory ConfirmOrderModel.fromMap(Map<String, dynamic> map) {
    return ConfirmOrderModel(
      model: map['model'] != null ? Model.fromMap(map['model']) : null,
      redirectToMethod: map['redirect_to_method'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ConfirmOrderModel.fromJson(String source) =>
      ConfirmOrderModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ConfirmOrderModel(model: $model, redirect_to_method: $redirectToMethod, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConfirmOrderModel &&
        other.model == model &&
        other.redirectToMethod == redirectToMethod &&
        other.id == id;
  }

  @override
  int get hashCode => model.hashCode ^ redirectToMethod.hashCode ^ id.hashCode;
}

class Model {
  bool? termsOfServiceOnOrderConfirmPage;
  bool? termsOfServicePopup;
  dynamic minOrderTotalWarning;
  List<String>? warnings;
  Model({
    this.termsOfServiceOnOrderConfirmPage,
    this.termsOfServicePopup,
    required this.minOrderTotalWarning,
    this.warnings,
  });

  Model copyWith({
    bool? termsOfServiceOnOrderConfirmPage,
    bool? termsOfServicePopup,
    dynamic minOrderTotalWarning,
    List<String>? warnings,
  }) {
    return Model(
      termsOfServiceOnOrderConfirmPage: termsOfServiceOnOrderConfirmPage ??
          this.termsOfServiceOnOrderConfirmPage,
      termsOfServicePopup: termsOfServicePopup ?? this.termsOfServicePopup,
      minOrderTotalWarning: minOrderTotalWarning ?? this.minOrderTotalWarning,
      warnings: warnings ?? this.warnings,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'terms_of_service_on_order_confirm_page':
          termsOfServiceOnOrderConfirmPage,
      'terms_of_service_popup': termsOfServicePopup,
      'min_order_total_warning': minOrderTotalWarning,
      'warnings': warnings,
    };
  }

  factory Model.fromMap(Map<String, dynamic> map) {
    return Model(
      termsOfServiceOnOrderConfirmPage:
          map['terms_of_service_on_order_confirm_page'],
      termsOfServicePopup: map['terms_of_service_popup'],
      minOrderTotalWarning: map['min_order_total_warning'],
      warnings: List<String>.from(map['warnings']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Model.fromJson(String source) => Model.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Model(terms_of_service_on_order_confirm_page: $termsOfServiceOnOrderConfirmPage, terms_of_service_popup: $termsOfServicePopup, min_order_total_warning: $minOrderTotalWarning, warnings: $warnings)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Model &&
        other.termsOfServiceOnOrderConfirmPage ==
            termsOfServiceOnOrderConfirmPage &&
        other.termsOfServicePopup == termsOfServicePopup &&
        other.minOrderTotalWarning == minOrderTotalWarning &&
        listEquals(other.warnings, warnings);
  }

  @override
  int get hashCode {
    return termsOfServiceOnOrderConfirmPage.hashCode ^
        termsOfServicePopup.hashCode ^
        minOrderTotalWarning.hashCode ^
        warnings.hashCode;
  }
}
