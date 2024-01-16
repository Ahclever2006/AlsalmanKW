import 'dart:convert';

import 'package:flutter/foundation.dart';

class FilterAttribute {
  final int specificationAttributeId;
  final String name;
  final List<FilterAttributeValue> specificationAttributeOptions;
  FilterAttribute({
    required this.specificationAttributeId,
    required this.name,
    required this.specificationAttributeOptions,
  });

  FilterAttribute copyWith({
    int? specificationAttributeId,
    String? name,
    List<FilterAttributeValue>? specificationAttributeOptions,
  }) {
    return FilterAttribute(
      specificationAttributeId:
          specificationAttributeId ?? this.specificationAttributeId,
      name: name ?? this.name,
      specificationAttributeOptions:
          specificationAttributeOptions ?? this.specificationAttributeOptions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'SpecificationAttributeId': specificationAttributeId,
      'Name': name,
      'SpecificationAttributeOptions':
          specificationAttributeOptions.map((x) => x.toMap()).toList(),
    };
  }

  factory FilterAttribute.fromMap(Map<String, dynamic> map) {
    return FilterAttribute(
      specificationAttributeId: map['SpecificationAttributeId']?.toInt() ?? 0,
      name: map['Name'] ?? '',
      specificationAttributeOptions: List<FilterAttributeValue>.from(
          map['SpecificationAttributeOptions']
              ?.map((x) => FilterAttributeValue.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory FilterAttribute.fromJson(String source) =>
      FilterAttribute.fromMap(json.decode(source));

  @override
  String toString() =>
      'FilterAttribute(SpecificationAttributeId: $specificationAttributeId, Name: $name, SpecificationAttributeOptions: $specificationAttributeOptions)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FilterAttribute &&
        other.specificationAttributeId == specificationAttributeId &&
        other.name == name &&
        listEquals(
            other.specificationAttributeOptions, specificationAttributeOptions);
  }

  @override
  int get hashCode =>
      specificationAttributeId.hashCode ^
      name.hashCode ^
      specificationAttributeOptions.hashCode;
}

class FilterAttributeValue {
  final int? id;
  final int? specificationAttributeId;
  final String name;
  FilterAttributeValue({
    this.id,
    this.specificationAttributeId,
    required this.name,
  });

  FilterAttributeValue copyWith({
    int? id,
    int? specificationAttributeId,
    String? name,
  }) {
    return FilterAttributeValue(
      id: id ?? this.id,
      specificationAttributeId:
          specificationAttributeId ?? this.specificationAttributeId,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'SpecificationAttributeId': specificationAttributeId,
      'Name': name,
    };
  }

  factory FilterAttributeValue.fromMap(Map<String, dynamic> map) {
    return FilterAttributeValue(
      id: map['Id']?.toInt(),
      specificationAttributeId: map['SpecificationAttributeId']?.toInt(),
      name: map['Name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FilterAttributeValue.fromJson(String source) =>
      FilterAttributeValue.fromMap(json.decode(source));

  @override
  String toString() =>
      'FilterAttributeValue(Id: $id, SpecificationAttributeId: $specificationAttributeId, Name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FilterAttributeValue &&
        other.id == id &&
        other.specificationAttributeId == specificationAttributeId &&
        other.name == name;
  }

  @override
  int get hashCode =>
      id.hashCode ^ specificationAttributeId.hashCode ^ name.hashCode;
}
