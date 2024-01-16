import 'dart:convert';

import 'package:flutter/foundation.dart';

class HomePageCategoriesModel {
  List<CategoryModel>? data;
  int? statusCode;
  String? message;
  bool? isSuccess;
  List<dynamic>? errors;
  HomePageCategoriesModel({
    this.data,
    this.statusCode,
    this.message,
    this.isSuccess,
    this.errors,
  });

  HomePageCategoriesModel copyWith({
    List<CategoryModel>? data,
    int? statusCode,
    String? message,
    bool? isSuccess,
    List<dynamic>? errors,
  }) {
    return HomePageCategoriesModel(
      data: data ?? this.data,
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      isSuccess: isSuccess ?? this.isSuccess,
      errors: errors ?? this.errors,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Data': data?.map((x) => x.toMap()).toList(),
      'StatusCode': statusCode,
      'Message': message,
      'IsSuccess': isSuccess,
      'Errors': errors,
    };
  }

  factory HomePageCategoriesModel.fromMap(Map<String, dynamic> map) {
    return HomePageCategoriesModel(
      data: map['Data'] != null
          ? List<CategoryModel>.from(
              map['Data']?.map((x) => CategoryModel.fromMap(x)))
          : null,
      statusCode: map['StatusCode']?.toInt(),
      message: map['Message'],
      isSuccess: map['IsSuccess'],
      errors: List<dynamic>.from(map['Errors']),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomePageCategoriesModel.fromJson(String source) =>
      HomePageCategoriesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HomePageCategoriesModel(Data: $data, StatusCode: $statusCode, Message: $message, IsSuccess: $isSuccess, Errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomePageCategoriesModel &&
        listEquals(other.data, data) &&
        other.statusCode == statusCode &&
        other.message == message &&
        other.isSuccess == isSuccess &&
        listEquals(other.errors, errors);
  }

  @override
  int get hashCode {
    return data.hashCode ^
        statusCode.hashCode ^
        message.hashCode ^
        isSuccess.hashCode ^
        errors.hashCode;
  }
}

class CategoryModel {
  String? name;
  dynamic description;
  dynamic metaKeywords;
  dynamic metaDescription;
  dynamic metaTitle;
  String? seName;
  PictureModel? pictureModel;
  bool? displayCategoryBreadcrumb;
  dynamic categoryBreadcrumb;
  dynamic subCategories;
  dynamic featuredProducts;
  dynamic catalogProductsModel;
  int? id;
  CategoryModel({
    this.name,
    this.description,
    this.metaKeywords,
    this.metaDescription,
    this.metaTitle,
    this.seName,
    this.pictureModel,
    this.displayCategoryBreadcrumb,
    this.categoryBreadcrumb,
    this.subCategories,
    this.featuredProducts,
    this.catalogProductsModel,
    this.id,
  });

  CategoryModel copyWith({
    String? name,
    dynamic description,
    dynamic metaKeywords,
    dynamic metaDescription,
    dynamic metaTitle,
    String? seName,
    PictureModel? pictureModel,
    bool? displayCategoryBreadcrumb,
    dynamic categoryBreadcrumb,
    dynamic subCategories,
    dynamic featuredProducts,
    dynamic catalogProductsModel,
    int? id,
  }) {
    return CategoryModel(
      name: name ?? this.name,
      description: description ?? this.description,
      metaKeywords: metaKeywords ?? this.metaKeywords,
      metaDescription: metaDescription ?? this.metaDescription,
      metaTitle: metaTitle ?? this.metaTitle,
      seName: seName ?? this.seName,
      pictureModel: pictureModel ?? this.pictureModel,
      displayCategoryBreadcrumb:
          displayCategoryBreadcrumb ?? this.displayCategoryBreadcrumb,
      categoryBreadcrumb: categoryBreadcrumb ?? this.categoryBreadcrumb,
      subCategories: subCategories ?? this.subCategories,
      featuredProducts: featuredProducts ?? this.featuredProducts,
      catalogProductsModel: catalogProductsModel ?? this.catalogProductsModel,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'Description': description,
      'MetaKeywords': metaKeywords,
      'MetaDescription': metaDescription,
      'MetaTitle': metaTitle,
      'SeName': seName,
      'PictureModel': pictureModel?.toMap(),
      'DisplayCategoryBreadcrumb': displayCategoryBreadcrumb,
      'CategoryBreadcrumb': categoryBreadcrumb,
      'SubCategories': subCategories,
      'FeaturedProducts': featuredProducts,
      'CatalogProductsModel': catalogProductsModel,
      'Id': id,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map['Name'],
      description: map['Description'],
      metaKeywords: map['MetaKeywords'],
      metaDescription: map['MetaDescription'],
      metaTitle: map['MetaTitle'],
      seName: map['SeName'],
      pictureModel: map['PictureModel'] != null
          ? PictureModel.fromMap(map['PictureModel'])
          : null,
      displayCategoryBreadcrumb: map['DisplayCategoryBreadcrumb'],
      categoryBreadcrumb: map['CategoryBreadcrumb'],
      subCategories: map['SubCategories'],
      featuredProducts: map['FeaturedProducts'],
      catalogProductsModel: map['CatalogProductsModel'],
      id: map['Id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Data(Name: $name, Description: $description, MetaKeywords: $metaKeywords, MetaDescription: $metaDescription, MetaTitle: $metaTitle, SeName: $seName, PictureModel: $pictureModel, DisplayCategoryBreadcrumb: $displayCategoryBreadcrumb, CategoryBreadcrumb: $categoryBreadcrumb, SubCategories: $subCategories, FeaturedProducts: $featuredProducts, CatalogProductsModel: $catalogProductsModel, Id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryModel &&
        other.name == name &&
        other.description == description &&
        other.metaKeywords == metaKeywords &&
        other.metaDescription == metaDescription &&
        other.metaTitle == metaTitle &&
        other.seName == seName &&
        other.pictureModel == pictureModel &&
        other.displayCategoryBreadcrumb == displayCategoryBreadcrumb &&
        other.categoryBreadcrumb == categoryBreadcrumb &&
        other.subCategories == subCategories &&
        other.featuredProducts == featuredProducts &&
        other.catalogProductsModel == catalogProductsModel &&
        other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        metaKeywords.hashCode ^
        metaDescription.hashCode ^
        metaTitle.hashCode ^
        seName.hashCode ^
        pictureModel.hashCode ^
        displayCategoryBreadcrumb.hashCode ^
        categoryBreadcrumb.hashCode ^
        subCategories.hashCode ^
        featuredProducts.hashCode ^
        catalogProductsModel.hashCode ^
        id.hashCode;
  }
}

class PictureModel {
  String? imageUrl;
  dynamic thumbImageUrl;
  String? fullSizeImageUrl;
  String? title;
  String? alternateText;
  PictureModel({
    this.imageUrl,
    required this.thumbImageUrl,
    this.fullSizeImageUrl,
    this.title,
    this.alternateText,
  });

  PictureModel copyWith({
    String? imageUrl,
    dynamic thumbImageUrl,
    String? fullSizeImageUrl,
    String? title,
    String? alternateText,
  }) {
    return PictureModel(
      imageUrl: imageUrl ?? this.imageUrl,
      thumbImageUrl: thumbImageUrl ?? this.thumbImageUrl,
      fullSizeImageUrl: fullSizeImageUrl ?? this.fullSizeImageUrl,
      title: title ?? this.title,
      alternateText: alternateText ?? this.alternateText,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ImageUrl': imageUrl,
      'ThumbImageUrl': thumbImageUrl,
      'FullSizeImageUrl': fullSizeImageUrl,
      'Title': title,
      'AlternateText': alternateText,
    };
  }

  factory PictureModel.fromMap(Map<String, dynamic> map) {
    return PictureModel(
      imageUrl: map['ImageUrl'],
      thumbImageUrl: map['ThumbImageUrl'],
      fullSizeImageUrl: map['FullSizeImageUrl'],
      title: map['Title'],
      alternateText: map['AlternateText'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PictureModel.fromJson(String source) =>
      PictureModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PictureModel(ImageUrl: $imageUrl, ThumbImageUrl: $thumbImageUrl, FullSizeImageUrl: $fullSizeImageUrl, Title: $title, AlternateText: $alternateText)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PictureModel &&
        other.imageUrl == imageUrl &&
        other.thumbImageUrl == thumbImageUrl &&
        other.fullSizeImageUrl == fullSizeImageUrl &&
        other.title == title &&
        other.alternateText == alternateText;
  }

  @override
  int get hashCode {
    return imageUrl.hashCode ^
        thumbImageUrl.hashCode ^
        fullSizeImageUrl.hashCode ^
        title.hashCode ^
        alternateText.hashCode;
  }
}
