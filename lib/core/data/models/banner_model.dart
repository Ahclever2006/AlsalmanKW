import 'dart:convert';

import 'package:flutter/foundation.dart';

class HomeBannerModel {
  List<BannerModel>? data;
  int? statusCode;
  String? message;
  bool? isSuccess;
  List<String>? errors;
  HomeBannerModel({
    this.data,
    this.statusCode,
    this.message,
    this.isSuccess,
    this.errors,
  });

  HomeBannerModel copyWith({
    List<BannerModel>? data,
    int? statusCode,
    String? message,
    bool? isSuccess,
    List<String>? errors,
  }) {
    return HomeBannerModel(
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

  factory HomeBannerModel.fromMap(Map<String, dynamic> map) {
    return HomeBannerModel(
      data: map['Data'] != null
          ? List<BannerModel>.from(
              map['Data']?.map((x) => BannerModel.fromMap(x)))
          : null,
      statusCode: map['StatusCode']?.toInt(),
      message: map['Message'],
      isSuccess: map['IsSuccess'],
      errors: List<String>.from(map['Errors']),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeBannerModel.fromJson(String source) =>
      HomeBannerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HomeBannerModel(Data: $data, StatusCode: $statusCode, Message: $message, IsSuccess: $isSuccess, Errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeBannerModel &&
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

class BannerModel {
  int? id;
  int? categoryId;
  dynamic productId;
  int? vendorId;
  String? fileName;
  String? title;
  String? text;
  String? link;
  String? altText;
  String? tag;
  int? displayOrder;
  String? bannerTypeName;
  String? bannerType;
  String? fileUrl;
  dynamic entityId;
  dynamic entityName;
  BannerModel({
    this.id,
    this.categoryId,
    required this.productId,
    this.vendorId,
    this.fileName,
    this.title,
    this.text,
    this.link,
    this.altText,
    this.tag,
    this.displayOrder,
    this.bannerTypeName,
    this.bannerType,
    this.fileUrl,
    required this.entityId,
    required this.entityName,
  });

  BannerModel copyWith({
    int? id,
    int? categoryId,
    dynamic productId,
    int? vendorId,
    String? fileName,
    String? title,
    String? text,
    String? link,
    String? altText,
    String? tag,
    int? displayOrder,
    String? bannerTypeName,
    String? bannerType,
    String? fileUrl,
    dynamic entityId,
    dynamic entityName,
  }) {
    return BannerModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      productId: productId ?? this.productId,
      vendorId: vendorId ?? this.vendorId,
      fileName: fileName ?? this.fileName,
      title: title ?? this.title,
      text: text ?? this.text,
      link: link ?? this.link,
      altText: altText ?? this.altText,
      tag: tag ?? this.tag,
      displayOrder: displayOrder ?? this.displayOrder,
      bannerTypeName: bannerTypeName ?? this.bannerTypeName,
      bannerType: bannerType ?? this.bannerType,
      fileUrl: fileUrl ?? this.fileUrl,
      entityId: entityId ?? this.entityId,
      entityName: entityName ?? this.entityName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'CategoryId': categoryId,
      'ProductId': productId,
      'VendorId': vendorId,
      'FileName': fileName,
      'Title': title,
      'Text': text,
      'Link': link,
      'AltText': altText,
      'Tag': tag,
      'DisplayOrder': displayOrder,
      'AttachmentType': bannerTypeName,
      'BannerType': bannerType,
      'FileUrl': fileUrl,
      'EntityId': entityId,
      'EntityName': entityName,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['Id']?.toInt(),
      categoryId: map['CategoryId']?.toInt(),
      productId: map['ProductId'],
      vendorId: map['VendorId']?.toInt(),
      fileName: map['FileName'],
      title: map['Title'],
      text: map['Text'],
      link: map['Link'],
      altText: map['AltText'],
      tag: map['Tag'],
      displayOrder: map['DisplayOrder']?.toInt(),
      bannerTypeName: map['AttachmentType'],
      bannerType: map['BannerType'],
      fileUrl: map['FileUrl'],
      entityId: map['EntityId'],
      entityName: map['EntityName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BannerModel.fromJson(String source) =>
      BannerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Data(Id: $id, CategoryId: $categoryId, ProductId: $productId, VendorId: $vendorId, FileName: $fileName, Title: $title, Text: $text, Link: $link, AltText: $altText, Tag: $tag, DisplayOrder: $displayOrder, AttachmentType: $bannerTypeName, BannerType: $bannerType, FileUrl: $fileUrl, EntityId: $entityId, EntityName: $entityName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BannerModel &&
        other.id == id &&
        other.categoryId == categoryId &&
        other.productId == productId &&
        other.vendorId == vendorId &&
        other.fileName == fileName &&
        other.title == title &&
        other.text == text &&
        other.link == link &&
        other.altText == altText &&
        other.tag == tag &&
        other.displayOrder == displayOrder &&
        other.bannerTypeName == bannerTypeName &&
        other.bannerType == bannerType &&
        other.fileUrl == fileUrl &&
        other.entityId == entityId &&
        other.entityName == entityName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        categoryId.hashCode ^
        productId.hashCode ^
        vendorId.hashCode ^
        fileName.hashCode ^
        title.hashCode ^
        text.hashCode ^
        link.hashCode ^
        altText.hashCode ^
        tag.hashCode ^
        displayOrder.hashCode ^
        bannerTypeName.hashCode ^
        bannerType.hashCode ^
        fileUrl.hashCode ^
        entityId.hashCode ^
        entityName.hashCode;
  }
}
