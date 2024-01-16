import 'dart:convert';

import 'package:flutter/foundation.dart';

class MyOrdersModel {
  List<Order>? orders;
  List<dynamic>? recurringOrders;
  List<dynamic>? recurringPaymentErrors;
  MyOrdersModel({
    this.orders,
    this.recurringOrders,
    this.recurringPaymentErrors,
  });

  MyOrdersModel copyWith({
    List<Order>? orders,
    List<dynamic>? recurringOrders,
    List<dynamic>? recurringPaymentErrors,
  }) {
    return MyOrdersModel(
      orders: orders ?? this.orders,
      recurringOrders: recurringOrders ?? this.recurringOrders,
      recurringPaymentErrors:
          recurringPaymentErrors ?? this.recurringPaymentErrors,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orders': orders?.map((x) => x.toMap()).toList(),
      'recurring_orders': recurringOrders,
      'recurring_payment_errors': recurringPaymentErrors,
    };
  }

  factory MyOrdersModel.fromMap(Map<String, dynamic> map) {
    return MyOrdersModel(
      orders: map['orders'] != null
          ? List<Order>.from(map['orders']?.map((x) => Order.fromMap(x)))
          : null,
      recurringOrders: map['recurring_orders'] != null
          ? List<dynamic>.from(map['recurring_orders'])
          : null,
      recurringPaymentErrors: map['recurring_payment_errors'] != null
          ? List<dynamic>.from(map['recurring_payment_errors'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyOrdersModel.fromJson(String source) =>
      MyOrdersModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'MyOrdersModel(orders: $orders, recurring_orders: $recurringOrders, recurring_payment_errors: $recurringPaymentErrors)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MyOrdersModel &&
        listEquals(other.orders, orders) &&
        listEquals(other.recurringOrders, recurringOrders) &&
        listEquals(other.recurringPaymentErrors, recurringPaymentErrors);
  }

  @override
  int get hashCode =>
      orders.hashCode ^
      recurringOrders.hashCode ^
      recurringPaymentErrors.hashCode;
}

class Order {
  String? customOrderNumber;
  String? orderTotal;
  bool? isReturnRequestAllowed;
  int? orderStatusEnum;
  String? orderStatus;
  String? paymentStatus;
  String? shippingStatus;
  FirstProductPicture? firstProductPicture;
  String? createdOn;
  int? id;
  Order({
    this.customOrderNumber,
    this.orderTotal,
    this.isReturnRequestAllowed,
    this.orderStatusEnum,
    this.orderStatus,
    this.paymentStatus,
    this.shippingStatus,
    this.firstProductPicture,
    this.createdOn,
    this.id,
  });

  Order copyWith({
    String? customOrderNumber,
    String? orderTotal,
    bool? isReturnRequestAllowed,
    int? orderStatusEnum,
    String? orderStatus,
    String? paymentStatus,
    String? shippingStatus,
    FirstProductPicture? firstProductPicture,
    String? createdOn,
    int? id,
  }) {
    return Order(
      customOrderNumber: customOrderNumber ?? this.customOrderNumber,
      orderTotal: orderTotal ?? this.orderTotal,
      isReturnRequestAllowed:
          isReturnRequestAllowed ?? this.isReturnRequestAllowed,
      orderStatusEnum: orderStatusEnum ?? this.orderStatusEnum,
      orderStatus: orderStatus ?? this.orderStatus,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      shippingStatus: shippingStatus ?? this.shippingStatus,
      firstProductPicture: firstProductPicture ?? this.firstProductPicture,
      createdOn: createdOn ?? this.createdOn,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customOrderNumber': customOrderNumber,
      'orderTotal': orderTotal,
      'isReturnRequestAllowed': isReturnRequestAllowed,
      'orderStatusEnum': orderStatusEnum,
      'orderStatus': orderStatus,
      'paymentStatus': paymentStatus,
      'shippingStatus': shippingStatus,
      'firstProductPicture': firstProductPicture?.toMap(),
      'createdOn': createdOn,
      'id': id,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      customOrderNumber: map['customOrderNumber'],
      orderTotal: map['orderTotal'],
      isReturnRequestAllowed: map['isReturnRequestAllowed'],
      orderStatusEnum: map['orderStatusEnum']?.toInt(),
      orderStatus: map['orderStatus'],
      paymentStatus: map['paymentStatus'],
      shippingStatus: map['shippingStatus'],
      firstProductPicture: map['firstProductPicture'] != null
          ? FirstProductPicture.fromMap(map['firstProductPicture'])
          : null,
      createdOn: map['createdOn'],
      id: map['id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(customOrderNumber: $customOrderNumber, orderTotal: $orderTotal, isReturnRequestAllowed: $isReturnRequestAllowed, orderStatusEnum: $orderStatusEnum, orderStatus: $orderStatus, paymentStatus: $paymentStatus, shippingStatus: $shippingStatus, firstProductPicture: $firstProductPicture, createdOn: $createdOn, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.customOrderNumber == customOrderNumber &&
        other.orderTotal == orderTotal &&
        other.isReturnRequestAllowed == isReturnRequestAllowed &&
        other.orderStatusEnum == orderStatusEnum &&
        other.orderStatus == orderStatus &&
        other.paymentStatus == paymentStatus &&
        other.shippingStatus == shippingStatus &&
        other.firstProductPicture == firstProductPicture &&
        other.createdOn == createdOn &&
        other.id == id;
  }

  @override
  int get hashCode {
    return customOrderNumber.hashCode ^
        orderTotal.hashCode ^
        isReturnRequestAllowed.hashCode ^
        orderStatusEnum.hashCode ^
        orderStatus.hashCode ^
        paymentStatus.hashCode ^
        shippingStatus.hashCode ^
        firstProductPicture.hashCode ^
        createdOn.hashCode ^
        id.hashCode;
  }
}

class FirstProductPicture {
  String? imageUrl;
  dynamic thumbImageUrl;
  String? fullSizeImageUrl;
  String? title;
  String? alternateText;
  FirstProductPicture({
    this.imageUrl,
    this.thumbImageUrl,
    this.fullSizeImageUrl,
    this.title,
    this.alternateText,
  });

  FirstProductPicture copyWith({
    String? imageUrl,
    dynamic thumbImageUrl,
    String? fullSizeImageUrl,
    String? title,
    String? alternateText,
  }) {
    return FirstProductPicture(
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

  factory FirstProductPicture.fromMap(Map<String, dynamic> map) {
    return FirstProductPicture(
      imageUrl: map['ImageUrl'],
      thumbImageUrl: map['ThumbImageUrl'],
      fullSizeImageUrl: map['FullSizeImageUrl'],
      title: map['Title'],
      alternateText: map['AlternateText'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FirstProductPicture.fromJson(String source) =>
      FirstProductPicture.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FirstProductPicture(ImageUrl: $imageUrl, ThumbImageUrl: $thumbImageUrl, FullSizeImageUrl: $fullSizeImageUrl, Title: $title, AlternateText: $alternateText)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FirstProductPicture &&
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
