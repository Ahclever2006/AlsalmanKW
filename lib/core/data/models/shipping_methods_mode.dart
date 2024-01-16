import 'dart:convert';

import 'package:flutter/foundation.dart';

class ShippingMethodsModel {
  Model? model;
  dynamic redirectToMethod;
  dynamic id;
  ShippingMethodsModel({
    this.model,
    required this.redirectToMethod,
    required this.id,
  });

  ShippingMethodsModel copyWith({
    Model? model,
    dynamic redirectToMethod,
    dynamic id,
  }) {
    return ShippingMethodsModel(
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

  factory ShippingMethodsModel.fromMap(Map<String, dynamic> map) {
    return ShippingMethodsModel(
      model: map['model'] != null ? Model.fromMap(map['model']) : null,
      redirectToMethod: map['redirect_to_method'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ShippingMethodsModel.fromJson(String source) =>
      ShippingMethodsModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ShippingMethodsModel(model: $model, redirect_to_method: $redirectToMethod, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShippingMethodsModel &&
        other.model == model &&
        other.redirectToMethod == redirectToMethod &&
        other.id == id;
  }

  @override
  int get hashCode => model.hashCode ^ redirectToMethod.hashCode ^ id.hashCode;
}

class Model {
  List<ShippingMethod>? shippingMethods;
  bool? notifyCustomerAboutShippingFromMultipleLocations;
  List<dynamic>? warnings;
  bool? displayPickupInStore;
  dynamic pickupPointsModel;
  Model({
    this.shippingMethods,
    this.notifyCustomerAboutShippingFromMultipleLocations,
    this.warnings,
    this.displayPickupInStore,
    required this.pickupPointsModel,
  });

  Model copyWith({
    List<ShippingMethod>? shippingMethods,
    bool? notifyCustomerAboutShippingFromMultipleLocations,
    List<dynamic>? warnings,
    bool? displayPickupInStore,
    dynamic pickupPointsModel,
  }) {
    return Model(
      shippingMethods: shippingMethods ?? this.shippingMethods,
      notifyCustomerAboutShippingFromMultipleLocations:
          notifyCustomerAboutShippingFromMultipleLocations ??
              this.notifyCustomerAboutShippingFromMultipleLocations,
      warnings: warnings ?? this.warnings,
      displayPickupInStore: displayPickupInStore ?? this.displayPickupInStore,
      pickupPointsModel: pickupPointsModel ?? this.pickupPointsModel,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shipping_methods': shippingMethods?.map((x) => x.toMap()).toList(),
      'notify_customer_about_shipping_from_multiple_locations':
          notifyCustomerAboutShippingFromMultipleLocations,
      'warnings': warnings,
      'display_pickup_in_store': displayPickupInStore,
      'pickup_points_model': pickupPointsModel,
    };
  }

  factory Model.fromMap(Map<String, dynamic> map) {
    return Model(
      shippingMethods: map['shipping_methods'] != null
          ? List<ShippingMethod>.from(
              map['shipping_methods']?.map((x) => ShippingMethod.fromMap(x)))
          : null,
      notifyCustomerAboutShippingFromMultipleLocations:
          map['notify_customer_about_shipping_from_multiple_locations'],
      warnings: List<dynamic>.from(map['warnings']),
      displayPickupInStore: map['display_pickup_in_store'],
      pickupPointsModel: map['pickup_points_model'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Model.fromJson(String source) => Model.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Model(shipping_methods: $shippingMethods, notify_customer_about_shipping_from_multiple_locations: $notifyCustomerAboutShippingFromMultipleLocations, warnings: $warnings, display_pickup_in_store: $displayPickupInStore, pickup_points_model: $pickupPointsModel)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Model &&
        listEquals(other.shippingMethods, shippingMethods) &&
        other.notifyCustomerAboutShippingFromMultipleLocations ==
            notifyCustomerAboutShippingFromMultipleLocations &&
        listEquals(other.warnings, warnings) &&
        other.displayPickupInStore == displayPickupInStore &&
        other.pickupPointsModel == pickupPointsModel;
  }

  @override
  int get hashCode {
    return shippingMethods.hashCode ^
        notifyCustomerAboutShippingFromMultipleLocations.hashCode ^
        warnings.hashCode ^
        displayPickupInStore.hashCode ^
        pickupPointsModel.hashCode;
  }
}

class ShippingMethod {
  String? shippingRateComputationMethodSystemName;
  String? name;
  String? description;
  String? fee;
  bool? selected;
  ShippingOption? shippingOption;
  ShippingMethod({
    this.shippingRateComputationMethodSystemName,
    this.name,
    this.description,
    this.fee,
    this.selected,
    this.shippingOption,
  });

  ShippingMethod copyWith({
    String? shippingRateComputationMethodSystemName,
    String? name,
    String? description,
    String? fee,
    bool? selected,
    ShippingOption? shippingOption,
  }) {
    return ShippingMethod(
      shippingRateComputationMethodSystemName:
          shippingRateComputationMethodSystemName ??
              this.shippingRateComputationMethodSystemName,
      name: name ?? this.name,
      description: description ?? this.description,
      fee: fee ?? this.fee,
      selected: selected ?? this.selected,
      shippingOption: shippingOption ?? this.shippingOption,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shipping_rate_computation_method_system_name':
          shippingRateComputationMethodSystemName,
      'name': name,
      'description': description,
      'fee': fee,
      'selected': selected,
      'shipping_option': shippingOption?.toMap(),
    };
  }

  factory ShippingMethod.fromMap(Map<String, dynamic> map) {
    return ShippingMethod(
      shippingRateComputationMethodSystemName:
          map['shipping_rate_computation_method_system_name'],
      name: map['name'],
      description: map['description'],
      fee: map['fee'],
      selected: map['selected'],
      shippingOption: map['shipping_option'] != null
          ? ShippingOption.fromMap(map['shipping_option'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShippingMethod.fromJson(String source) =>
      ShippingMethod.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShippingMethod(shipping_rate_computation_method_system_name: $shippingRateComputationMethodSystemName, name: $name, description: $description, fee: $fee, selected: $selected, shipping_option: $shippingOption)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShippingMethod &&
        other.shippingRateComputationMethodSystemName ==
            shippingRateComputationMethodSystemName &&
        other.name == name &&
        other.description == description &&
        other.fee == fee &&
        other.selected == selected &&
        other.shippingOption == shippingOption;
  }

  @override
  int get hashCode {
    return shippingRateComputationMethodSystemName.hashCode ^
        name.hashCode ^
        description.hashCode ^
        fee.hashCode ^
        selected.hashCode ^
        shippingOption.hashCode;
  }
}

class ShippingOption {
  String? shippingRateComputationMethodSystemName;
  num? rate;
  String? name;
  String? description;
  dynamic transitDays;
  bool? isPickupInStore;
  ShippingOption({
    this.shippingRateComputationMethodSystemName,
    this.rate,
    this.name,
    this.description,
    required this.transitDays,
    this.isPickupInStore,
  });

  ShippingOption copyWith({
    String? shippingRateComputationMethodSystemName,
    num? rate,
    String? name,
    String? description,
    dynamic transitDays,
    bool? isPickupInStore,
  }) {
    return ShippingOption(
      shippingRateComputationMethodSystemName:
          shippingRateComputationMethodSystemName ??
              this.shippingRateComputationMethodSystemName,
      rate: rate ?? this.rate,
      name: name ?? this.name,
      description: description ?? this.description,
      transitDays: transitDays ?? this.transitDays,
      isPickupInStore: isPickupInStore ?? this.isPickupInStore,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shipping_rate_computation_method_system_name':
          shippingRateComputationMethodSystemName,
      'rate': rate,
      'name': name,
      'description': description,
      'transit_days': transitDays,
      'is_pickup_in_store': isPickupInStore,
    };
  }

  factory ShippingOption.fromMap(Map<String, dynamic> map) {
    return ShippingOption(
      shippingRateComputationMethodSystemName:
          map['shipping_rate_computation_method_system_name'],
      rate: map['rate'],
      name: map['name'],
      description: map['description'],
      transitDays: map['transit_days'],
      isPickupInStore: map['is_pickup_in_store'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ShippingOption.fromJson(String source) =>
      ShippingOption.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShippingOption(shipping_rate_computation_method_system_name: $shippingRateComputationMethodSystemName, rate: $rate, name: $name, description: $description, transit_days: $transitDays, is_pickup_in_store: $isPickupInStore)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShippingOption &&
        other.shippingRateComputationMethodSystemName ==
            shippingRateComputationMethodSystemName &&
        other.rate == rate &&
        other.name == name &&
        other.description == description &&
        other.transitDays == transitDays &&
        other.isPickupInStore == isPickupInStore;
  }

  @override
  int get hashCode {
    return shippingRateComputationMethodSystemName.hashCode ^
        rate.hashCode ^
        name.hashCode ^
        description.hashCode ^
        transitDays.hashCode ^
        isPickupInStore.hashCode;
  }
}
