import 'dart:convert';

import 'package:flutter/foundation.dart';

class JCarouselsModel {
  List<CarousalModel>? data;
  int? statusCode;
  String? message;
  bool? isSuccess;
  List<String>? errors;
  JCarouselsModel({
    this.data,
    this.statusCode,
    this.message,
    this.isSuccess,
    this.errors,
  });

  JCarouselsModel copyWith({
    List<CarousalModel>? data,
    int? statusCode,
    String? message,
    bool? isSuccess,
    List<String>? errors,
  }) {
    return JCarouselsModel(
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

  factory JCarouselsModel.fromMap(Map<String, dynamic> map) {
    return JCarouselsModel(
      data: map['Data'] != null
          ? List<CarousalModel>.from(
              map['Data']?.map((x) => CarousalModel.fromMap(x)))
          : null,
      statusCode: map['StatusCode']?.toInt(),
      message: map['Message'],
      isSuccess: map['IsSuccess'],
      errors: List<String>.from(map['Errors']),
    );
  }

  String toJson() => json.encode(toMap());

  factory JCarouselsModel.fromJson(String source) =>
      JCarouselsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'JCarouselsModel(Data: $data, StatusCode: $statusCode, Message: $message, IsSuccess: $isSuccess, Errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is JCarouselsModel &&
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

class CarousalModel {
  int? id;
  String? name;
  String? title;
  String? dataSourceType;
  List<Products>? products;
  List<SubCategories>? subCategories;
  CarousalModel({
    this.id,
    this.name,
    this.title,
    this.dataSourceType,
    this.products,
    this.subCategories,
  });

  CarousalModel copyWith({
    int? id,
    String? name,
    String? title,
    String? dataSourceType,
    List<Products>? products,
    List<SubCategories>? subCategories,
  }) {
    return CarousalModel(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      dataSourceType: dataSourceType ?? this.dataSourceType,
      products: products ?? this.products,
      subCategories: subCategories ?? this.subCategories,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Name': name,
      'Title': title,
      'DataSourceType': dataSourceType,
      'Products': products?.map((x) => x.toMap()).toList(),
      'SubCategories': subCategories?.map((x) => x.toMap()).toList(),
    };
  }

  factory CarousalModel.fromMap(Map<String, dynamic> map) {
    return CarousalModel(
      id: map['Id']?.toInt(),
      name: map['Name'],
      title: map['Title'],
      dataSourceType: map['DataSourceType'],
      products: map['Products'] != null
          ? List<Products>.from(
              map['Products']?.map((x) => Products.fromMap(x)))
          : null,
      subCategories: map['SubCategories'] != null
          ? List<SubCategories>.from(
              map['SubCategories']?.map((x) => SubCategories.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarousalModel.fromJson(String source) =>
      CarousalModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CarousalModel(Id: $id, Name: $name, Title: $title, DataSourceType: $dataSourceType, Products: $products, SubCategories: $subCategories)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CarousalModel &&
        other.id == id &&
        other.name == name &&
        other.title == title &&
        other.dataSourceType == dataSourceType &&
        listEquals(other.products, products) &&
        listEquals(other.subCategories, subCategories);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        title.hashCode ^
        dataSourceType.hashCode ^
        products.hashCode ^
        subCategories.hashCode;
  }
}

class Products {
  int? id;
  String? name;
  String? shortDescription;
  String? fullDescription;
  String? seName;
  dynamic sku;
  dynamic productType;
  bool? markAsNew;
  ProductPrice? productPrice;
  DefaultPictureModel? defaultPictureModel;
  bool? isInWishlist;
  bool? isInShoppingCart;
  bool? isFavorite;
  bool? hasAttribute;
  bool? hasRequiredAttribute;
  int? vendorId;
  String? createdOnUtc;
  dynamic availableStartDateTimeUtc;
  dynamic availableEndDateTimeUtc;
  bool? isOutOfStock;
  bool? isSubscribedToBackInStock;
  num? discountPercentage;
  List<dynamic>? productTags;
  bool? isApproved;
  int? visitCount;
  int? wishlistCount;
  int? favoriteCount;
  Products({
    this.id,
    this.name,
    this.shortDescription,
    this.fullDescription,
    this.seName,
    required this.sku,
    required this.productType,
    this.markAsNew,
    this.productPrice,
    this.defaultPictureModel,
    this.isInWishlist,
    this.isInShoppingCart,
    this.isFavorite,
    this.hasAttribute,
    this.hasRequiredAttribute,
    this.vendorId,
    this.createdOnUtc,
    this.availableStartDateTimeUtc,
    this.availableEndDateTimeUtc,
    this.isOutOfStock,
    this.isSubscribedToBackInStock,
    this.discountPercentage,
    this.productTags,
    this.isApproved,
    this.visitCount,
    this.wishlistCount,
    this.favoriteCount,
  });

  Products copyWith({
    int? id,
    String? name,
    String? shortDescription,
    String? fullDescription,
    String? seName,
    dynamic sku,
    dynamic productType,
    bool? markAsNew,
    ProductPrice? productPrice,
    DefaultPictureModel? defaultPictureModel,
    bool? isInWishlist,
    bool? isInShoppingCart,
    bool? isFavorite,
    bool? hasAttribute,
    bool? hasRequiredAttribute,
    int? vendorId,
    String? createdOnUtc,
    dynamic availableStartDateTimeUtc,
    dynamic availableEndDateTimeUtc,
    bool? isOutOfStock,
    bool? isSubscribedToBackInStock,
    num? discountPercentage,
    List<dynamic>? productTags,
    bool? isApproved,
    int? visitCount,
    int? wishlistCount,
    int? favoriteCount,
  }) {
    return Products(
      id: id ?? this.id,
      name: name ?? this.name,
      shortDescription: shortDescription ?? this.shortDescription,
      fullDescription: fullDescription ?? this.fullDescription,
      seName: seName ?? this.seName,
      sku: sku ?? this.sku,
      productType: productType ?? this.productType,
      markAsNew: markAsNew ?? this.markAsNew,
      productPrice: productPrice ?? this.productPrice,
      defaultPictureModel: defaultPictureModel ?? this.defaultPictureModel,
      isInWishlist: isInWishlist ?? this.isInWishlist,
      isInShoppingCart: isInShoppingCart ?? this.isInShoppingCart,
      isFavorite: isFavorite ?? this.isFavorite,
      hasAttribute: hasAttribute ?? this.hasAttribute,
      hasRequiredAttribute: hasRequiredAttribute ?? this.hasRequiredAttribute,
      vendorId: vendorId ?? this.vendorId,
      createdOnUtc: createdOnUtc ?? this.createdOnUtc,
      availableStartDateTimeUtc:
          availableStartDateTimeUtc ?? this.availableStartDateTimeUtc,
      availableEndDateTimeUtc:
          availableEndDateTimeUtc ?? this.availableEndDateTimeUtc,
      isOutOfStock: isOutOfStock ?? this.isOutOfStock,
      isSubscribedToBackInStock:
          isSubscribedToBackInStock ?? this.isSubscribedToBackInStock,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      productTags: productTags ?? this.productTags,
      isApproved: isApproved ?? this.isApproved,
      visitCount: visitCount ?? this.visitCount,
      wishlistCount: wishlistCount ?? this.wishlistCount,
      favoriteCount: favoriteCount ?? this.favoriteCount,
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
      'markAsNew': markAsNew,
      'productPrice': productPrice?.toMap(),
      'defaultPictureModel': defaultPictureModel?.toMap(),
      'isInWishlist': isInWishlist,
      'isInShoppingCart': isInShoppingCart,
      'isFavorite': isFavorite,
      'hasAttribute': hasAttribute,
      'hasRequiredAttribute': hasRequiredAttribute,
      'vendorId': vendorId,
      'createdOnUtc': createdOnUtc,
      'availableStartDateTimeUtc': availableStartDateTimeUtc,
      'availableEndDateTimeUtc': availableEndDateTimeUtc,
      'isOutOfStock': isOutOfStock,
      'isSubscribedToBackInStock': isSubscribedToBackInStock,
      'discountPercentage': discountPercentage,
      'productTags': productTags,
      'isApproved': isApproved,
      'visitCount': visitCount,
      'wishlistCount': wishlistCount,
      'favoriteCount': favoriteCount,
    };
  }

  factory Products.fromMap(Map<String, dynamic> map) {
    return Products(
      id: map['id']?.toInt(),
      name: map['name'],
      shortDescription: map['shortDescription'],
      fullDescription: map['fullDescription'],
      seName: map['seName'],
      sku: map['sku'],
      productType: map['productType'],
      markAsNew: map['markAsNew'],
      productPrice: map['productPrice'] != null
          ? ProductPrice.fromMap(map['productPrice'])
          : null,
      defaultPictureModel: map['defaultPictureModel'] != null
          ? DefaultPictureModel.fromMap(map['defaultPictureModel'])
          : null,
      isInWishlist: map['isInWishlist'],
      isInShoppingCart: map['isInShoppingCart'],
      isFavorite: map['isFavorite'],
      hasAttribute: map['hasAttribute'],
      hasRequiredAttribute: map['hasRequiredAttribute'],
      vendorId: map['vendorId']?.toInt(),
      createdOnUtc: map['createdOnUtc'],
      availableStartDateTimeUtc: map['availableStartDateTimeUtc'],
      availableEndDateTimeUtc: map['availableEndDateTimeUtc'],
      isOutOfStock: map['isOutOfStock'],
      isSubscribedToBackInStock: map['isSubscribedToBackInStock'],
      discountPercentage: map['discountPercentage'],
      productTags: List<dynamic>.from(map['productTags']),
      isApproved: map['isApproved'],
      visitCount: map['visitCount']?.toInt(),
      wishlistCount: map['wishlistCount']?.toInt(),
      favoriteCount: map['favoriteCount']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Products.fromJson(String source) =>
      Products.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Products(id: $id, name: $name, shortDescription: $shortDescription, fullDescription: $fullDescription, seName: $seName, sku: $sku, productType: $productType, markAsNew: $markAsNew, productPrice: $productPrice, defaultPictureModel: $defaultPictureModel, isInWishlist: $isInWishlist, isInShoppingCart: $isInShoppingCart, isFavorite: $isFavorite, hasAttribute: $hasAttribute, hasRequiredAttribute: $hasRequiredAttribute, vendorId: $vendorId, createdOnUtc: $createdOnUtc, availableStartDateTimeUtc: $availableStartDateTimeUtc, availableEndDateTimeUtc: $availableEndDateTimeUtc, isOutOfStock: $isOutOfStock, isSubscribedToBackInStock: $isSubscribedToBackInStock, discountPercentage: $discountPercentage, productTags: $productTags, isApproved: $isApproved, visitCount: $visitCount, wishlistCount: $wishlistCount, favoriteCount: $favoriteCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Products &&
        other.id == id &&
        other.name == name &&
        other.shortDescription == shortDescription &&
        other.fullDescription == fullDescription &&
        other.seName == seName &&
        other.sku == sku &&
        other.productType == productType &&
        other.markAsNew == markAsNew &&
        other.productPrice == productPrice &&
        other.defaultPictureModel == defaultPictureModel &&
        other.isInWishlist == isInWishlist &&
        other.isInShoppingCart == isInShoppingCart &&
        other.isFavorite == isFavorite &&
        other.hasAttribute == hasAttribute &&
        other.hasRequiredAttribute == hasRequiredAttribute &&
        other.vendorId == vendorId &&
        other.createdOnUtc == createdOnUtc &&
        other.availableStartDateTimeUtc == availableStartDateTimeUtc &&
        other.availableEndDateTimeUtc == availableEndDateTimeUtc &&
        other.isOutOfStock == isOutOfStock &&
        other.isSubscribedToBackInStock == isSubscribedToBackInStock &&
        other.discountPercentage == discountPercentage &&
        listEquals(other.productTags, productTags) &&
        other.isApproved == isApproved &&
        other.visitCount == visitCount &&
        other.wishlistCount == wishlistCount &&
        other.favoriteCount == favoriteCount;
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
        markAsNew.hashCode ^
        productPrice.hashCode ^
        defaultPictureModel.hashCode ^
        isInWishlist.hashCode ^
        isInShoppingCart.hashCode ^
        isFavorite.hashCode ^
        hasAttribute.hashCode ^
        hasRequiredAttribute.hashCode ^
        vendorId.hashCode ^
        createdOnUtc.hashCode ^
        availableStartDateTimeUtc.hashCode ^
        availableEndDateTimeUtc.hashCode ^
        isOutOfStock.hashCode ^
        isSubscribedToBackInStock.hashCode ^
        discountPercentage.hashCode ^
        productTags.hashCode ^
        isApproved.hashCode ^
        visitCount.hashCode ^
        wishlistCount.hashCode ^
        favoriteCount.hashCode;
  }
}

class ProductPrice {
  String? oldPrice;
  String? price;
  dynamic priceValue;
  dynamic basePricePAngV;
  bool? disableBuyButton;
  bool? disableWishlistButton;
  bool? disableAddToCompareListButton;
  bool? availableForPreOrder;
  dynamic preOrderAvailabilityStartDateTimeUtc;
  bool? isRental;
  bool? forceRedirectionAfterAddingToCart;
  bool? displayTaxShippingInfo;
  ProductPrice({
    required this.oldPrice,
    this.price,
    required this.priceValue,
    required this.basePricePAngV,
    this.disableBuyButton,
    this.disableWishlistButton,
    this.disableAddToCompareListButton,
    this.availableForPreOrder,
    required this.preOrderAvailabilityStartDateTimeUtc,
    this.isRental,
    this.forceRedirectionAfterAddingToCart,
    this.displayTaxShippingInfo,
  });

  ProductPrice copyWith({
    String? oldPrice,
    String? price,
    dynamic priceValue,
    dynamic basePricePAngV,
    bool? disableBuyButton,
    bool? disableWishlistButton,
    bool? disableAddToCompareListButton,
    bool? availableForPreOrder,
    dynamic preOrderAvailabilityStartDateTimeUtc,
    bool? isRental,
    bool? forceRedirectionAfterAddingToCart,
    bool? displayTaxShippingInfo,
  }) {
    return ProductPrice(
      oldPrice: oldPrice ?? this.oldPrice,
      price: price ?? this.price,
      priceValue: priceValue ?? this.priceValue,
      basePricePAngV: basePricePAngV ?? this.basePricePAngV,
      disableBuyButton: disableBuyButton ?? this.disableBuyButton,
      disableWishlistButton:
          disableWishlistButton ?? this.disableWishlistButton,
      disableAddToCompareListButton:
          disableAddToCompareListButton ?? this.disableAddToCompareListButton,
      availableForPreOrder: availableForPreOrder ?? this.availableForPreOrder,
      preOrderAvailabilityStartDateTimeUtc:
          preOrderAvailabilityStartDateTimeUtc ??
              this.preOrderAvailabilityStartDateTimeUtc,
      isRental: isRental ?? this.isRental,
      forceRedirectionAfterAddingToCart: forceRedirectionAfterAddingToCart ??
          this.forceRedirectionAfterAddingToCart,
      displayTaxShippingInfo:
          displayTaxShippingInfo ?? this.displayTaxShippingInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'OldPrice': oldPrice,
      'Price': price,
      'PriceValue': priceValue,
      'BasePricePAngV': basePricePAngV,
      'DisableBuyButton': disableBuyButton,
      'DisableWishlistButton': disableWishlistButton,
      'DisableAddToCompareListButton': disableAddToCompareListButton,
      'AvailableForPreOrder': availableForPreOrder,
      'PreOrderAvailabilityStartDateTimeUtc':
          preOrderAvailabilityStartDateTimeUtc,
      'IsRental': isRental,
      'ForceRedirectionAfterAddingToCart': forceRedirectionAfterAddingToCart,
      'DisplayTaxShippingInfo': displayTaxShippingInfo,
    };
  }

  factory ProductPrice.fromMap(Map<String, dynamic> map) {
    return ProductPrice(
      oldPrice: map['OldPrice'],
      price: map['Price'],
      priceValue: map['PriceValue'],
      basePricePAngV: map['BasePricePAngV'],
      disableBuyButton: map['DisableBuyButton'],
      disableWishlistButton: map['DisableWishlistButton'],
      disableAddToCompareListButton: map['DisableAddToCompareListButton'],
      availableForPreOrder: map['AvailableForPreOrder'],
      preOrderAvailabilityStartDateTimeUtc:
          map['PreOrderAvailabilityStartDateTimeUtc'],
      isRental: map['IsRental'],
      forceRedirectionAfterAddingToCart:
          map['ForceRedirectionAfterAddingToCart'],
      displayTaxShippingInfo: map['DisplayTaxShippingInfo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductPrice.fromJson(String source) =>
      ProductPrice.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductPrice(oldPrice: $oldPrice, price: $price, priceValue: $priceValue, basePricePAngV: $basePricePAngV, disableBuyButton: $disableBuyButton, disableWishlistButton: $disableWishlistButton, disableAddToCompareListButton: $disableAddToCompareListButton, availableForPreOrder: $availableForPreOrder, preOrderAvailabilityStartDateTimeUtc: $preOrderAvailabilityStartDateTimeUtc, isRental: $isRental, forceRedirectionAfterAddingToCart: $forceRedirectionAfterAddingToCart, displayTaxShippingInfo: $displayTaxShippingInfo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductPrice &&
        other.oldPrice == oldPrice &&
        other.price == price &&
        other.priceValue == priceValue &&
        other.basePricePAngV == basePricePAngV &&
        other.disableBuyButton == disableBuyButton &&
        other.disableWishlistButton == disableWishlistButton &&
        other.disableAddToCompareListButton == disableAddToCompareListButton &&
        other.availableForPreOrder == availableForPreOrder &&
        other.preOrderAvailabilityStartDateTimeUtc ==
            preOrderAvailabilityStartDateTimeUtc &&
        other.isRental == isRental &&
        other.forceRedirectionAfterAddingToCart ==
            forceRedirectionAfterAddingToCart &&
        other.displayTaxShippingInfo == displayTaxShippingInfo;
  }

  @override
  int get hashCode {
    return oldPrice.hashCode ^
        price.hashCode ^
        priceValue.hashCode ^
        basePricePAngV.hashCode ^
        disableBuyButton.hashCode ^
        disableWishlistButton.hashCode ^
        disableAddToCompareListButton.hashCode ^
        availableForPreOrder.hashCode ^
        preOrderAvailabilityStartDateTimeUtc.hashCode ^
        isRental.hashCode ^
        forceRedirectionAfterAddingToCart.hashCode ^
        displayTaxShippingInfo.hashCode;
  }
}

class Categories {
  int? id;
  String? name;
  Categories({
    this.id,
    this.name,
  });

  Categories copyWith({
    int? id,
    String? name,
  }) {
    return Categories(
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

  factory Categories.fromMap(Map<String, dynamic> map) {
    return Categories(
      id: map['Id']?.toInt(),
      name: map['Name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Categories.fromJson(String source) =>
      Categories.fromMap(json.decode(source));

  @override
  String toString() => 'Categories(Id: $id, Name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Categories && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class SubCategories {
  int? id;
  String? name;
  String? seName;
  dynamic description;
  DefaultPictureModel? pictureModel;
  SubCategories({
    this.id,
    this.name,
    this.seName,
    required this.description,
    this.pictureModel,
  });

  SubCategories copyWith({
    int? id,
    String? name,
    String? seName,
    dynamic description,
    DefaultPictureModel? pictureModel,
  }) {
    return SubCategories(
      id: id ?? this.id,
      name: name ?? this.name,
      seName: seName ?? this.seName,
      description: description ?? this.description,
      pictureModel: pictureModel ?? this.pictureModel,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Name': name,
      'SeName': seName,
      'Description': description,
      'PictureModel': pictureModel?.toMap(),
    };
  }

  factory SubCategories.fromMap(Map<String, dynamic> map) {
    return SubCategories(
      id: map['Id']?.toInt(),
      name: map['Name'],
      seName: map['SeName'],
      description: map['Description'],
      pictureModel: map['PictureModel'] != null
          ? DefaultPictureModel.fromMap(map['PictureModel'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubCategories.fromJson(String source) =>
      SubCategories.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SubCategories(Id: $id, Name: $name, SeName: $seName, Description: $description, PictureModel: $pictureModel)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubCategories &&
        other.id == id &&
        other.name == name &&
        other.seName == seName &&
        other.description == description &&
        other.pictureModel == pictureModel;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        seName.hashCode ^
        description.hashCode ^
        pictureModel.hashCode;
  }
}

class DefaultPictureModel {
  String? imageUrl;
  dynamic thumbImageUrl;
  String? fullSizeImageUrl;
  String? title;
  String? alternateText;
  DefaultPictureModel({
    this.imageUrl,
    required this.thumbImageUrl,
    this.fullSizeImageUrl,
    this.title,
    this.alternateText,
  });

  DefaultPictureModel copyWith({
    String? imageUrl,
    dynamic thumbImageUrl,
    String? fullSizeImageUrl,
    String? title,
    String? alternateText,
  }) {
    return DefaultPictureModel(
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

  factory DefaultPictureModel.fromMap(Map<String, dynamic> map) {
    return DefaultPictureModel(
      imageUrl: map['ImageUrl'],
      thumbImageUrl: map['ThumbImageUrl'],
      fullSizeImageUrl: map['FullSizeImageUrl'],
      title: map['Title'],
      alternateText: map['AlternateText'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DefaultPictureModel.fromJson(String source) =>
      DefaultPictureModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DefaultPictureModel(ImageUrl: $imageUrl, ThumbImageUrl: $thumbImageUrl, FullSizeImageUrl: $fullSizeImageUrl, Title: $title, AlternateText: $alternateText)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DefaultPictureModel &&
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
