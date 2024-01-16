import 'dart:convert';

import 'package:flutter/foundation.dart';

class CombinationAttributesModel {
  final List<AttributeValue>? attributes;
  final bool? inStock;
  final int? pictureId;
  CombinationAttributesModel({
    this.attributes,
    this.inStock,
    this.pictureId,
  });

  CombinationAttributesModel copyWith({
    List<AttributeValue>? attributes,
    bool? inStock,
    int? pictureId,
  }) {
    return CombinationAttributesModel(
      attributes: attributes ?? this.attributes,
      inStock: inStock ?? this.inStock,
      pictureId: pictureId ?? this.pictureId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'attributes': attributes?.map((x) => x.toMap()).toList(),
      'inStock': inStock,
      'pictureId': pictureId,
    };
  }

  factory CombinationAttributesModel.fromMap(Map<String, dynamic> map) {
    return CombinationAttributesModel(
      attributes: map['attributes'] != null
          ? List<AttributeValue>.from(
              map['attributes']?.map((x) => AttributeValue.fromMap(x)))
          : null,
      inStock: map['inStock'],
      pictureId: map['pictureId']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CombinationAttributesModel.fromJson(String source) =>
      CombinationAttributesModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'CombinationAttributesModel(attributes: $attributes, inStock: $inStock, pictureId: $pictureId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CombinationAttributesModel &&
        listEquals(other.attributes, attributes) &&
        other.inStock == inStock &&
        other.pictureId == pictureId;
  }

  @override
  int get hashCode =>
      attributes.hashCode ^ inStock.hashCode ^ pictureId.hashCode;
}

class AttributeValue {
  final List<int>? valueIds;
  final int? id;
  AttributeValue({
    this.valueIds,
    this.id,
  });

  AttributeValue copyWith({
    List<int>? valueIds,
    int? id,
  }) {
    return AttributeValue(
      valueIds: valueIds ?? this.valueIds,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'valueIds': valueIds,
      'id': id,
    };
  }

  factory AttributeValue.fromMap(Map<String, dynamic> map) {
    return AttributeValue(
      valueIds: List<int>.from(map['valueIds']),
      id: map['id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AttributeValue.fromJson(String source) =>
      AttributeValue.fromMap(json.decode(source));

  @override
  String toString() => 'AttributeValue(valueIds: $valueIds, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AttributeValue &&
        listEquals(other.valueIds, valueIds) &&
        other.id == id;
  }

  @override
  int get hashCode => valueIds.hashCode ^ id.hashCode;
}
