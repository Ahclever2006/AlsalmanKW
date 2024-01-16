import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/data/models/home_section_product_model.dart';
import '../../../../core/data/models/id_name_model_snack_case.dart';

class ProductDetailsModel {
  final String? productTemplateViewPath;
  final ProductDetailsModelClass? productDetailsModel;
  ProductDetailsModel({
    this.productTemplateViewPath,
    this.productDetailsModel,
  });

  ProductDetailsModel copyWith({
    String? productTemplateViewPath,
    ProductDetailsModelClass? productDetailsModel,
  }) {
    return ProductDetailsModel(
      productTemplateViewPath:
          productTemplateViewPath ?? this.productTemplateViewPath,
      productDetailsModel: productDetailsModel ?? this.productDetailsModel,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productTemplateViewPath': productTemplateViewPath,
      'productDetailsModel': productDetailsModel?.toMap(),
    };
  }

  factory ProductDetailsModel.fromMap(Map<String, dynamic> map) {
    return ProductDetailsModel(
      productTemplateViewPath: map['productTemplateViewPath'],
      productDetailsModel: map['productDetailsModel'] != null
          ? ProductDetailsModelClass.fromMap(map['productDetailsModel'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductDetailsModel.fromJson(String source) =>
      ProductDetailsModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ProductDetailsModel(productTemplateViewPath: $productTemplateViewPath, productDetailsModel: $productDetailsModel)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductDetailsModel &&
        other.productTemplateViewPath == productTemplateViewPath &&
        other.productDetailsModel == productDetailsModel;
  }

  @override
  int get hashCode =>
      productTemplateViewPath.hashCode ^ productDetailsModel.hashCode;
}

class ProductDetailsModelClass {
  final bool? defaultPictureZoomEnabled;
  final PictureModel? defaultPictureModel;
  List<PictureModel>? pictureModels;
  final String? name;
  final String? shortDescription;
  final String? fullDescription;
  dynamic metaKeywords;
  final String? metaDescription;
  dynamic metaTitle;
  final String? seName;
  bool? visibleIndividually;
  final String? productType;
  bool? showSku;
  dynamic sku;
  bool? showManufacturerPartNumber;
  dynamic manufacturerPartNumber;
  bool? showGtin;
  dynamic gtin;
  bool? showVendor;
  VendorModel? vendorModel;
  bool? hasSampleDownload;
  bool? isDownload;
  String? downloadUrl;
  GiftCard? giftCard;
  int? count;
  bool? isShipEnabled;
  bool? isFreeShipping;
  bool? freeShippingNotificationEnabled;
  dynamic deliveryDate;
  bool? isRental;
  dynamic rentalStartDate;
  dynamic rentalEndDate;
  dynamic availableEndDate;
  final String? manageInventoryMethod;
  final String? stockAvailability;
  bool? displayBackInStockSubscription;
  bool? emailAFriendEnabled;
  bool? compareProductsEnabled;
  final String? pageShareCode;
  ProductPrice? productPrice;
  bool? isInWishlist;
  bool? isInShoppingCart;
  AddToCart? addToCart;
  Breadcrumb? breadcrumb;
  List<IdNameModelSnackCase>? productTags;
  List<ProductAttribute>? productAttributes;
  ProductSpecificationModel? productSpecificationModel;
  List<Manufacturer>? productManufacturers;
  ProductReviewOverview? productReviewOverview;
  ProductEstimateShipping? productEstimateShipping;
  List<dynamic>? tierPrices;
  List<dynamic>? associatedProducts;
  bool? displayDiscontinuedMessage;
  final String? currentStoreName;
  bool? inStock;
  bool? allowAddingOnlyExistingAttributeCombinations;
  int? wishlistCount;
  int? favoriteCount;
  int? orderMinimumQuantity;
  int? orderMaximumQuantity;
  int? stockQuantity;
  int? manageInventoryMethodId;
  double? productCost;
  bool? published;
  bool? isFavorite;
  bool? hasSpacialAttributes;
  String? fontName;
  int? fontSize;
  int? textPosition;
  int? id;
  CustomProperties? customProperties;
  ProductDetailsModelClass({
    this.defaultPictureZoomEnabled,
    this.defaultPictureModel,
    this.pictureModels,
    this.name,
    this.shortDescription,
    this.fullDescription,
    required this.metaKeywords,
    this.metaDescription,
    required this.metaTitle,
    this.seName,
    this.visibleIndividually,
    this.productType,
    this.showSku,
    required this.sku,
    this.showManufacturerPartNumber,
    required this.manufacturerPartNumber,
    this.showGtin,
    required this.gtin,
    this.showVendor,
    this.vendorModel,
    this.hasSampleDownload,
    this.isDownload,
    this.downloadUrl,
    this.giftCard,
    this.count,
    this.isShipEnabled,
    this.isFreeShipping,
    this.freeShippingNotificationEnabled,
    required this.deliveryDate,
    this.isRental,
    required this.rentalStartDate,
    required this.rentalEndDate,
    required this.availableEndDate,
    this.manageInventoryMethod,
    this.stockAvailability,
    this.displayBackInStockSubscription,
    this.emailAFriendEnabled,
    this.compareProductsEnabled,
    this.pageShareCode,
    this.productPrice,
    this.isInWishlist,
    this.isInShoppingCart,
    this.addToCart,
    this.breadcrumb,
    this.productTags,
    this.productAttributes,
    this.productSpecificationModel,
    this.productManufacturers,
    this.productReviewOverview,
    this.productEstimateShipping,
    this.tierPrices,
    this.associatedProducts,
    this.displayDiscontinuedMessage,
    this.currentStoreName,
    this.inStock,
    this.allowAddingOnlyExistingAttributeCombinations,
    this.wishlistCount,
    this.favoriteCount,
    this.orderMinimumQuantity,
    this.orderMaximumQuantity,
    this.stockQuantity,
    this.manageInventoryMethodId,
    this.productCost,
    this.published,
    this.isFavorite,
    this.hasSpacialAttributes,
    this.fontName,
    this.fontSize,
    this.textPosition,
    this.id,
    this.customProperties,
  });

  ProductDetailsModelClass copyWith({
    bool? defaultPictureZoomEnabled,
    PictureModel? defaultPictureModel,
    List<PictureModel>? pictureModels,
    String? name,
    String? shortDescription,
    String? fullDescription,
    dynamic metaKeywords,
    String? metaDescription,
    dynamic metaTitle,
    String? seName,
    bool? visibleIndividually,
    String? productType,
    bool? showSku,
    dynamic sku,
    bool? showManufacturerPartNumber,
    dynamic manufacturerPartNumber,
    bool? showGtin,
    dynamic gtin,
    bool? showVendor,
    VendorModel? vendorModel,
    bool? hasSampleDownload,
    bool? isDownload,
    String? downloadUrl,
    GiftCard? giftCard,
    int? count,
    bool? isShipEnabled,
    bool? isFreeShipping,
    bool? freeShippingNotificationEnabled,
    dynamic deliveryDate,
    bool? isRental,
    dynamic rentalStartDate,
    dynamic rentalEndDate,
    dynamic availableEndDate,
    String? manageInventoryMethod,
    String? stockAvailability,
    bool? displayBackInStockSubscription,
    bool? emailAFriendEnabled,
    bool? compareProductsEnabled,
    String? pageShareCode,
    ProductPrice? productPrice,
    bool? isInWishlist,
    bool? isInShoppingCart,
    AddToCart? addToCart,
    Breadcrumb? breadcrumb,
    List<IdNameModelSnackCase>? productTags,
    List<ProductAttribute>? productAttributes,
    ProductSpecificationModel? productSpecificationModel,
    List<Manufacturer>? productManufacturers,
    ProductReviewOverview? productReviewOverview,
    ProductEstimateShipping? productEstimateShipping,
    List<dynamic>? tierPrices,
    List<dynamic>? associatedProducts,
    bool? displayDiscontinuedMessage,
    String? currentStoreName,
    bool? inStock,
    bool? allowAddingOnlyExistingAttributeCombinations,
    int? wishlistCount,
    int? favoriteCount,
    int? orderMinimumQuantity,
    int? orderMaximumQuantity,
    int? stockQuantity,
    int? manageInventoryMethodId,
    double? productCost,
    bool? published,
    bool? isFavorite,
    bool? hasSpacialAttributes,
    String? fontName,
    int? fontSize,
    int? textPosition,
    int? id,
    CustomProperties? customProperties,
  }) {
    return ProductDetailsModelClass(
      defaultPictureZoomEnabled:
          defaultPictureZoomEnabled ?? this.defaultPictureZoomEnabled,
      defaultPictureModel: defaultPictureModel ?? this.defaultPictureModel,
      pictureModels: pictureModels ?? this.pictureModels,
      name: name ?? this.name,
      shortDescription: shortDescription ?? this.shortDescription,
      fullDescription: fullDescription ?? this.fullDescription,
      metaKeywords: metaKeywords ?? this.metaKeywords,
      metaDescription: metaDescription ?? this.metaDescription,
      metaTitle: metaTitle ?? this.metaTitle,
      seName: seName ?? this.seName,
      visibleIndividually: visibleIndividually ?? this.visibleIndividually,
      productType: productType ?? this.productType,
      showSku: showSku ?? this.showSku,
      sku: sku ?? this.sku,
      showManufacturerPartNumber:
          showManufacturerPartNumber ?? this.showManufacturerPartNumber,
      manufacturerPartNumber:
          manufacturerPartNumber ?? this.manufacturerPartNumber,
      showGtin: showGtin ?? this.showGtin,
      gtin: gtin ?? this.gtin,
      showVendor: showVendor ?? this.showVendor,
      vendorModel: vendorModel ?? this.vendorModel,
      hasSampleDownload: hasSampleDownload ?? this.hasSampleDownload,
      isDownload: isDownload ?? this.isDownload,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      giftCard: giftCard ?? this.giftCard,
      count: count ?? this.count,
      isShipEnabled: isShipEnabled ?? this.isShipEnabled,
      isFreeShipping: isFreeShipping ?? this.isFreeShipping,
      freeShippingNotificationEnabled: freeShippingNotificationEnabled ??
          this.freeShippingNotificationEnabled,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      isRental: isRental ?? this.isRental,
      rentalStartDate: rentalStartDate ?? this.rentalStartDate,
      rentalEndDate: rentalEndDate ?? this.rentalEndDate,
      availableEndDate: availableEndDate ?? this.availableEndDate,
      manageInventoryMethod:
          manageInventoryMethod ?? this.manageInventoryMethod,
      stockAvailability: stockAvailability ?? this.stockAvailability,
      displayBackInStockSubscription:
          displayBackInStockSubscription ?? this.displayBackInStockSubscription,
      emailAFriendEnabled: emailAFriendEnabled ?? this.emailAFriendEnabled,
      compareProductsEnabled:
          compareProductsEnabled ?? this.compareProductsEnabled,
      pageShareCode: pageShareCode ?? this.pageShareCode,
      productPrice: productPrice ?? this.productPrice,
      isInWishlist: isInWishlist ?? this.isInWishlist,
      isInShoppingCart: isInShoppingCart ?? this.isInShoppingCart,
      addToCart: addToCart ?? this.addToCart,
      breadcrumb: breadcrumb ?? this.breadcrumb,
      productTags: productTags ?? this.productTags,
      productAttributes: productAttributes ?? this.productAttributes,
      productSpecificationModel:
          productSpecificationModel ?? this.productSpecificationModel,
      productManufacturers: productManufacturers ?? this.productManufacturers,
      productReviewOverview:
          productReviewOverview ?? this.productReviewOverview,
      productEstimateShipping:
          productEstimateShipping ?? this.productEstimateShipping,
      tierPrices: tierPrices ?? this.tierPrices,
      associatedProducts: associatedProducts ?? this.associatedProducts,
      displayDiscontinuedMessage:
          displayDiscontinuedMessage ?? this.displayDiscontinuedMessage,
      currentStoreName: currentStoreName ?? this.currentStoreName,
      inStock: inStock ?? this.inStock,
      allowAddingOnlyExistingAttributeCombinations:
          allowAddingOnlyExistingAttributeCombinations ??
              this.allowAddingOnlyExistingAttributeCombinations,
      wishlistCount: wishlistCount ?? this.wishlistCount,
      favoriteCount: favoriteCount ?? this.favoriteCount,
      orderMinimumQuantity: orderMinimumQuantity ?? this.orderMinimumQuantity,
      orderMaximumQuantity: orderMaximumQuantity ?? this.orderMaximumQuantity,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      manageInventoryMethodId:
          manageInventoryMethodId ?? this.manageInventoryMethodId,
      productCost: productCost ?? this.productCost,
      published: published ?? this.published,
      isFavorite: isFavorite ?? this.isFavorite,
      hasSpacialAttributes: hasSpacialAttributes ?? this.hasSpacialAttributes,
      fontName: fontName ?? this.fontName,
      fontSize: fontSize ?? this.fontSize,
      textPosition: textPosition ?? this.textPosition,
      id: id ?? this.id,
      customProperties: customProperties ?? this.customProperties,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'defaultPictureZoomEnabled': defaultPictureZoomEnabled,
      'defaultPictureModel': defaultPictureModel?.toMap(),
      'pictureModels': pictureModels?.map((x) => x.toMap()).toList(),
      'name': name,
      'shortDescription': shortDescription,
      'fullDescription': fullDescription,
      'metaKeywords': metaKeywords,
      'metaDescription': metaDescription,
      'metaTitle': metaTitle,
      'seName': seName,
      'visibleIndividually': visibleIndividually,
      'productType': productType,
      'showSku': showSku,
      'sku': sku,
      'showManufacturerPartNumber': showManufacturerPartNumber,
      'manufacturerPartNumber': manufacturerPartNumber,
      'showGtin': showGtin,
      'gtin': gtin,
      'showVendor': showVendor,
      'vendorModel': vendorModel?.toMap(),
      'hasSampleDownload': hasSampleDownload,
      'isDownload': isDownload,
      'downloadUrl': downloadUrl,
      'giftCard': giftCard?.toMap(),
      'count': count,
      'isShipEnabled': isShipEnabled,
      'isFreeShipping': isFreeShipping,
      'freeShippingNotificationEnabled': freeShippingNotificationEnabled,
      'deliveryDate': deliveryDate,
      'isRental': isRental,
      'rentalStartDate': rentalStartDate,
      'rentalEndDate': rentalEndDate,
      'availableEndDate': availableEndDate,
      'manageInventoryMethod': manageInventoryMethod,
      'stockAvailability': stockAvailability,
      'displayBackInStockSubscription': displayBackInStockSubscription,
      'emailAFriendEnabled': emailAFriendEnabled,
      'compareProductsEnabled': compareProductsEnabled,
      'pageShareCode': pageShareCode,
      'productPrice': productPrice?.toMap(),
      'isInWishlist': isInWishlist,
      'isInShoppingCart': isInShoppingCart,
      'addToCart': addToCart?.toMap(),
      'breadcrumb': breadcrumb?.toMap(),
      'productTags': productTags?.map((x) => x.toMap()).toList(),
      'productAttributes': productAttributes?.map((x) => x.toMap()).toList(),
      'productSpecificationModel': productSpecificationModel?.toMap(),
      'productManufacturers':
          productManufacturers?.map((x) => x.toMap()).toList(),
      'productReviewOverview': productReviewOverview?.toMap(),
      'productEstimateShipping': productEstimateShipping?.toMap(),
      'tierPrices': tierPrices,
      'associatedProducts': associatedProducts,
      'displayDiscontinuedMessage': displayDiscontinuedMessage,
      'currentStoreName': currentStoreName,
      'inStock': inStock,
      'allowAddingOnlyExistingAttributeCombinations':
          allowAddingOnlyExistingAttributeCombinations,
      'wishlistCount': wishlistCount,
      'favoriteCount': favoriteCount,
      'orderMinimumQuantity': orderMinimumQuantity,
      'orderMaximumQuantity': orderMaximumQuantity,
      'stockQuantity': stockQuantity,
      'manageInventoryMethodId': manageInventoryMethodId,
      'productCost': productCost,
      'published': published,
      'isFavorite': isFavorite,
      'hasSpacialAttributes': hasSpacialAttributes,
      'fontName': fontName,
      'fontSize': fontSize,
      'textPosition': textPosition,
      'id': id,
      'customProperties': customProperties?.toMap(),
    };
  }

  factory ProductDetailsModelClass.fromMap(Map<String, dynamic> map) {
    return ProductDetailsModelClass(
      defaultPictureZoomEnabled: map['defaultPictureZoomEnabled'],
      defaultPictureModel: map['defaultPictureModel'] != null
          ? PictureModel.fromMap(map['defaultPictureModel'])
          : null,
      pictureModels: map['pictureModels'] != null
          ? List<PictureModel>.from(
              map['pictureModels']?.map((x) => PictureModel.fromMap(x)))
          : null,
      name: map['name'],
      shortDescription: map['shortDescription'],
      fullDescription: map['fullDescription'],
      metaKeywords: map['metaKeywords'],
      metaDescription: map['metaDescription'],
      metaTitle: map['metaTitle'],
      seName: map['seName'],
      visibleIndividually: map['visibleIndividually'],
      productType: map['productType'],
      showSku: map['showSku'],
      sku: map['sku'],
      showManufacturerPartNumber: map['showManufacturerPartNumber'],
      manufacturerPartNumber: map['manufacturerPartNumber'],
      showGtin: map['showGtin'],
      gtin: map['gtin'],
      showVendor: map['showVendor'],
      vendorModel: map['vendorModel'] != null
          ? VendorModel.fromMap(map['vendorModel'])
          : null,
      hasSampleDownload: map['hasSampleDownload'],
      isDownload: map['isDownload'],
      downloadUrl: map['downloadUrl'],
      giftCard:
          map['giftCard'] != null ? GiftCard.fromMap(map['giftCard']) : null,
      count: map['count']?.toInt(),
      isShipEnabled: map['isShipEnabled'],
      isFreeShipping: map['isFreeShipping'],
      freeShippingNotificationEnabled: map['freeShippingNotificationEnabled'],
      deliveryDate: map['deliveryDate'],
      isRental: map['isRental'],
      rentalStartDate: map['rentalStartDate'],
      rentalEndDate: map['rentalEndDate'],
      availableEndDate: map['availableEndDate'],
      manageInventoryMethod: map['manageInventoryMethod'],
      stockAvailability: map['stockAvailability'],
      displayBackInStockSubscription: map['displayBackInStockSubscription'],
      emailAFriendEnabled: map['emailAFriendEnabled'],
      compareProductsEnabled: map['compareProductsEnabled'],
      pageShareCode: map['pageShareCode'],
      productPrice: map['productPrice'] != null
          ? ProductPrice.fromMap(map['productPrice'])
          : null,
      isInWishlist: map['isInWishlist'],
      isInShoppingCart: map['isInShoppingCart'],
      addToCart:
          map['addToCart'] != null ? AddToCart.fromMap(map['addToCart']) : null,
      breadcrumb: map['breadcrumb'] != null
          ? Breadcrumb.fromMap(map['breadcrumb'])
          : null,
      productTags: map['productTags'] != null
          ? List<IdNameModelSnackCase>.from(
              map['productTags']?.map((x) => IdNameModelSnackCase.fromMap(x)))
          : null,
      productAttributes: map['productAttributes'] != null
          ? List<ProductAttribute>.from(
              map['productAttributes']?.map((x) => ProductAttribute.fromMap(x)))
          : null,
      productSpecificationModel: map['productSpecificationModel'] != null
          ? ProductSpecificationModel.fromMap(map['productSpecificationModel'])
          : null,
      productManufacturers: map['productManufacturers'] != null
          ? List<Manufacturer>.from(
              map['productManufacturers']?.map((x) => Manufacturer.fromMap(x)))
          : null,
      productReviewOverview: map['productReviewOverview'] != null
          ? ProductReviewOverview.fromMap(map['productReviewOverview'])
          : null,
      productEstimateShipping: map['productEstimateShipping'] != null
          ? ProductEstimateShipping.fromMap(map['productEstimateShipping'])
          : null,
      tierPrices: List<dynamic>.from(map['tierPrices']),
      associatedProducts: List<dynamic>.from(map['associatedProducts']),
      displayDiscontinuedMessage: map['displayDiscontinuedMessage'],
      currentStoreName: map['currentStoreName'],
      inStock: map['inStock'],
      allowAddingOnlyExistingAttributeCombinations:
          map['allowAddingOnlyExistingAttributeCombinations'],
      wishlistCount: map['wishlistCount']?.toInt(),
      favoriteCount: map['favoriteCount']?.toInt(),
      orderMinimumQuantity: map['orderMinimumQuantity']?.toInt(),
      orderMaximumQuantity: map['orderMaximumQuantity']?.toInt(),
      stockQuantity: map['stockQuantity']?.toInt(),
      manageInventoryMethodId: map['manageInventoryMethodId']?.toInt(),
      productCost: map['productCost']?.toDouble(),
      published: map['published'],
      isFavorite: map['isFavorite'],
      hasSpacialAttributes: map['hasSpacialAttributes'],
      fontName: map['fontName'],
      fontSize: map['fontSize']?.toInt(),
      textPosition: map['textPosition']?.toInt(),
      id: map['id']?.toInt(),
      customProperties: map['customProperties'] != null
          ? CustomProperties.fromMap(map['customProperties'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductDetailsModelClass.fromJson(String source) =>
      ProductDetailsModelClass.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductDetailsModelClass(defaultPictureZoomEnabled: $defaultPictureZoomEnabled, defaultPictureModel: $defaultPictureModel, pictureModels: $pictureModels, name: $name, shortDescription: $shortDescription, fullDescription: $fullDescription, metaKeywords: $metaKeywords, metaDescription: $metaDescription, metaTitle: $metaTitle, seName: $seName, visibleIndividually: $visibleIndividually, productType: $productType, showSku: $showSku, sku: $sku, showManufacturerPartNumber: $showManufacturerPartNumber, manufacturerPartNumber: $manufacturerPartNumber, showGtin: $showGtin, gtin: $gtin, showVendor: $showVendor, vendorModel: $vendorModel, hasSampleDownload: $hasSampleDownload, isDownload: $isDownload, downloadUrl: $downloadUrl, giftCard: $giftCard, count: $count, isShipEnabled: $isShipEnabled, isFreeShipping: $isFreeShipping, freeShippingNotificationEnabled: $freeShippingNotificationEnabled, deliveryDate: $deliveryDate, isRental: $isRental, rentalStartDate: $rentalStartDate, rentalEndDate: $rentalEndDate, availableEndDate: $availableEndDate, manageInventoryMethod: $manageInventoryMethod, stockAvailability: $stockAvailability, displayBackInStockSubscription: $displayBackInStockSubscription, emailAFriendEnabled: $emailAFriendEnabled, compareProductsEnabled: $compareProductsEnabled, pageShareCode: $pageShareCode, productPrice: $productPrice, isInWishlist: $isInWishlist, isInShoppingCart: $isInShoppingCart, addToCart: $addToCart, breadcrumb: $breadcrumb, productTags: $productTags, productAttributes: $productAttributes, productSpecificationModel: $productSpecificationModel, productManufacturers: $productManufacturers, productReviewOverview: $productReviewOverview, productEstimateShipping: $productEstimateShipping, tierPrices: $tierPrices, associatedProducts: $associatedProducts, displayDiscontinuedMessage: $displayDiscontinuedMessage, currentStoreName: $currentStoreName, inStock: $inStock, allowAddingOnlyExistingAttributeCombinations: $allowAddingOnlyExistingAttributeCombinations, wishlistCount: $wishlistCount, favoriteCount: $favoriteCount, orderMinimumQuantity: $orderMinimumQuantity, orderMaximumQuantity: $orderMaximumQuantity, stockQuantity: $stockQuantity, manageInventoryMethodId: $manageInventoryMethodId, productCost: $productCost, published: $published, isFavorite: $isFavorite, hasSpacialAttributes: $hasSpacialAttributes, fontName: $fontName, fontSize: $fontSize, textPosition: $textPosition, id: $id, customProperties: $customProperties)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductDetailsModelClass &&
        other.defaultPictureZoomEnabled == defaultPictureZoomEnabled &&
        other.defaultPictureModel == defaultPictureModel &&
        listEquals(other.pictureModels, pictureModels) &&
        other.name == name &&
        other.shortDescription == shortDescription &&
        other.fullDescription == fullDescription &&
        other.metaKeywords == metaKeywords &&
        other.metaDescription == metaDescription &&
        other.metaTitle == metaTitle &&
        other.seName == seName &&
        other.visibleIndividually == visibleIndividually &&
        other.productType == productType &&
        other.showSku == showSku &&
        other.sku == sku &&
        other.showManufacturerPartNumber == showManufacturerPartNumber &&
        other.manufacturerPartNumber == manufacturerPartNumber &&
        other.showGtin == showGtin &&
        other.gtin == gtin &&
        other.showVendor == showVendor &&
        other.vendorModel == vendorModel &&
        other.hasSampleDownload == hasSampleDownload &&
        other.isDownload == isDownload &&
        other.downloadUrl == downloadUrl &&
        other.giftCard == giftCard &&
        other.count == count &&
        other.isShipEnabled == isShipEnabled &&
        other.isFreeShipping == isFreeShipping &&
        other.freeShippingNotificationEnabled ==
            freeShippingNotificationEnabled &&
        other.deliveryDate == deliveryDate &&
        other.isRental == isRental &&
        other.rentalStartDate == rentalStartDate &&
        other.rentalEndDate == rentalEndDate &&
        other.availableEndDate == availableEndDate &&
        other.manageInventoryMethod == manageInventoryMethod &&
        other.stockAvailability == stockAvailability &&
        other.displayBackInStockSubscription ==
            displayBackInStockSubscription &&
        other.emailAFriendEnabled == emailAFriendEnabled &&
        other.compareProductsEnabled == compareProductsEnabled &&
        other.pageShareCode == pageShareCode &&
        other.productPrice == productPrice &&
        other.isInWishlist == isInWishlist &&
        other.isInShoppingCart == isInShoppingCart &&
        other.addToCart == addToCart &&
        other.breadcrumb == breadcrumb &&
        listEquals(other.productTags, productTags) &&
        listEquals(other.productAttributes, productAttributes) &&
        other.productSpecificationModel == productSpecificationModel &&
        listEquals(other.productManufacturers, productManufacturers) &&
        other.productReviewOverview == productReviewOverview &&
        other.productEstimateShipping == productEstimateShipping &&
        listEquals(other.tierPrices, tierPrices) &&
        listEquals(other.associatedProducts, associatedProducts) &&
        other.displayDiscontinuedMessage == displayDiscontinuedMessage &&
        other.currentStoreName == currentStoreName &&
        other.inStock == inStock &&
        other.allowAddingOnlyExistingAttributeCombinations ==
            allowAddingOnlyExistingAttributeCombinations &&
        other.wishlistCount == wishlistCount &&
        other.favoriteCount == favoriteCount &&
        other.orderMinimumQuantity == orderMinimumQuantity &&
        other.orderMaximumQuantity == orderMaximumQuantity &&
        other.stockQuantity == stockQuantity &&
        other.manageInventoryMethodId == manageInventoryMethodId &&
        other.productCost == productCost &&
        other.published == published &&
        other.isFavorite == isFavorite &&
        other.hasSpacialAttributes == hasSpacialAttributes &&
        other.fontName == fontName &&
        other.fontSize == fontSize &&
        other.textPosition == textPosition &&
        other.id == id &&
        other.customProperties == customProperties;
  }

  @override
  int get hashCode {
    return defaultPictureZoomEnabled.hashCode ^
        defaultPictureModel.hashCode ^
        pictureModels.hashCode ^
        name.hashCode ^
        shortDescription.hashCode ^
        fullDescription.hashCode ^
        metaKeywords.hashCode ^
        metaDescription.hashCode ^
        metaTitle.hashCode ^
        seName.hashCode ^
        visibleIndividually.hashCode ^
        productType.hashCode ^
        showSku.hashCode ^
        sku.hashCode ^
        showManufacturerPartNumber.hashCode ^
        manufacturerPartNumber.hashCode ^
        showGtin.hashCode ^
        gtin.hashCode ^
        showVendor.hashCode ^
        vendorModel.hashCode ^
        hasSampleDownload.hashCode ^
        isDownload.hashCode ^
        downloadUrl.hashCode ^
        giftCard.hashCode ^
        count.hashCode ^
        isShipEnabled.hashCode ^
        isFreeShipping.hashCode ^
        freeShippingNotificationEnabled.hashCode ^
        deliveryDate.hashCode ^
        isRental.hashCode ^
        rentalStartDate.hashCode ^
        rentalEndDate.hashCode ^
        availableEndDate.hashCode ^
        manageInventoryMethod.hashCode ^
        stockAvailability.hashCode ^
        displayBackInStockSubscription.hashCode ^
        emailAFriendEnabled.hashCode ^
        compareProductsEnabled.hashCode ^
        pageShareCode.hashCode ^
        productPrice.hashCode ^
        isInWishlist.hashCode ^
        isInShoppingCart.hashCode ^
        addToCart.hashCode ^
        breadcrumb.hashCode ^
        productTags.hashCode ^
        productAttributes.hashCode ^
        productSpecificationModel.hashCode ^
        productManufacturers.hashCode ^
        productReviewOverview.hashCode ^
        productEstimateShipping.hashCode ^
        tierPrices.hashCode ^
        associatedProducts.hashCode ^
        displayDiscontinuedMessage.hashCode ^
        currentStoreName.hashCode ^
        inStock.hashCode ^
        allowAddingOnlyExistingAttributeCombinations.hashCode ^
        wishlistCount.hashCode ^
        favoriteCount.hashCode ^
        orderMinimumQuantity.hashCode ^
        orderMaximumQuantity.hashCode ^
        stockQuantity.hashCode ^
        manageInventoryMethodId.hashCode ^
        productCost.hashCode ^
        published.hashCode ^
        isFavorite.hashCode ^
        hasSpacialAttributes.hashCode ^
        fontName.hashCode ^
        fontSize.hashCode ^
        textPosition.hashCode ^
        id.hashCode ^
        customProperties.hashCode;
  }
}

class AddToCart {
  int? productId;
  int? enteredQuantity;
  dynamic minimumQuantityNotification;
  List<dynamic>? allowedQuantities;
  bool? customerEntersPrice;
  num? customerEnteredPrice;
  dynamic customerEnteredPriceRange;
  bool? disableBuyButton;
  bool? disableWishlistButton;
  bool? isRental;
  bool? availableForPreOrder;
  dynamic preOrderAvailabilityStartDateTimeUTC;
  dynamic preOrderAvailabilityStartDateTimeUserTime;
  int? updatedShoppingCartItemId;
  dynamic updateShoppingCartItemType;
  AddToCart({
    this.productId,
    this.enteredQuantity,
    required this.minimumQuantityNotification,
    this.allowedQuantities,
    this.customerEntersPrice,
    this.customerEnteredPrice,
    required this.customerEnteredPriceRange,
    this.disableBuyButton,
    this.disableWishlistButton,
    this.isRental,
    this.availableForPreOrder,
    required this.preOrderAvailabilityStartDateTimeUTC,
    required this.preOrderAvailabilityStartDateTimeUserTime,
    this.updatedShoppingCartItemId,
    required this.updateShoppingCartItemType,
  });

  AddToCart copyWith({
    int? productId,
    int? enteredQuantity,
    dynamic minimumQuantityNotification,
    List<dynamic>? allowedQuantities,
    bool? customerEntersPrice,
    num? customerEnteredPrice,
    dynamic customerEnteredPriceRange,
    bool? disableBuyButton,
    bool? disableWishlistButton,
    bool? isRental,
    bool? availableForPreOrder,
    dynamic preOrderAvailabilityStartDateTimeUTC,
    dynamic preOrderAvailabilityStartDateTimeUserTime,
    int? updatedShoppingCartItemId,
    dynamic updateShoppingCartItemType,
  }) {
    return AddToCart(
      productId: productId ?? this.productId,
      enteredQuantity: enteredQuantity ?? this.enteredQuantity,
      minimumQuantityNotification:
          minimumQuantityNotification ?? this.minimumQuantityNotification,
      allowedQuantities: allowedQuantities ?? this.allowedQuantities,
      customerEntersPrice: customerEntersPrice ?? this.customerEntersPrice,
      customerEnteredPrice: customerEnteredPrice ?? this.customerEnteredPrice,
      customerEnteredPriceRange:
          customerEnteredPriceRange ?? this.customerEnteredPriceRange,
      disableBuyButton: disableBuyButton ?? this.disableBuyButton,
      disableWishlistButton:
          disableWishlistButton ?? this.disableWishlistButton,
      isRental: isRental ?? this.isRental,
      availableForPreOrder: availableForPreOrder ?? this.availableForPreOrder,
      preOrderAvailabilityStartDateTimeUTC:
          preOrderAvailabilityStartDateTimeUTC ??
              this.preOrderAvailabilityStartDateTimeUTC,
      preOrderAvailabilityStartDateTimeUserTime:
          preOrderAvailabilityStartDateTimeUserTime ??
              this.preOrderAvailabilityStartDateTimeUserTime,
      updatedShoppingCartItemId:
          updatedShoppingCartItemId ?? this.updatedShoppingCartItemId,
      updateShoppingCartItemType:
          updateShoppingCartItemType ?? this.updateShoppingCartItemType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'enteredQuantity': enteredQuantity,
      'minimumQuantityNotification': minimumQuantityNotification,
      'allowedQuantities': allowedQuantities,
      'customerEntersPrice': customerEntersPrice,
      'customerEnteredPrice': customerEnteredPrice,
      'customerEnteredPriceRange': customerEnteredPriceRange,
      'disableBuyButton': disableBuyButton,
      'disableWishlistButton': disableWishlistButton,
      'isRental': isRental,
      'availableForPreOrder': availableForPreOrder,
      'preOrderAvailabilityStartDateTimeUTC':
          preOrderAvailabilityStartDateTimeUTC,
      'preOrderAvailabilityStartDateTimeUserTime':
          preOrderAvailabilityStartDateTimeUserTime,
      'updatedShoppingCartItemId': updatedShoppingCartItemId,
      'updateShoppingCartItemType': updateShoppingCartItemType,
    };
  }

  factory AddToCart.fromMap(Map<String, dynamic> map) {
    return AddToCart(
      productId: map['productId']?.toInt(),
      enteredQuantity: map['enteredQuantity']?.toInt(),
      minimumQuantityNotification: map['minimumQuantityNotification'],
      allowedQuantities: List<dynamic>.from(map['allowedQuantities']),
      customerEntersPrice: map['customerEntersPrice'],
      customerEnteredPrice: map['customerEnteredPrice'],
      customerEnteredPriceRange: map['customerEnteredPriceRange'],
      disableBuyButton: map['disableBuyButton'],
      disableWishlistButton: map['disableWishlistButton'],
      isRental: map['isRental'],
      availableForPreOrder: map['availableForPreOrder'],
      preOrderAvailabilityStartDateTimeUTC:
          map['preOrderAvailabilityStartDateTimeUTC'],
      preOrderAvailabilityStartDateTimeUserTime:
          map['preOrderAvailabilityStartDateTimeUserTime'],
      updatedShoppingCartItemId: map['updatedShoppingCartItemId']?.toInt(),
      updateShoppingCartItemType: map['updateShoppingCartItemType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddToCart.fromJson(String source) =>
      AddToCart.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddToCart(productId: $productId, enteredQuantity: $enteredQuantity, minimumQuantityNotification: $minimumQuantityNotification, allowedQuantities: $allowedQuantities, customerEntersPrice: $customerEntersPrice, customerEnteredPrice: $customerEnteredPrice, customerEnteredPriceRange: $customerEnteredPriceRange, disableBuyButton: $disableBuyButton, disableWishlistButton: $disableWishlistButton, isRental: $isRental, availableForPreOrder: $availableForPreOrder, preOrderAvailabilityStartDateTimeUTC: $preOrderAvailabilityStartDateTimeUTC, preOrderAvailabilityStartDateTimeUserTime: $preOrderAvailabilityStartDateTimeUserTime, updatedShoppingCartItemId: $updatedShoppingCartItemId, updateShoppingCartItemType: $updateShoppingCartItemType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddToCart &&
        other.productId == productId &&
        other.enteredQuantity == enteredQuantity &&
        other.minimumQuantityNotification == minimumQuantityNotification &&
        listEquals(other.allowedQuantities, allowedQuantities) &&
        other.customerEntersPrice == customerEntersPrice &&
        other.customerEnteredPrice == customerEnteredPrice &&
        other.customerEnteredPriceRange == customerEnteredPriceRange &&
        other.disableBuyButton == disableBuyButton &&
        other.disableWishlistButton == disableWishlistButton &&
        other.isRental == isRental &&
        other.availableForPreOrder == availableForPreOrder &&
        other.preOrderAvailabilityStartDateTimeUTC ==
            preOrderAvailabilityStartDateTimeUTC &&
        other.preOrderAvailabilityStartDateTimeUserTime ==
            preOrderAvailabilityStartDateTimeUserTime &&
        other.updatedShoppingCartItemId == updatedShoppingCartItemId &&
        other.updateShoppingCartItemType == updateShoppingCartItemType;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        enteredQuantity.hashCode ^
        minimumQuantityNotification.hashCode ^
        allowedQuantities.hashCode ^
        customerEntersPrice.hashCode ^
        customerEnteredPrice.hashCode ^
        customerEnteredPriceRange.hashCode ^
        disableBuyButton.hashCode ^
        disableWishlistButton.hashCode ^
        isRental.hashCode ^
        availableForPreOrder.hashCode ^
        preOrderAvailabilityStartDateTimeUTC.hashCode ^
        preOrderAvailabilityStartDateTimeUserTime.hashCode ^
        updatedShoppingCartItemId.hashCode ^
        updateShoppingCartItemType.hashCode;
  }
}

class Breadcrumb {
  bool? enabled;
  int? productId;
  String? productName;
  String? productSeName;
  List<CategoryBreadcrumb>? categoryBreadcrumb;

  Breadcrumb({
    this.enabled,
    this.productId,
    this.productName,
    this.productSeName,
    this.categoryBreadcrumb,
  });

  Breadcrumb copyWith({
    bool? enabled,
    int? productId,
    String? productName,
    String? productSeName,
    List<CategoryBreadcrumb>? categoryBreadcrumb,
  }) {
    return Breadcrumb(
      enabled: enabled ?? this.enabled,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productSeName: productSeName ?? this.productSeName,
      categoryBreadcrumb: categoryBreadcrumb ?? this.categoryBreadcrumb,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'enabled': enabled,
      'productId': productId,
      'productName': productName,
      'productSeName': productSeName,
      'categoryBreadcrumb': categoryBreadcrumb?.map((x) => x.toMap()).toList(),
    };
  }

  factory Breadcrumb.fromMap(Map<String, dynamic> map) {
    return Breadcrumb(
      enabled: map['enabled'],
      productId: map['productId']?.toInt(),
      productName: map['productName'],
      productSeName: map['productSeName'],
      categoryBreadcrumb: map['categoryBreadcrumb'] != null
          ? List<CategoryBreadcrumb>.from(map['categoryBreadcrumb']
              ?.map((x) => CategoryBreadcrumb.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Breadcrumb.fromJson(String source) =>
      Breadcrumb.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Breadcrumb(enabled: $enabled, productId: $productId, productName: $productName, productSeName: $productSeName, categoryBreadcrumb: $categoryBreadcrumb)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Breadcrumb &&
        other.enabled == enabled &&
        other.productId == productId &&
        other.productName == productName &&
        other.productSeName == productSeName &&
        listEquals(other.categoryBreadcrumb, categoryBreadcrumb);
  }

  @override
  int get hashCode {
    return enabled.hashCode ^
        productId.hashCode ^
        productName.hashCode ^
        productSeName.hashCode ^
        categoryBreadcrumb.hashCode;
  }
}

class CategoryBreadcrumb {
  String? name;
  String? seName;
  dynamic numberOfProducts;
  bool? includeInTopMenu;
  List<dynamic>? subCategories;
  bool? haveSubCategories;
  dynamic route;
  int? id;

  CategoryBreadcrumb({
    this.name,
    this.seName,
    required this.numberOfProducts,
    this.includeInTopMenu,
    this.subCategories,
    this.haveSubCategories,
    required this.route,
    this.id,
  });

  CategoryBreadcrumb copyWith({
    String? name,
    String? seName,
    dynamic numberOfProducts,
    bool? includeInTopMenu,
    List<dynamic>? subCategories,
    bool? haveSubCategories,
    dynamic route,
    int? id,
  }) {
    return CategoryBreadcrumb(
      name: name ?? this.name,
      seName: seName ?? this.seName,
      numberOfProducts: numberOfProducts ?? this.numberOfProducts,
      includeInTopMenu: includeInTopMenu ?? this.includeInTopMenu,
      subCategories: subCategories ?? this.subCategories,
      haveSubCategories: haveSubCategories ?? this.haveSubCategories,
      route: route ?? this.route,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'seName': seName,
      'numberOfProducts': numberOfProducts,
      'includeInTopMenu': includeInTopMenu,
      'subCategories': subCategories,
      'haveSubCategories': haveSubCategories,
      'route': route,
      'id': id,
    };
  }

  factory CategoryBreadcrumb.fromMap(Map<String, dynamic> map) {
    return CategoryBreadcrumb(
      name: map['name'],
      seName: map['seName'],
      numberOfProducts: map['numberOfProducts'],
      includeInTopMenu: map['includeInTopMenu'],
      subCategories: List<dynamic>.from(map['subCategories']),
      haveSubCategories: map['haveSubCategories'],
      route: map['route'],
      id: map['id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryBreadcrumb.fromJson(String source) =>
      CategoryBreadcrumb.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CategoryBreadcrumb(name: $name, seName: $seName, numberOfProducts: $numberOfProducts, includeInTopMenu: $includeInTopMenu, subCategories: $subCategories, haveSubCategories: $haveSubCategories, route: $route, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryBreadcrumb &&
        other.name == name &&
        other.seName == seName &&
        other.numberOfProducts == numberOfProducts &&
        other.includeInTopMenu == includeInTopMenu &&
        listEquals(other.subCategories, subCategories) &&
        other.haveSubCategories == haveSubCategories &&
        other.route == route &&
        other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        seName.hashCode ^
        numberOfProducts.hashCode ^
        includeInTopMenu.hashCode ^
        subCategories.hashCode ^
        haveSubCategories.hashCode ^
        route.hashCode ^
        id.hashCode;
  }
}

class PictureModel {
  int? id;
  String? imageUrl;
  String? thumbImageUrl;
  String? fullSizeImageUrl;
  String? title;
  String? alternateText;

  PictureModel({
    this.id,
    this.imageUrl,
    this.thumbImageUrl,
    this.fullSizeImageUrl,
    this.title,
    this.alternateText,
  });

  PictureModel copyWith({
    int? id,
    String? imageUrl,
    String? thumbImageUrl,
    String? fullSizeImageUrl,
    String? title,
    String? alternateText,
  }) {
    return PictureModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      thumbImageUrl: thumbImageUrl ?? this.thumbImageUrl,
      fullSizeImageUrl: fullSizeImageUrl ?? this.fullSizeImageUrl,
      title: title ?? this.title,
      alternateText: alternateText ?? this.alternateText,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'thumbImageUrl': thumbImageUrl,
      'fullSizeImageUrl': fullSizeImageUrl,
      'title': title,
      'alternateText': alternateText,
    };
  }

  factory PictureModel.fromMap(Map<String, dynamic> map) {
    return PictureModel(
      id: map['id']?.toInt(),
      imageUrl: map['imageUrl'],
      thumbImageUrl: map['thumbImageUrl'],
      fullSizeImageUrl: map['fullSizeImageUrl'],
      title: map['title'],
      alternateText: map['alternateText'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PictureModel.fromJson(String source) =>
      PictureModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PictureModel(id: $id, imageUrl: $imageUrl, thumbImageUrl: $thumbImageUrl, fullSizeImageUrl: $fullSizeImageUrl, title: $title, alternateText: $alternateText)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PictureModel &&
        other.id == id &&
        other.imageUrl == imageUrl &&
        other.thumbImageUrl == thumbImageUrl &&
        other.fullSizeImageUrl == fullSizeImageUrl &&
        other.title == title &&
        other.alternateText == alternateText;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        imageUrl.hashCode ^
        thumbImageUrl.hashCode ^
        fullSizeImageUrl.hashCode ^
        title.hashCode ^
        alternateText.hashCode;
  }
}

class GiftCard {
  bool? isGiftCard;
  dynamic recipientName;
  dynamic recipientEmail;
  dynamic senderName;
  dynamic senderEmail;
  dynamic message;
  String? giftCardType;

  GiftCard({
    this.isGiftCard,
    required this.recipientName,
    required this.recipientEmail,
    required this.senderName,
    required this.senderEmail,
    required this.message,
    this.giftCardType,
  });

  GiftCard copyWith({
    bool? isGiftCard,
    dynamic recipientName,
    dynamic recipientEmail,
    dynamic senderName,
    dynamic senderEmail,
    dynamic message,
    String? giftCardType,
  }) {
    return GiftCard(
      isGiftCard: isGiftCard ?? this.isGiftCard,
      recipientName: recipientName ?? this.recipientName,
      recipientEmail: recipientEmail ?? this.recipientEmail,
      senderName: senderName ?? this.senderName,
      senderEmail: senderEmail ?? this.senderEmail,
      message: message ?? this.message,
      giftCardType: giftCardType ?? this.giftCardType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isGiftCard': isGiftCard,
      'recipientName': recipientName,
      'recipientEmail': recipientEmail,
      'senderName': senderName,
      'senderEmail': senderEmail,
      'message': message,
      'giftCardType': giftCardType,
    };
  }

  factory GiftCard.fromMap(Map<String, dynamic> map) {
    return GiftCard(
      isGiftCard: map['isGiftCard'],
      recipientName: map['recipientName'],
      recipientEmail: map['recipientEmail'],
      senderName: map['senderName'],
      senderEmail: map['senderEmail'],
      message: map['message'],
      giftCardType: map['giftCardType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GiftCard.fromJson(String source) =>
      GiftCard.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GiftCard(isGiftCard: $isGiftCard, recipientName: $recipientName, recipientEmail: $recipientEmail, senderName: $senderName, senderEmail: $senderEmail, message: $message, giftCardType: $giftCardType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GiftCard &&
        other.isGiftCard == isGiftCard &&
        other.recipientName == recipientName &&
        other.recipientEmail == recipientEmail &&
        other.senderName == senderName &&
        other.senderEmail == senderEmail &&
        other.message == message &&
        other.giftCardType == giftCardType;
  }

  @override
  int get hashCode {
    return isGiftCard.hashCode ^
        recipientName.hashCode ^
        recipientEmail.hashCode ^
        senderName.hashCode ^
        senderEmail.hashCode ^
        message.hashCode ^
        giftCardType.hashCode;
  }
}

class ProductAttribute {
  //from kixat

  String? error;

  List<Value>? valuesData = <Value>[];

  Value? currentValue;
  List<Value>? currentValueList = <Value>[];

  TextEditingController? textEditingController = TextEditingController();

  // DropDownAttributeModel? dropDownAttributeModel;
  // RadioButtonAttributeModel? radioButtonAttributeModel;
  // CheckBoxAttributeModel? checkBoxAttributeModel;
  // TextFormFieldAttributeModel? textFormFieldAttributeModel;
  // ColorSquareAttributeModel? colorSquareAttributeModel;
  // ImageSquareAttribute? imageSquareAttribute;
  // DatePickerAttributeModel? datePickerAttributeModel;
  // FileChooserAttributeModel? fileChooserAttributeModel;

  //from kixat

  int? productId;
  int? productAttributeId;
  String? name;
  String? description;
  String? textPrompt;
  bool? isRequired;
  String? defaultValue;
  dynamic selectedDay;
  dynamic selectedMonth;
  dynamic selectedYear;
  bool? hasCondition;
  List<String>? allowedFileExtensions;
  int? attributeControlType;
  int? maxLength;
  int? minLength;
  List<Value>? values;
  int? id;

  ProductAttribute({
    this.productId,
    this.productAttributeId,
    this.name,
    this.description,
    this.textPrompt,
    this.isRequired,
    this.defaultValue,
    required this.selectedDay,
    required this.selectedMonth,
    required this.selectedYear,
    this.hasCondition,
    this.allowedFileExtensions,
    this.attributeControlType,
    this.values,
    this.maxLength,
    this.minLength,
    this.id,
  });

  ProductAttribute copyWith({
    int? productId,
    int? productAttributeId,
    String? name,
    String? description,
    String? textPrompt,
    bool? isRequired,
    String? defaultValue,
    dynamic selectedDay,
    dynamic selectedMonth,
    dynamic selectedYear,
    bool? hasCondition,
    List<String>? allowedFileExtensions,
    int? attributeControlType,
    int? maxLength,
    int? minLength,
    List<Value>? values,
    int? id,
  }) {
    return ProductAttribute(
      productId: productId ?? this.productId,
      productAttributeId: productAttributeId ?? this.productAttributeId,
      name: name ?? this.name,
      description: description ?? this.description,
      textPrompt: textPrompt ?? this.textPrompt,
      isRequired: isRequired ?? this.isRequired,
      defaultValue: defaultValue ?? this.defaultValue,
      selectedDay: selectedDay ?? this.selectedDay,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      selectedYear: selectedYear ?? this.selectedYear,
      hasCondition: hasCondition ?? this.hasCondition,
      allowedFileExtensions:
          allowedFileExtensions ?? this.allowedFileExtensions,
      attributeControlType: attributeControlType ?? this.attributeControlType,
      maxLength: maxLength ?? this.maxLength,
      minLength: minLength ?? this.minLength,
      values: values ?? this.values,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productAttributeId': productAttributeId,
      'name': name,
      'description': description,
      'textPrompt': textPrompt,
      'isRequired': isRequired,
      'defaultValue': defaultValue,
      'selectedDay': selectedDay,
      'selectedMonth': selectedMonth,
      'selectedYear': selectedYear,
      'hasCondition': hasCondition,
      'allowedFileExtensions': allowedFileExtensions,
      'attributeControlType': attributeControlType,
      'maxLength': maxLength,
      'minLength': minLength,
      'values': values?.map((x) => x.toMap()).toList(),
      'id': id,
    };
  }

  factory ProductAttribute.fromMap(Map<String, dynamic> map) {
    return ProductAttribute(
      productId: map['productId']?.toInt(),
      productAttributeId: map['productAttributeId']?.toInt(),
      name: map['name'],
      description: map['description'],
      textPrompt: map['textPrompt'],
      isRequired: map['isRequired'],
      defaultValue: map['defaultValue'],
      selectedDay: map['selectedDay'],
      selectedMonth: map['selectedMonth'],
      selectedYear: map['selectedYear'],
      hasCondition: map['hasCondition'],
      allowedFileExtensions: List<String>.from(map['allowedFileExtensions']),
      attributeControlType: map['attributeControlType']?.toInt(),
      maxLength: map['maxLength']?.toInt(),
      minLength: map['minLength']?.toInt(),
      values: map['values'] != null
          ? List<Value>.from(map['values']?.map((x) => Value.fromMap(x)))
          : null,
      id: map['id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductAttribute.fromJson(String source) =>
      ProductAttribute.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductAttribute(productId: $productId, productAttributeId: $productAttributeId, name: $name, description: $description, textPrompt: $textPrompt, isRequired: $isRequired, defaultValue: $defaultValue, selectedDay: $selectedDay, selectedMonth: $selectedMonth, selectedYear: $selectedYear, hasCondition: $hasCondition, allowedFileExtensions: $allowedFileExtensions, attributeControlType: $attributeControlType, maxLength: $maxLength, minLength: $minLength, values: $values, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductAttribute &&
        other.productId == productId &&
        other.productAttributeId == productAttributeId &&
        other.name == name &&
        other.description == description &&
        other.textPrompt == textPrompt &&
        other.isRequired == isRequired &&
        other.defaultValue == defaultValue &&
        other.selectedDay == selectedDay &&
        other.selectedMonth == selectedMonth &&
        other.selectedYear == selectedYear &&
        other.hasCondition == hasCondition &&
        listEquals(other.allowedFileExtensions, allowedFileExtensions) &&
        other.attributeControlType == attributeControlType &&
        other.maxLength == maxLength &&
        other.minLength == minLength &&
        listEquals(other.values, values) &&
        other.id == id;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        productAttributeId.hashCode ^
        name.hashCode ^
        description.hashCode ^
        textPrompt.hashCode ^
        isRequired.hashCode ^
        defaultValue.hashCode ^
        selectedDay.hashCode ^
        selectedMonth.hashCode ^
        selectedYear.hashCode ^
        hasCondition.hashCode ^
        allowedFileExtensions.hashCode ^
        attributeControlType.hashCode ^
        maxLength.hashCode ^
        minLength.hashCode ^
        values.hashCode ^
        id.hashCode;
  }
}

class Value {
  String? name;
  dynamic colorSquaresRgb;
  PictureModel? imageSquaresPictureModel;
  String? priceAdjustment;
  bool? priceAdjustmentUsePercentage;
  num? priceAdjustmentValue;
  bool? isPreSelected;
  int? pictureId;
  bool? customerEntersQty;
  int? quantity;
  int? id;

  Value({
    this.name,
    required this.colorSquaresRgb,
    this.imageSquaresPictureModel,
    this.priceAdjustment,
    this.priceAdjustmentUsePercentage,
    this.priceAdjustmentValue,
    this.isPreSelected,
    this.pictureId,
    this.customerEntersQty,
    this.quantity,
    this.id,
  });

  Value copyWith({
    String? name,
    dynamic colorSquaresRgb,
    PictureModel? imageSquaresPictureModel,
    String? priceAdjustment,
    bool? priceAdjustmentUsePercentage,
    num? priceAdjustmentValue,
    bool? isPreSelected,
    int? pictureId,
    bool? customerEntersQty,
    int? quantity,
    int? id,
  }) {
    return Value(
      name: name ?? this.name,
      colorSquaresRgb: colorSquaresRgb ?? this.colorSquaresRgb,
      imageSquaresPictureModel:
          imageSquaresPictureModel ?? this.imageSquaresPictureModel,
      priceAdjustment: priceAdjustment ?? this.priceAdjustment,
      priceAdjustmentUsePercentage:
          priceAdjustmentUsePercentage ?? this.priceAdjustmentUsePercentage,
      priceAdjustmentValue: priceAdjustmentValue ?? this.priceAdjustmentValue,
      isPreSelected: isPreSelected ?? this.isPreSelected,
      pictureId: pictureId ?? this.pictureId,
      customerEntersQty: customerEntersQty ?? this.customerEntersQty,
      quantity: quantity ?? this.quantity,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'colorSquaresRgb': colorSquaresRgb,
      'imageSquaresPictureModel': imageSquaresPictureModel?.toMap(),
      'priceAdjustment': priceAdjustment,
      'priceAdjustmentUsePercentage': priceAdjustmentUsePercentage,
      'priceAdjustmentValue': priceAdjustmentValue,
      'isPreSelected': isPreSelected,
      'pictureId': pictureId,
      'customerEntersQty': customerEntersQty,
      'quantity': quantity,
      'id': id,
    };
  }

  factory Value.fromMap(Map<String, dynamic> map) {
    return Value(
      name: map['name'],
      colorSquaresRgb: map['colorSquaresRgb'],
      imageSquaresPictureModel: map['imageSquaresPictureModel'] != null
          ? PictureModel.fromMap(map['imageSquaresPictureModel'])
          : null,
      priceAdjustment: map['priceAdjustment'],
      priceAdjustmentUsePercentage: map['priceAdjustmentUsePercentage'],
      priceAdjustmentValue: map['priceAdjustmentValue'],
      isPreSelected: map['isPreSelected'],
      pictureId: map['pictureId']?.toInt(),
      customerEntersQty: map['customerEntersQty'],
      quantity: map['quantity']?.toInt(),
      id: map['id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Value.fromJson(String source) => Value.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Value(name: $name, colorSquaresRgb: $colorSquaresRgb, imageSquaresPictureModel: $imageSquaresPictureModel, priceAdjustment: $priceAdjustment, priceAdjustmentUsePercentage: $priceAdjustmentUsePercentage, priceAdjustmentValue: $priceAdjustmentValue, isPreSelected: $isPreSelected, pictureId: $pictureId, customerEntersQty: $customerEntersQty, quantity: $quantity, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Value &&
        other.name == name &&
        other.colorSquaresRgb == colorSquaresRgb &&
        other.imageSquaresPictureModel == imageSquaresPictureModel &&
        other.priceAdjustment == priceAdjustment &&
        other.priceAdjustmentUsePercentage == priceAdjustmentUsePercentage &&
        other.priceAdjustmentValue == priceAdjustmentValue &&
        other.isPreSelected == isPreSelected &&
        other.pictureId == pictureId &&
        other.customerEntersQty == customerEntersQty &&
        other.quantity == quantity &&
        other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        colorSquaresRgb.hashCode ^
        imageSquaresPictureModel.hashCode ^
        priceAdjustment.hashCode ^
        priceAdjustmentUsePercentage.hashCode ^
        priceAdjustmentValue.hashCode ^
        isPreSelected.hashCode ^
        pictureId.hashCode ^
        customerEntersQty.hashCode ^
        quantity.hashCode ^
        id.hashCode;
  }
}

class ProductEstimateShipping {
  int? productId;
  int? requestDelay;
  bool? enabled;
  dynamic countryId;
  dynamic stateProvinceId;
  dynamic zipPostalCode;
  bool? useCity;
  dynamic city;
  List<Available>? availableCountries;
  List<Available>? availableStates;

  ProductEstimateShipping({
    this.productId,
    this.requestDelay,
    this.enabled,
    required this.countryId,
    required this.stateProvinceId,
    required this.zipPostalCode,
    this.useCity,
    required this.city,
    this.availableCountries,
    this.availableStates,
  });

  ProductEstimateShipping copyWith({
    int? productId,
    int? requestDelay,
    bool? enabled,
    dynamic countryId,
    dynamic stateProvinceId,
    dynamic zipPostalCode,
    bool? useCity,
    dynamic city,
    List<Available>? availableCountries,
    List<Available>? availableStates,
  }) {
    return ProductEstimateShipping(
      productId: productId ?? this.productId,
      requestDelay: requestDelay ?? this.requestDelay,
      enabled: enabled ?? this.enabled,
      countryId: countryId ?? this.countryId,
      stateProvinceId: stateProvinceId ?? this.stateProvinceId,
      zipPostalCode: zipPostalCode ?? this.zipPostalCode,
      useCity: useCity ?? this.useCity,
      city: city ?? this.city,
      availableCountries: availableCountries ?? this.availableCountries,
      availableStates: availableStates ?? this.availableStates,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'requestDelay': requestDelay,
      'enabled': enabled,
      'countryId': countryId,
      'stateProvinceId': stateProvinceId,
      'zipPostalCode': zipPostalCode,
      'useCity': useCity,
      'city': city,
      'availableCountries': availableCountries?.map((x) => x.toMap()).toList(),
      'availableStates': availableStates?.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductEstimateShipping.fromMap(Map<String, dynamic> map) {
    return ProductEstimateShipping(
      productId: map['productId']?.toInt(),
      requestDelay: map['requestDelay']?.toInt(),
      enabled: map['enabled'],
      countryId: map['countryId'],
      stateProvinceId: map['stateProvinceId'],
      zipPostalCode: map['zipPostalCode'],
      useCity: map['useCity'],
      city: map['city'],
      availableCountries: map['availableCountries'] != null
          ? List<Available>.from(
              map['availableCountries']?.map((x) => Available.fromMap(x)))
          : null,
      availableStates: map['availableStates'] != null
          ? List<Available>.from(
              map['availableStates']?.map((x) => Available.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductEstimateShipping.fromJson(String source) =>
      ProductEstimateShipping.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductEstimateShipping(productId: $productId, requestDelay: $requestDelay, enabled: $enabled, countryId: $countryId, stateProvinceId: $stateProvinceId, zipPostalCode: $zipPostalCode, useCity: $useCity, city: $city, availableCountries: $availableCountries, availableStates: $availableStates)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductEstimateShipping &&
        other.productId == productId &&
        other.requestDelay == requestDelay &&
        other.enabled == enabled &&
        other.countryId == countryId &&
        other.stateProvinceId == stateProvinceId &&
        other.zipPostalCode == zipPostalCode &&
        other.useCity == useCity &&
        other.city == city &&
        listEquals(other.availableCountries, availableCountries) &&
        listEquals(other.availableStates, availableStates);
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        requestDelay.hashCode ^
        enabled.hashCode ^
        countryId.hashCode ^
        stateProvinceId.hashCode ^
        zipPostalCode.hashCode ^
        useCity.hashCode ^
        city.hashCode ^
        availableCountries.hashCode ^
        availableStates.hashCode;
  }
}

class Available {
  bool? disabled;
  dynamic group;
  bool? selected;
  String? text;
  String? value;
  Available({
    this.disabled,
    required this.group,
    this.selected,
    this.text,
    this.value,
  });

  Available copyWith({
    bool? disabled,
    dynamic group,
    bool? selected,
    String? text,
    String? value,
  }) {
    return Available(
      disabled: disabled ?? this.disabled,
      group: group ?? this.group,
      selected: selected ?? this.selected,
      text: text ?? this.text,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'disabled': disabled,
      'group': group,
      'selected': selected,
      'text': text,
      'value': value,
    };
  }

  factory Available.fromMap(Map<String, dynamic> map) {
    return Available(
      disabled: map['disabled'],
      group: map['group'],
      selected: map['selected'],
      text: map['text'],
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Available.fromJson(String source) =>
      Available.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Available(disabled: $disabled, group: $group, selected: $selected, text: $text, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Available &&
        other.disabled == disabled &&
        other.group == group &&
        other.selected == selected &&
        other.text == text &&
        other.value == value;
  }

  @override
  int get hashCode {
    return disabled.hashCode ^
        group.hashCode ^
        selected.hashCode ^
        text.hashCode ^
        value.hashCode;
  }
}

class ProductPrice {
  String? currencyCode;
  dynamic oldPrice;
  String? price;
  dynamic priceWithDiscount;
  num? priceValue;
  bool? customerEntersPrice;
  bool? callForPrice;
  int? productId;
  bool? hidePrices;
  bool? isRental;
  dynamic rentalPrice;
  bool? displayTaxShippingInfo;
  dynamic basePricePAngV;

  ProductPrice({
    this.currencyCode,
    required this.oldPrice,
    this.price,
    required this.priceWithDiscount,
    this.priceValue,
    this.customerEntersPrice,
    this.callForPrice,
    this.productId,
    this.hidePrices,
    this.isRental,
    required this.rentalPrice,
    this.displayTaxShippingInfo,
    required this.basePricePAngV,
  });

  ProductPrice copyWith({
    String? currencyCode,
    dynamic oldPrice,
    String? price,
    dynamic priceWithDiscount,
    num? priceValue,
    bool? customerEntersPrice,
    bool? callForPrice,
    int? productId,
    bool? hidePrices,
    bool? isRental,
    dynamic rentalPrice,
    bool? displayTaxShippingInfo,
    dynamic basePricePAngV,
  }) {
    return ProductPrice(
      currencyCode: currencyCode ?? this.currencyCode,
      oldPrice: oldPrice ?? this.oldPrice,
      price: price ?? this.price,
      priceWithDiscount: priceWithDiscount ?? this.priceWithDiscount,
      priceValue: priceValue ?? this.priceValue,
      customerEntersPrice: customerEntersPrice ?? this.customerEntersPrice,
      callForPrice: callForPrice ?? this.callForPrice,
      productId: productId ?? this.productId,
      hidePrices: hidePrices ?? this.hidePrices,
      isRental: isRental ?? this.isRental,
      rentalPrice: rentalPrice ?? this.rentalPrice,
      displayTaxShippingInfo:
          displayTaxShippingInfo ?? this.displayTaxShippingInfo,
      basePricePAngV: basePricePAngV ?? this.basePricePAngV,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'currencyCode': currencyCode,
      'oldPrice': oldPrice,
      'price': price,
      'priceWithDiscount': priceWithDiscount,
      'priceValue': priceValue,
      'customerEntersPrice': customerEntersPrice,
      'callForPrice': callForPrice,
      'productId': productId,
      'hidePrices': hidePrices,
      'isRental': isRental,
      'rentalPrice': rentalPrice,
      'displayTaxShippingInfo': displayTaxShippingInfo,
      'basePricePAngV': basePricePAngV,
    };
  }

  factory ProductPrice.fromMap(Map<String, dynamic> map) {
    return ProductPrice(
      currencyCode: map['currencyCode'],
      oldPrice: map['oldPrice'],
      price: map['price'],
      priceWithDiscount: map['priceWithDiscount'],
      priceValue: map['priceValue'],
      customerEntersPrice: map['customerEntersPrice'],
      callForPrice: map['callForPrice'],
      productId: map['productId']?.toInt(),
      hidePrices: map['hidePrices'],
      isRental: map['isRental'],
      rentalPrice: map['rentalPrice'],
      displayTaxShippingInfo: map['displayTaxShippingInfo'],
      basePricePAngV: map['basePricePAngV'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductPrice.fromJson(String source) =>
      ProductPrice.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductPrice(currencyCode: $currencyCode, oldPrice: $oldPrice, price: $price, priceWithDiscount: $priceWithDiscount, priceValue: $priceValue, customerEntersPrice: $customerEntersPrice, callForPrice: $callForPrice, productId: $productId, hidePrices: $hidePrices, isRental: $isRental, rentalPrice: $rentalPrice, displayTaxShippingInfo: $displayTaxShippingInfo, basePricePAngV: $basePricePAngV)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductPrice &&
        other.currencyCode == currencyCode &&
        other.oldPrice == oldPrice &&
        other.price == price &&
        other.priceWithDiscount == priceWithDiscount &&
        other.priceValue == priceValue &&
        other.customerEntersPrice == customerEntersPrice &&
        other.callForPrice == callForPrice &&
        other.productId == productId &&
        other.hidePrices == hidePrices &&
        other.isRental == isRental &&
        other.rentalPrice == rentalPrice &&
        other.displayTaxShippingInfo == displayTaxShippingInfo &&
        other.basePricePAngV == basePricePAngV;
  }

  @override
  int get hashCode {
    return currencyCode.hashCode ^
        oldPrice.hashCode ^
        price.hashCode ^
        priceWithDiscount.hashCode ^
        priceValue.hashCode ^
        customerEntersPrice.hashCode ^
        callForPrice.hashCode ^
        productId.hashCode ^
        hidePrices.hashCode ^
        isRental.hashCode ^
        rentalPrice.hashCode ^
        displayTaxShippingInfo.hashCode ^
        basePricePAngV.hashCode;
  }
}

class ProductReviewOverview {
  int? productId;
  num? ratingSum;
  num? totalReviews;
  bool? allowCustomerReviews;
  bool? canAddNewReview;

  ProductReviewOverview({
    this.productId,
    this.ratingSum,
    this.totalReviews,
    this.allowCustomerReviews,
    this.canAddNewReview,
  });

  ProductReviewOverview copyWith({
    int? productId,
    num? ratingSum,
    num? totalReviews,
    bool? allowCustomerReviews,
    bool? canAddNewReview,
  }) {
    return ProductReviewOverview(
      productId: productId ?? this.productId,
      ratingSum: ratingSum ?? this.ratingSum,
      totalReviews: totalReviews ?? this.totalReviews,
      allowCustomerReviews: allowCustomerReviews ?? this.allowCustomerReviews,
      canAddNewReview: canAddNewReview ?? this.canAddNewReview,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'ratingSum': ratingSum,
      'totalReviews': totalReviews,
      'allowCustomerReviews': allowCustomerReviews,
      'canAddNewReview': canAddNewReview,
    };
  }

  factory ProductReviewOverview.fromMap(Map<String, dynamic> map) {
    return ProductReviewOverview(
      productId: map['productId']?.toInt(),
      ratingSum: map['ratingSum'],
      totalReviews: map['totalReviews'],
      allowCustomerReviews: map['allowCustomerReviews'],
      canAddNewReview: map['canAddNewReview'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductReviewOverview.fromJson(String source) =>
      ProductReviewOverview.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductReviewOverview(productId: $productId, ratingSum: $ratingSum, totalReviews: $totalReviews, allowCustomerReviews: $allowCustomerReviews, canAddNewReview: $canAddNewReview)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductReviewOverview &&
        other.productId == productId &&
        other.ratingSum == ratingSum &&
        other.totalReviews == totalReviews &&
        other.allowCustomerReviews == allowCustomerReviews &&
        other.canAddNewReview == canAddNewReview;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        ratingSum.hashCode ^
        totalReviews.hashCode ^
        allowCustomerReviews.hashCode ^
        canAddNewReview.hashCode;
  }
}

class ProductSpecificationModel {
  final List<ProductSpecificAttributeModel>? groups;
  ProductSpecificationModel({
    this.groups,
  });

  ProductSpecificationModel copyWith({
    List<ProductSpecificAttributeModel>? groups,
  }) {
    return ProductSpecificationModel(
      groups: groups ?? this.groups,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'groups': groups?.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductSpecificationModel.fromMap(Map<String, dynamic> map) {
    return ProductSpecificationModel(
      groups: map['groups'] != null
          ? List<ProductSpecificAttributeModel>.from(map['groups']
              ?.map((x) => ProductSpecificAttributeModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductSpecificationModel.fromJson(String source) =>
      ProductSpecificationModel.fromMap(json.decode(source));

  @override
  String toString() => 'ProductSpecificationModel(groups: $groups)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductSpecificationModel &&
        listEquals(other.groups, groups);
  }

  @override
  int get hashCode => groups.hashCode;
}

class ProductSpecificAttributeModel {
  String? name;
  List<SpecificAttributeModel>? attributes;
  int? id;
  ProductSpecificAttributeModel({
    this.name,
    this.attributes,
    this.id,
  });

  ProductSpecificAttributeModel copyWith({
    String? name,
    List<SpecificAttributeModel>? attributes,
    int? id,
  }) {
    return ProductSpecificAttributeModel(
      name: name ?? this.name,
      attributes: attributes ?? this.attributes,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'attributes': attributes?.map((x) => x.toMap()).toList(),
      'id': id,
    };
  }

  factory ProductSpecificAttributeModel.fromMap(Map<String, dynamic> map) {
    return ProductSpecificAttributeModel(
      name: map['name'],
      attributes: map['attributes'] != null
          ? List<SpecificAttributeModel>.from(
              map['attributes']?.map((x) => SpecificAttributeModel.fromMap(x)))
          : null,
      id: map['id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductSpecificAttributeModel.fromJson(String source) =>
      ProductSpecificAttributeModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ProductSpecificAttributeModel(name: $name, attributes: $attributes, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductSpecificAttributeModel &&
        other.name == name &&
        listEquals(other.attributes, attributes) &&
        other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ attributes.hashCode ^ id.hashCode;
}

class SpecificAttributeModel {
  int? attributeTypeId;
  String? valueRaw;
  String? colorSquaresRgb;
  SpecificAttributeModel({
    this.attributeTypeId,
    this.valueRaw,
    this.colorSquaresRgb,
  });

  SpecificAttributeModel copyWith({
    int? attributeTypeId,
    String? valueRaw,
    String? colorSquaresRgb,
  }) {
    return SpecificAttributeModel(
      attributeTypeId: attributeTypeId ?? this.attributeTypeId,
      valueRaw: valueRaw ?? this.valueRaw,
      colorSquaresRgb: colorSquaresRgb ?? this.colorSquaresRgb,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'attributeTypeId': attributeTypeId,
      'valueRaw': valueRaw,
      'colorSquaresRgb': colorSquaresRgb,
    };
  }

  factory SpecificAttributeModel.fromMap(Map<String, dynamic> map) {
    return SpecificAttributeModel(
      attributeTypeId: map['attributeTypeId']?.toInt(),
      valueRaw: map['valueRaw'],
      colorSquaresRgb: map['colorSquaresRgb'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SpecificAttributeModel.fromJson(String source) =>
      SpecificAttributeModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'SpecificAttributeModel(attributeTypeId: $attributeTypeId, valueRaw: $valueRaw, colorSquaresRgb: $colorSquaresRgb)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SpecificAttributeModel &&
        other.attributeTypeId == attributeTypeId &&
        other.valueRaw == valueRaw &&
        other.colorSquaresRgb == colorSquaresRgb;
  }

  @override
  int get hashCode =>
      attributeTypeId.hashCode ^ valueRaw.hashCode ^ colorSquaresRgb.hashCode;
}

class VendorModel {
  dynamic name;
  List<dynamic>? attributes;
  int? id;

  String? seName;
  VendorModel({
    required this.name,
    this.attributes,
    this.id,
    this.seName,
  });

  VendorModel copyWith({
    dynamic name,
    List<dynamic>? attributes,
    int? id,
    String? seName,
  }) {
    return VendorModel(
      name: name ?? this.name,
      attributes: attributes ?? this.attributes,
      id: id ?? this.id,
      seName: seName ?? this.seName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'attributes': attributes,
      'id': id,
      'seName': seName,
    };
  }

  factory VendorModel.fromMap(Map<String, dynamic> map) {
    return VendorModel(
      name: map['name'],
      attributes: map['attributes'] == null
          ? null
          : List<dynamic>.from(map['attributes']),
      id: map['id']?.toInt(),
      seName: map['seName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VendorModel.fromJson(String source) =>
      VendorModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VendorModel(name: $name, attributes: $attributes, id: $id, seName: $seName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VendorModel &&
        other.name == name &&
        listEquals(other.attributes, attributes) &&
        other.id == id &&
        other.seName == seName;
  }

  @override
  int get hashCode {
    return name.hashCode ^ attributes.hashCode ^ id.hashCode ^ seName.hashCode;
  }
}

class CustomProperties {
  List<RelatedProductModel>? relatedProducts;
  CustomProperties({
    this.relatedProducts,
  });

  CustomProperties copyWith({
    List<RelatedProductModel>? relatedProducts,
  }) {
    return CustomProperties(
      relatedProducts: relatedProducts ?? this.relatedProducts,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'RelatedProducts': relatedProducts?.map((x) => x.toMap()).toList(),
    };
  }

  factory CustomProperties.fromMap(Map<String, dynamic> map) {
    return CustomProperties(
      relatedProducts: map['RelatedProducts'] != null
          ? List<RelatedProductModel>.from(map['RelatedProducts']
              ?.map((x) => RelatedProductModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomProperties.fromJson(String source) =>
      CustomProperties.fromMap(json.decode(source));

  @override
  String toString() => 'CustomProperties(RelatedProducts: $relatedProducts)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomProperties &&
        listEquals(other.relatedProducts, relatedProducts);
  }

  @override
  int get hashCode => relatedProducts.hashCode;
}

class RelatedProductModel {
  String? name;
  String? shortDescription;
  String? fullDescription;
  String? seName;
  String? sku;
  dynamic productType;
  bool? markAsNew;
  bool? isOutOfStock;
  bool? isSubscribedToBackInStock;
  num? discountPercentage;
  RelatedProductPrice? productPrice;
  RelatedPictureModel? defaultPictureModel;
  ProductSpecificationModel? productSpecificationModel;
  int? id;
  CustomProperties? customProperties;
  RelatedProductModel({
    this.name,
    this.shortDescription,
    this.fullDescription,
    this.seName,
    this.sku,
    required this.productType,
    this.markAsNew,
    this.isOutOfStock,
    this.isSubscribedToBackInStock,
    this.discountPercentage,
    this.productPrice,
    this.defaultPictureModel,
    this.productSpecificationModel,
    this.id,
    this.customProperties,
  });

  RelatedProductModel copyWith({
    String? name,
    String? shortDescription,
    String? fullDescription,
    String? seName,
    String? sku,
    dynamic productType,
    bool? markAsNew,
    bool? isOutOfStock,
    bool? isSubscribedToBackInStock,
    num? discountPercentage,
    RelatedProductPrice? productPrice,
    RelatedPictureModel? defaultPictureModel,
    ProductSpecificationModel? productSpecificationModel,
    int? id,
    CustomProperties? customProperties,
  }) {
    return RelatedProductModel(
      name: name ?? this.name,
      shortDescription: shortDescription ?? this.shortDescription,
      fullDescription: fullDescription ?? this.fullDescription,
      seName: seName ?? this.seName,
      sku: sku ?? this.sku,
      productType: productType ?? this.productType,
      markAsNew: markAsNew ?? this.markAsNew,
      isOutOfStock: isOutOfStock ?? this.isOutOfStock,
      isSubscribedToBackInStock:
          isSubscribedToBackInStock ?? this.isSubscribedToBackInStock,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      productPrice: productPrice ?? this.productPrice,
      defaultPictureModel: defaultPictureModel ?? this.defaultPictureModel,
      productSpecificationModel:
          productSpecificationModel ?? this.productSpecificationModel,
      id: id ?? this.id,
      customProperties: customProperties ?? this.customProperties,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'shortDescription': shortDescription,
      'fullDescription': fullDescription,
      'seName': seName,
      'sku': sku,
      'productType': productType,
      'markAsNew': markAsNew,
      'isOutOfStock': isOutOfStock,
      'isSubscribedToBackInStock': isSubscribedToBackInStock,
      'discountPercentage': discountPercentage,
      'productPrice': productPrice?.toMap(),
      'defaultPictureModel': defaultPictureModel?.toMap(),
      'productSpecificationModel': productSpecificationModel?.toMap(),
      'id': id,
      'customProperties': customProperties?.toMap(),
    };
  }

  factory RelatedProductModel.fromMap(Map<String, dynamic> map) {
    return RelatedProductModel(
      name: map['name'],
      shortDescription: map['shortDescription'],
      fullDescription: map['fullDescription'],
      seName: map['seName'],
      sku: map['sku'],
      productType: map['productType'],
      markAsNew: map['markAsNew'],
      isOutOfStock: map['isOutOfStock'],
      isSubscribedToBackInStock: map['isSubscribedToBackInStock'],
      discountPercentage: map['discountPercentage'],
      productPrice: map['productPrice'] != null
          ? RelatedProductPrice.fromMap(map['productPrice'])
          : null,
      defaultPictureModel: map['defaultPictureModel'] != null
          ? RelatedPictureModel.fromMap(map['defaultPictureModel'])
          : null,
      productSpecificationModel: map['productSpecificationModel'] != null
          ? ProductSpecificationModel.fromMap(map['productSpecificationModel'])
          : null,
      id: map['id']?.toInt(),
      customProperties: map['customProperties'] != null
          ? CustomProperties.fromMap(map['customProperties'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RelatedProductModel.fromJson(String source) =>
      RelatedProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RelatedProductModel(name: $name, shortDescription: $shortDescription, fullDescription: $fullDescription, seName: $seName, sku: $sku, productType: $productType, markAsNew: $markAsNew, isOutOfStock: $isOutOfStock, isSubscribedToBackInStock: $isSubscribedToBackInStock, discountPercentage: $discountPercentage, productPrice: $productPrice, defaultPictureModel: $defaultPictureModel, productSpecificationModel: $productSpecificationModel, id: $id, customProperties: $customProperties)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RelatedProductModel &&
        other.name == name &&
        other.shortDescription == shortDescription &&
        other.fullDescription == fullDescription &&
        other.seName == seName &&
        other.sku == sku &&
        other.productType == productType &&
        other.markAsNew == markAsNew &&
        other.isOutOfStock == isOutOfStock &&
        other.isSubscribedToBackInStock == isSubscribedToBackInStock &&
        other.discountPercentage == discountPercentage &&
        other.productPrice == productPrice &&
        other.defaultPictureModel == defaultPictureModel &&
        other.productSpecificationModel == productSpecificationModel &&
        other.id == id &&
        other.customProperties == customProperties;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        shortDescription.hashCode ^
        fullDescription.hashCode ^
        seName.hashCode ^
        sku.hashCode ^
        productType.hashCode ^
        markAsNew.hashCode ^
        isOutOfStock.hashCode ^
        isSubscribedToBackInStock.hashCode ^
        discountPercentage.hashCode ^
        productPrice.hashCode ^
        defaultPictureModel.hashCode ^
        productSpecificationModel.hashCode ^
        id.hashCode ^
        customProperties.hashCode;
  }
}

class RelatedPictureModel {
  final String? imageUrl;
  final String? thumbImageUrl;
  final String? fullSizeImageUrl;
  final String? title;
  final String? alternateText;
  RelatedPictureModel({
    this.imageUrl,
    this.thumbImageUrl,
    this.fullSizeImageUrl,
    this.title,
    this.alternateText,
  });

  RelatedPictureModel copyWith({
    String? imageUrl,
    String? thumbImageUrl,
    String? fullSizeImageUrl,
    String? title,
    String? alternateText,
  }) {
    return RelatedPictureModel(
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

  factory RelatedPictureModel.fromMap(Map<String, dynamic> map) {
    return RelatedPictureModel(
      imageUrl: map['ImageUrl'],
      thumbImageUrl: map['ThumbImageUrl'],
      fullSizeImageUrl: map['FullSizeImageUrl'],
      title: map['Title'],
      alternateText: map['AlternateText'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RelatedPictureModel.fromJson(String source) =>
      RelatedPictureModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RelatedPictureModel(ImageUrl: $imageUrl, ThumbImageUrl: $thumbImageUrl, FullSizeImageUrl: $fullSizeImageUrl, Title: $title, AlternateText: $alternateText)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RelatedPictureModel &&
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

class RelatedProductPrice {
  dynamic OldPrice;
  String? price;
  num? PriceValue;
  bool? AvailableForPreOrder;
  bool? IsRental;
  bool? DisableAddToCompareListButton;
  bool? DisableBuyButton;
  bool? DisableWishlistButton;
  bool? DisplayTaxShippingInfo;
  dynamic BasePricePAngV;
  RelatedProductPrice({
    required this.OldPrice,
    this.price,
    this.PriceValue,
    this.AvailableForPreOrder,
    this.IsRental,
    this.DisableAddToCompareListButton,
    this.DisableBuyButton,
    this.DisableWishlistButton,
    this.DisplayTaxShippingInfo,
    required this.BasePricePAngV,
  });

  RelatedProductPrice copyWith({
    dynamic OldPrice,
    String? price,
    num? PriceValue,
    bool? AvailableForPreOrder,
    bool? IsRental,
    bool? DisableAddToCompareListButton,
    bool? DisableBuyButton,
    bool? DisableWishlistButton,
    bool? DisplayTaxShippingInfo,
    dynamic BasePricePAngV,
  }) {
    return RelatedProductPrice(
      OldPrice: OldPrice ?? this.OldPrice,
      price: price ?? this.price,
      PriceValue: PriceValue ?? this.PriceValue,
      AvailableForPreOrder: AvailableForPreOrder ?? this.AvailableForPreOrder,
      IsRental: IsRental ?? this.IsRental,
      DisableAddToCompareListButton:
          DisableAddToCompareListButton ?? this.DisableAddToCompareListButton,
      DisableBuyButton: DisableBuyButton ?? this.DisableBuyButton,
      DisableWishlistButton:
          DisableWishlistButton ?? this.DisableWishlistButton,
      DisplayTaxShippingInfo:
          DisplayTaxShippingInfo ?? this.DisplayTaxShippingInfo,
      BasePricePAngV: BasePricePAngV ?? this.BasePricePAngV,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'OldPrice': OldPrice,
      'Price': price,
      'PriceValue': PriceValue,
      'AvailableForPreOrder': AvailableForPreOrder,
      'IsRental': IsRental,
      'DisableAddToCompareListButton': DisableAddToCompareListButton,
      'DisableBuyButton': DisableBuyButton,
      'DisableWishlistButton': DisableWishlistButton,
      'DisplayTaxShippingInfo': DisplayTaxShippingInfo,
      'BasePricePAngV': BasePricePAngV,
    };
  }

  factory RelatedProductPrice.fromMap(Map<String, dynamic> map) {
    return RelatedProductPrice(
      OldPrice: map['OldPrice'],
      price: map['Price'],
      PriceValue: map['PriceValue'],
      AvailableForPreOrder: map['AvailableForPreOrder'],
      IsRental: map['IsRental'],
      DisableAddToCompareListButton: map['DisableAddToCompareListButton'],
      DisableBuyButton: map['DisableBuyButton'],
      DisableWishlistButton: map['DisableWishlistButton'],
      DisplayTaxShippingInfo: map['DisplayTaxShippingInfo'],
      BasePricePAngV: map['BasePricePAngV'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RelatedProductPrice.fromJson(String source) =>
      RelatedProductPrice.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RelatedProductPrice(OldPrice: $OldPrice, Price: $price, PriceValue: $PriceValue, AvailableForPreOrder: $AvailableForPreOrder, IsRental: $IsRental, DisableAddToCompareListButton: $DisableAddToCompareListButton, DisableBuyButton: $DisableBuyButton, DisableWishlistButton: $DisableWishlistButton, DisplayTaxShippingInfo: $DisplayTaxShippingInfo, BasePricePAngV: $BasePricePAngV)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RelatedProductPrice &&
        other.OldPrice == OldPrice &&
        other.price == price &&
        other.PriceValue == PriceValue &&
        other.AvailableForPreOrder == AvailableForPreOrder &&
        other.IsRental == IsRental &&
        other.DisableAddToCompareListButton == DisableAddToCompareListButton &&
        other.DisableBuyButton == DisableBuyButton &&
        other.DisableWishlistButton == DisableWishlistButton &&
        other.DisplayTaxShippingInfo == DisplayTaxShippingInfo &&
        other.BasePricePAngV == BasePricePAngV;
  }

  @override
  int get hashCode {
    return OldPrice.hashCode ^
        price.hashCode ^
        PriceValue.hashCode ^
        AvailableForPreOrder.hashCode ^
        IsRental.hashCode ^
        DisableAddToCompareListButton.hashCode ^
        DisableBuyButton.hashCode ^
        DisableWishlistButton.hashCode ^
        DisplayTaxShippingInfo.hashCode ^
        BasePricePAngV.hashCode;
  }
}
