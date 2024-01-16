import 'dart:convert';

import '../../../../core/data/models/home_categ_model.dart';
import '../../../../core/data/models/home_section_product_model.dart';

class FavoriteProductModel {
  int? Id;
  String? Name;
  String? ShortDescription;
  String? FullDescription;
  String? SeName;
  String? Sku;
  String? ProductType;
  bool? IsInWishlist;
  bool? IsInShoppingCart;
  bool? HasRequiredAttribute;
  bool? IsOutOfStock;
  bool? IsSubscribedToBackInStock;
  num? DiscountPercentage;
  PictureModel? DefaultPictureModel;
  ProductPrice? productPrice;
  FavoriteProductModel({
    this.Id,
    this.Name,
    this.ShortDescription,
    this.FullDescription,
    this.SeName,
    this.Sku,
    this.ProductType,
    this.IsInWishlist,
    this.IsInShoppingCart,
    this.HasRequiredAttribute,
    this.IsOutOfStock,
    this.IsSubscribedToBackInStock,
    this.DiscountPercentage,
    this.DefaultPictureModel,
    this.productPrice,
  });

  FavoriteProductModel copyWith({
    int? Id,
    String? Name,
    String? ShortDescription,
    String? FullDescription,
    String? SeName,
    String? Sku,
    String? ProductType,
    bool? IsInWishlist,
    bool? IsInShoppingCart,
    bool? HasRequiredAttribute,
    bool? IsOutOfStock,
    bool? IsSubscribedToBackInStock,
    num? DiscountPercentage,
    PictureModel? DefaultPictureModel,
    ProductPrice? productPrice,
  }) {
    return FavoriteProductModel(
      Id: Id ?? this.Id,
      Name: Name ?? this.Name,
      ShortDescription: ShortDescription ?? this.ShortDescription,
      FullDescription: FullDescription ?? this.FullDescription,
      SeName: SeName ?? this.SeName,
      Sku: Sku ?? this.Sku,
      ProductType: ProductType ?? this.ProductType,
      IsInWishlist: IsInWishlist ?? this.IsInWishlist,
      IsInShoppingCart: IsInShoppingCart ?? this.IsInShoppingCart,
      HasRequiredAttribute: HasRequiredAttribute ?? this.HasRequiredAttribute,
      IsOutOfStock: IsOutOfStock ?? this.IsOutOfStock,
      IsSubscribedToBackInStock:
          IsSubscribedToBackInStock ?? this.IsSubscribedToBackInStock,
      DiscountPercentage: DiscountPercentage ?? this.DiscountPercentage,
      DefaultPictureModel: DefaultPictureModel ?? this.DefaultPictureModel,
      productPrice: productPrice ?? this.productPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': Id,
      'Name': Name,
      'ShortDescription': ShortDescription,
      'FullDescription': FullDescription,
      'SeName': SeName,
      'Sku': Sku,
      'ProductType': ProductType,
      'IsInWishlist': IsInWishlist,
      'IsInShoppingCart': IsInShoppingCart,
      'HasRequiredAttribute': HasRequiredAttribute,
      'IsOutOfStock': IsOutOfStock,
      'IsSubscribedToBackInStock': IsSubscribedToBackInStock,
      'DiscountPercentage': DiscountPercentage,
      'DefaultPictureModel': DefaultPictureModel?.toMap(),
      'ProductPrice': productPrice?.toMap(),
    };
  }

  factory FavoriteProductModel.fromMap(Map<String, dynamic> map) {
    return FavoriteProductModel(
      Id: map['Id']?.toInt(),
      Name: map['Name'],
      ShortDescription: map['ShortDescription'],
      FullDescription: map['FullDescription'],
      SeName: map['SeName'],
      Sku: map['Sku'],
      ProductType: map['ProductType'],
      IsInWishlist: map['IsInWishlist'],
      IsInShoppingCart: map['IsInShoppingCart'],
      HasRequiredAttribute: map['HasRequiredAttribute'],
      IsOutOfStock: map['IsOutOfStock'],
      IsSubscribedToBackInStock: map['IsSubscribedToBackInStock'],
      DiscountPercentage: map['DiscountPercentage'],
      DefaultPictureModel: map['DefaultPictureModel'] != null
          ? PictureModel.fromMap(map['DefaultPictureModel'])
          : null,
      productPrice: map['ProductPrice'] != null
          ? ProductPrice.fromMap(map['ProductPrice'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteProductModel.fromJson(String source) =>
      FavoriteProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FavoriteProductModel(Id: $Id, Name: $Name, ShortDescription: $ShortDescription, FullDescription: $FullDescription, SeName: $SeName, Sku: $Sku, ProductType: $ProductType, IsInWishlist: $IsInWishlist, IsInShoppingCart: $IsInShoppingCart, HasRequiredAttribute: $HasRequiredAttribute, IsOutOfStock: $IsOutOfStock, IsSubscribedToBackInStock: $IsSubscribedToBackInStock, DiscountPercentage: $DiscountPercentage, DefaultPictureModel: $DefaultPictureModel, ProductPrice: $productPrice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavoriteProductModel &&
        other.Id == Id &&
        other.Name == Name &&
        other.ShortDescription == ShortDescription &&
        other.FullDescription == FullDescription &&
        other.SeName == SeName &&
        other.Sku == Sku &&
        other.ProductType == ProductType &&
        other.IsInWishlist == IsInWishlist &&
        other.IsInShoppingCart == IsInShoppingCart &&
        other.HasRequiredAttribute == HasRequiredAttribute &&
        other.IsOutOfStock == IsOutOfStock &&
        other.IsSubscribedToBackInStock == IsSubscribedToBackInStock &&
        other.DiscountPercentage == DiscountPercentage &&
        other.DefaultPictureModel == DefaultPictureModel &&
        other.productPrice == productPrice;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        Name.hashCode ^
        ShortDescription.hashCode ^
        FullDescription.hashCode ^
        SeName.hashCode ^
        Sku.hashCode ^
        ProductType.hashCode ^
        IsInWishlist.hashCode ^
        IsInShoppingCart.hashCode ^
        HasRequiredAttribute.hashCode ^
        IsOutOfStock.hashCode ^
        IsSubscribedToBackInStock.hashCode ^
        DiscountPercentage.hashCode ^
        DefaultPictureModel.hashCode ^
        productPrice.hashCode;
  }
}
