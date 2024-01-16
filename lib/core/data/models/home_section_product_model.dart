import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'home_categ_model.dart';

class HomeSectionProductModel {
  Data? data;
  int? statusCode;
  String? message;
  bool? isSuccess;
  List<String>? errors;
  HomeSectionProductModel({
    this.data,
    this.statusCode,
    this.message,
    this.isSuccess,
    this.errors,
  });

  HomeSectionProductModel copyWith({
    Data? data,
    int? statusCode,
    String? message,
    bool? isSuccess,
    List<String>? errors,
  }) {
    return HomeSectionProductModel(
      data: data ?? this.data,
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      isSuccess: isSuccess ?? this.isSuccess,
      errors: errors ?? this.errors,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Data': data?.toMap(),
      'StatusCode': statusCode,
      'Message': message,
      'IsSuccess': isSuccess,
      'Errors': errors,
    };
  }

  factory HomeSectionProductModel.fromMap(Map<String, dynamic> map) {
    return HomeSectionProductModel(
      data: map['Data'] != null ? Data.fromMap(map['Data']) : null,
      statusCode: map['StatusCode']?.toInt(),
      message: map['Message'],
      isSuccess: map['IsSuccess'],
      errors: List<String>.from(map['Errors']),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeSectionProductModel.fromJson(String source) =>
      HomeSectionProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HomeSectionProductModel(Data: $data, StatusCode: $statusCode, Message: $message, IsSuccess: $isSuccess, Errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeSectionProductModel &&
        other.data == data &&
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

class Data {
  List<SectionProductModel>? products;
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPages;
  bool? hasPreviousPage;
  bool? hasNextPage;
  Data({
    this.products,
    this.pageIndex,
    this.pageSize,
    this.totalCount,
    this.totalPages,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  Data copyWith({
    List<SectionProductModel>? products,
    int? pageIndex,
    int? pageSize,
    int? totalCount,
    int? totalPages,
    bool? hasPreviousPage,
    bool? hasNextPage,
  }) {
    return Data(
      products: products ?? this.products,
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
      totalCount: totalCount ?? this.totalCount,
      totalPages: totalPages ?? this.totalPages,
      hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Products': products?.map((x) => x.toMap()).toList(),
      'PageIndex': pageIndex,
      'PageSize': pageSize,
      'TotalCount': totalCount,
      'TotalPages': totalPages,
      'HasPreviousPage': hasPreviousPage,
      'HasNextPage': hasNextPage,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      products: map['Products'] != null
          ? List<SectionProductModel>.from(
              map['Products']?.map((x) => SectionProductModel.fromMap(x)))
          : null,
      pageIndex: map['PageIndex']?.toInt(),
      pageSize: map['PageSize']?.toInt(),
      totalCount: map['TotalCount']?.toInt(),
      totalPages: map['TotalPages']?.toInt(),
      hasPreviousPage: map['HasPreviousPage'],
      hasNextPage: map['HasNextPage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Data(Products: $products, PageIndex: $pageIndex, PageSize: $pageSize, TotalCount: $totalCount, TotalPages: $totalPages, HasPreviousPage: $hasPreviousPage, HasNextPage: $hasNextPage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Data &&
        listEquals(other.products, products) &&
        other.pageIndex == pageIndex &&
        other.pageSize == pageSize &&
        other.totalCount == totalCount &&
        other.totalPages == totalPages &&
        other.hasPreviousPage == hasPreviousPage &&
        other.hasNextPage == hasNextPage;
  }

  @override
  int get hashCode {
    return products.hashCode ^
        pageIndex.hashCode ^
        pageSize.hashCode ^
        totalCount.hashCode ^
        totalPages.hashCode ^
        hasPreviousPage.hashCode ^
        hasNextPage.hashCode;
  }
}

class SectionProductModel {
  int? id;
  String? name;
  String? shortDescription;
  String? fullDescription;
  String? seName;
  String? sku;
  String? productType;
  bool? isInWishlist;
  bool? isInShoppingCart;
  bool? hasRequiredAttribute;
  bool? isOutOfStock;
  bool? isSubscribedToBackInStock;
  num? discountPercentage;
  PictureModel? defaultPictureModel;
  ProductPrice? productPrice;
  VendorModel? vendor;
  List<Manufacturer>? productManufacturers;
  SectionProductModel({
    this.id,
    this.name,
    this.shortDescription,
    this.fullDescription,
    this.seName,
    this.sku,
    this.productType,
    this.isInWishlist,
    this.isInShoppingCart,
    this.hasRequiredAttribute,
    this.isOutOfStock,
    this.isSubscribedToBackInStock,
    this.discountPercentage,
    this.defaultPictureModel,
    this.productPrice,
    this.vendor,
    this.productManufacturers,
  });

  SectionProductModel copyWith({
    int? id,
    String? name,
    String? shortDescription,
    String? fullDescription,
    String? seName,
    String? sku,
    String? productType,
    bool? isInWishlist,
    bool? isInShoppingCart,
    bool? hasRequiredAttribute,
    bool? isOutOfStock,
    bool? isSubscribedToBackInStock,
    num? discountPercentage,
    PictureModel? defaultPictureModel,
    ProductPrice? productPrice,
    VendorModel? vendor,
    List<Manufacturer>? productManufacturers,
  }) {
    return SectionProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      shortDescription: shortDescription ?? this.shortDescription,
      fullDescription: fullDescription ?? this.fullDescription,
      seName: seName ?? this.seName,
      sku: sku ?? this.sku,
      productType: productType ?? this.productType,
      isInWishlist: isInWishlist ?? this.isInWishlist,
      isInShoppingCart: isInShoppingCart ?? this.isInShoppingCart,
      hasRequiredAttribute: hasRequiredAttribute ?? this.hasRequiredAttribute,
      isOutOfStock: isOutOfStock ?? this.isOutOfStock,
      isSubscribedToBackInStock:
          isSubscribedToBackInStock ?? this.isSubscribedToBackInStock,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      defaultPictureModel: defaultPictureModel ?? this.defaultPictureModel,
      productPrice: productPrice ?? this.productPrice,
      vendor: vendor ?? this.vendor,
      productManufacturers: productManufacturers ?? this.productManufacturers,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'shortDescription': shortDescription,
      'fullDescription': fullDescription,
      'seName': seName,
      'sku': sku,
      'productType': productType,
      'isInWishlist': isInWishlist,
      'isInShoppingCart': isInShoppingCart,
      'hasRequiredAttribute': hasRequiredAttribute,
      'isOutOfStock': isOutOfStock,
      'isSubscribedToBackInStock': isSubscribedToBackInStock,
      'discountPercentage': discountPercentage,
      'defaultPictureModel': defaultPictureModel?.toMap(),
      'productPrice': productPrice?.toMap(),
      'vendor': vendor?.toMap(),
      'productManufacturers':
          productManufacturers?.map((x) => x.toMap()).toList(),
    };
  }

  factory SectionProductModel.fromMap(Map<String, dynamic> map) {
    return SectionProductModel(
      id: map['id']?.toInt(),
      name: map['name'],
      shortDescription: map['shortDescription'],
      fullDescription: map['fullDescription'],
      seName: map['seName'],
      sku: map['sku'],
      productType: map['productType'],
      isInWishlist: map['isInWishlist'],
      isInShoppingCart: map['isInShoppingCart'],
      hasRequiredAttribute: map['hasRequiredAttribute'],
      isOutOfStock: map['isOutOfStock'],
      isSubscribedToBackInStock: map['isSubscribedToBackInStock'],
      discountPercentage: map['discountPercentage'],
      defaultPictureModel: map['defaultPictureModel'] != null
          ? PictureModel.fromMap(map['defaultPictureModel'])
          : null,
      productPrice: map['productPrice'] != null
          ? ProductPrice.fromMap(map['productPrice'])
          : null,
      vendor: map['vendor'] != null ? VendorModel.fromMap(map['vendor']) : null,
      productManufacturers: map['productManufacturers'] != null
          ? List<Manufacturer>.from(
              map['productManufacturers']?.map((x) => Manufacturer.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SectionProductModel.fromJson(String source) =>
      SectionProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SectionProductModel(id: $id, name: $name, shortDescription: $shortDescription, fullDescription: $fullDescription, seName: $seName, sku: $sku, productType: $productType, isInWishlist: $isInWishlist, isInShoppingCart: $isInShoppingCart, hasRequiredAttribute: $hasRequiredAttribute, isOutOfStock: $isOutOfStock, isSubscribedToBackInStock: $isSubscribedToBackInStock, discountPercentage: $discountPercentage, defaultPictureModel: $defaultPictureModel, productPrice: $productPrice, vendor: $vendor, productManufacturers: $productManufacturers)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SectionProductModel &&
        other.id == id &&
        other.name == name &&
        other.shortDescription == shortDescription &&
        other.fullDescription == fullDescription &&
        other.seName == seName &&
        other.sku == sku &&
        other.productType == productType &&
        other.isInWishlist == isInWishlist &&
        other.isInShoppingCart == isInShoppingCart &&
        other.hasRequiredAttribute == hasRequiredAttribute &&
        other.isOutOfStock == isOutOfStock &&
        other.isSubscribedToBackInStock == isSubscribedToBackInStock &&
        other.discountPercentage == discountPercentage &&
        other.defaultPictureModel == defaultPictureModel &&
        other.productPrice == productPrice &&
        other.vendor == vendor &&
        listEquals(other.productManufacturers, productManufacturers);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        shortDescription.hashCode ^
        fullDescription.hashCode ^
        seName.hashCode ^
        sku.hashCode ^
        productType.hashCode ^
        isInWishlist.hashCode ^
        isInShoppingCart.hashCode ^
        hasRequiredAttribute.hashCode ^
        isOutOfStock.hashCode ^
        isSubscribedToBackInStock.hashCode ^
        discountPercentage.hashCode ^
        defaultPictureModel.hashCode ^
        productPrice.hashCode ^
        vendor.hashCode ^
        productManufacturers.hashCode;
  }
}

class Manufacturer {
  final String? name;
  final String? seName;
  final bool? isActive;
  final int? id;
  Manufacturer({
    this.name,
    this.seName,
    this.isActive,
    this.id,
  });

  Manufacturer copyWith({
    String? name,
    String? seName,
    bool? isActive,
    int? id,
  }) {
    return Manufacturer(
      name: name ?? this.name,
      seName: seName ?? this.seName,
      isActive: isActive ?? this.isActive,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'seName': seName,
      'isActive': isActive,
      'id': id,
    };
  }

  factory Manufacturer.fromMap(Map<String, dynamic> map) {
    return Manufacturer(
      name: map['name'],
      seName: map['seName'],
      isActive: map['isActive'],
      id: map['id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Manufacturer.fromJson(String source) =>
      Manufacturer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Manufacturer(name: $name, seName: $seName, isActive: $isActive, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Manufacturer &&
        other.name == name &&
        other.seName == seName &&
        other.isActive == isActive &&
        other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^ seName.hashCode ^ isActive.hashCode ^ id.hashCode;
  }
}

class VendorModel {
  final int? id;
  final String? name;
  VendorModel({
    this.id,
    this.name,
  });

  VendorModel copyWith({
    int? id,
    String? name,
  }) {
    return VendorModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Name': name,
    };
  }

  factory VendorModel.fromMap(Map<String, dynamic> map) {
    return VendorModel(
      id: map['Id']?.toInt(),
      name: map['Name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VendorModel.fromJson(String source) =>
      VendorModel.fromMap(json.decode(source));

  @override
  String toString() => 'VendorModel(Id: $id, Name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VendorModel && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class ProductPrice {
  String? oldPrice;
  String? price;
  num? priceValue;
  bool? disableBuyButton;
  ProductPrice({
    this.oldPrice,
    this.price,
    this.priceValue,
    this.disableBuyButton,
  });

  ProductPrice copyWith({
    String? oldPrice,
    String? price,
    num? priceValue,
    bool? disableBuyButton,
  }) {
    return ProductPrice(
      oldPrice: oldPrice ?? this.oldPrice,
      price: price ?? this.price,
      priceValue: priceValue ?? this.priceValue,
      disableBuyButton: disableBuyButton ?? this.disableBuyButton,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'OldPrice': oldPrice,
      'Price': price,
      'PriceValue': priceValue,
      'DisableBuyButton': disableBuyButton,
    };
  }

  factory ProductPrice.fromMap(Map<String, dynamic> map) {
    return ProductPrice(
      oldPrice: map['OldPrice'],
      price: map['Price'],
      priceValue: map['PriceValue'],
      disableBuyButton: map['DisableBuyButton'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductPrice.fromJson(String source) =>
      ProductPrice.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductPrice(OldPrice: $oldPrice, Price: $price, PriceValue: $priceValue, DisableBuyButton: $disableBuyButton)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductPrice &&
        other.oldPrice == oldPrice &&
        other.price == price &&
        other.priceValue == priceValue &&
        other.disableBuyButton == disableBuyButton;
  }

  @override
  int get hashCode {
    return oldPrice.hashCode ^
        price.hashCode ^
        priceValue.hashCode ^
        disableBuyButton.hashCode;
  }
}
