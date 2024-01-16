import 'dart:convert';

class ConditionalAttributesModel {
  int? productAttributeMappingId;
  int? dependToProductAttributeMappingId;
  int? dependToOptionId;
  ConditionalAttributesModel({
    this.productAttributeMappingId,
    this.dependToProductAttributeMappingId,
    this.dependToOptionId,
  });

  ConditionalAttributesModel copyWith({
    int? productAttributeMappingId,
    int? dependToProductAttributeMappingId,
    int? dependToOptionId,
  }) {
    return ConditionalAttributesModel(
      productAttributeMappingId:
          productAttributeMappingId ?? this.productAttributeMappingId,
      dependToProductAttributeMappingId: dependToProductAttributeMappingId ??
          this.dependToProductAttributeMappingId,
      dependToOptionId: dependToOptionId ?? this.dependToOptionId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ProductAttributeMappingId': productAttributeMappingId,
      'DependToProductAttributeMappingId': dependToProductAttributeMappingId,
      'DependToOptionId': dependToOptionId,
    };
  }

  factory ConditionalAttributesModel.fromMap(Map<String, dynamic> map) {
    return ConditionalAttributesModel(
      productAttributeMappingId: map['ProductAttributeMappingId']?.toInt(),
      dependToProductAttributeMappingId:
          map['DependToProductAttributeMappingId']?.toInt(),
      dependToOptionId: map['DependToOptionId']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ConditionalAttributesModel.fromJson(String source) =>
      ConditionalAttributesModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ConditionalAttributesModel(ProductAttributeMappingId: $productAttributeMappingId, DependToProductAttributeMappingId: $dependToProductAttributeMappingId, DependToOptionId: $dependToOptionId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConditionalAttributesModel &&
        other.productAttributeMappingId == productAttributeMappingId &&
        other.dependToProductAttributeMappingId ==
            dependToProductAttributeMappingId &&
        other.dependToOptionId == dependToOptionId;
  }

  @override
  int get hashCode =>
      productAttributeMappingId.hashCode ^
      dependToProductAttributeMappingId.hashCode ^
      dependToOptionId.hashCode;
}
