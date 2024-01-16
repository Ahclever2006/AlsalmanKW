import 'dart:convert';

import 'package:collection/collection.dart';

import 'catalog_products_model.dart';
import 'picture_model.dart';

class BrandModel {
  String? name;
  dynamic description;
  dynamic metaKeywords;
  dynamic metaDescription;
  dynamic metaTitle;
  String? seName;
  PictureModel? pictureModel;
  List<dynamic>? featuredProducts;
  CatalogProductsModel? catalogProductsModel;
  int? id;

  BrandModel({
    this.name,
    this.description,
    this.metaKeywords,
    this.metaDescription,
    this.metaTitle,
    this.seName,
    this.pictureModel,
    this.featuredProducts,
    this.catalogProductsModel,
    this.id,
  });

  @override
  String toString() {
    return 'BrandModel(name: $name, description: $description, metaKeywords: $metaKeywords, metaDescription: $metaDescription, metaTitle: $metaTitle, seName: $seName, pictureModel: $pictureModel, featuredProducts: $featuredProducts, catalogProductsModel: $catalogProductsModel, id: $id)';
  }

  factory BrandModel.fromMap(Map<String, dynamic> data) => BrandModel(
        name: data['name']?.toString(),
        description: data['description'],
        metaKeywords: data['meta_keywords'],
        metaDescription: data['meta_description'],
        metaTitle: data['meta_title'],
        seName: data['se_name']?.toString(),
        pictureModel: data['picture_model'] == null
            ? null
            : PictureModel.fromMap(
                Map<String, dynamic>.from(data['picture_model'])),
        featuredProducts: List<dynamic>.from(data['featured_products'] ?? []),
        catalogProductsModel: data['catalog_products_model'] == null
            ? null
            : CatalogProductsModel.fromMap(
                Map<String, dynamic>.from(data['catalog_products_model'])),
        id: int.tryParse(data['id'].toString()),
      );

  Map<String, dynamic> toMap() => {
        if (name != null) 'name': name,
        if (description != null) 'description': description,
        if (metaKeywords != null) 'meta_keywords': metaKeywords,
        if (metaDescription != null) 'meta_description': metaDescription,
        if (metaTitle != null) 'meta_title': metaTitle,
        if (seName != null) 'se_name': seName,
        if (pictureModel != null) 'picture_model': pictureModel?.toMap(),
        if (featuredProducts != null) 'featured_products': featuredProducts,
        if (catalogProductsModel != null)
          'catalog_products_model': catalogProductsModel?.toMap(),
        if (id != null) 'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BrandModel].
  factory BrandModel.fromJson(String data) {
    return BrandModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BrandModel] to a JSON string.
  String toJson() => json.encode(toMap());

  BrandModel copyWith({
    String? name,
    dynamic description,
    dynamic metaKeywords,
    dynamic metaDescription,
    dynamic metaTitle,
    String? seName,
    PictureModel? pictureModel,
    List<dynamic>? featuredProducts,
    CatalogProductsModel? catalogProductsModel,
    int? id,
  }) {
    return BrandModel(
      name: name ?? this.name,
      description: description ?? this.description,
      metaKeywords: metaKeywords ?? this.metaKeywords,
      metaDescription: metaDescription ?? this.metaDescription,
      metaTitle: metaTitle ?? this.metaTitle,
      seName: seName ?? this.seName,
      pictureModel: pictureModel ?? this.pictureModel,
      featuredProducts: featuredProducts ?? this.featuredProducts,
      catalogProductsModel: catalogProductsModel ?? this.catalogProductsModel,
      id: id ?? this.id,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! BrandModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      name.hashCode ^
      description.hashCode ^
      metaKeywords.hashCode ^
      metaDescription.hashCode ^
      metaTitle.hashCode ^
      seName.hashCode ^
      pictureModel.hashCode ^
      featuredProducts.hashCode ^
      catalogProductsModel.hashCode ^
      id.hashCode;
}
