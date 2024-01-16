import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../../features/address/data/models/addresses_model.dart';

import '../../../../core/data/models/home_carousal_collection_model.dart';
import '../../../../core/data/models/payment_summary.dart';

class OrderDetailsModel {
  Data? data;
  int? statusCode;
  String? message;
  bool? isSuccess;
  List<dynamic>? errors;
  OrderDetailsModel({
    this.data,
    this.statusCode,
    this.message,
    this.isSuccess,
    this.errors,
  });

  OrderDetailsModel copyWith({
    Data? data,
    int? statusCode,
    String? message,
    bool? isSuccess,
    List<dynamic>? errors,
  }) {
    return OrderDetailsModel(
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

  factory OrderDetailsModel.fromMap(Map<String, dynamic> map) {
    return OrderDetailsModel(
      data: map['Data'] != null ? Data.fromMap(map['Data']) : null,
      statusCode: map['StatusCode']?.toInt(),
      message: map['Message'],
      isSuccess: map['IsSuccess'],
      errors: map['Errors'] != null ? List<dynamic>.from(map['Errors']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetailsModel.fromJson(String source) =>
      OrderDetailsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderDetailsModel(Data: $data, StatusCode: $statusCode, Message: $message, IsSuccess: $isSuccess, Errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderDetailsModel &&
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
  bool? printMode;
  bool? pdfInvoiceDisabled;
  String? customOrderNumber;
  String? createdOn;
  String? orderStatus;
  bool? isReOrderAllowed;
  bool? isReturnRequestAllowed;
  bool? isShippable;
  bool? pickupInStore;
  Address? pickupAddress;
  String? shippingStatus;
  Address? shippingAddress;
  String? shippingMethod;
  List<dynamic>? shipments;
  Address? billingAddress;
  dynamic vatNumber;
  String? paymentMethod;
  String? paymentMethodStatus;
  bool? canRePostProcessPayment;
  String? orderSubtotal;
  dynamic orderSubTotalDiscount;
  String? orderShipping;
  dynamic paymentMethodAdditionalFee;
  String? checkoutAttributeInfo;
  bool? pricesIncludeTax;
  bool? displayTaxShippingInfo;
  String? tax;
  List<TaxRate>? taxRates;
  bool? displayTax;
  bool? displayTaxRates;
  String? orderTotalDiscount;
  int? redeemedRewardPoints;
  dynamic redeemedRewardPointsAmount;
  String? orderTotal;
  List<dynamic>? giftCards;
  bool? showSku;
  List<Items>? items;
  List<dynamic>? orderNotes;
  bool? showVendorName;
  int? id;
  Data({
    this.printMode,
    this.pdfInvoiceDisabled,
    this.customOrderNumber,
    this.createdOn,
    this.orderStatus,
    this.isReOrderAllowed,
    this.isReturnRequestAllowed,
    this.isShippable,
    this.pickupInStore,
    this.pickupAddress,
    this.shippingStatus,
    this.shippingAddress,
    this.shippingMethod,
    this.shipments,
    this.billingAddress,
    required this.vatNumber,
    this.paymentMethod,
    this.paymentMethodStatus,
    this.canRePostProcessPayment,
    this.orderSubtotal,
    required this.orderSubTotalDiscount,
    this.orderShipping,
    required this.paymentMethodAdditionalFee,
    this.checkoutAttributeInfo,
    this.pricesIncludeTax,
    this.displayTaxShippingInfo,
    this.tax,
    this.taxRates,
    this.displayTax,
    this.displayTaxRates,
    this.orderTotalDiscount,
    this.redeemedRewardPoints,
    required this.redeemedRewardPointsAmount,
    this.orderTotal,
    this.giftCards,
    this.showSku,
    this.items,
    this.orderNotes,
    this.showVendorName,
    this.id,
  });

  Data copyWith({
    bool? printMode,
    bool? pdfInvoiceDisabled,
    String? customOrderNumber,
    String? createdOn,
    String? orderStatus,
    bool? isReOrderAllowed,
    bool? isReturnRequestAllowed,
    bool? isShippable,
    bool? pickupInStore,
    Address? pickupAddress,
    String? shippingStatus,
    Address? shippingAddress,
    String? shippingMethod,
    List<dynamic>? shipments,
    Address? billingAddress,
    dynamic vatNumber,
    String? paymentMethod,
    String? paymentMethodStatus,
    bool? canRePostProcessPayment,
    String? orderSubtotal,
    dynamic orderSubTotalDiscount,
    String? orderShipping,
    dynamic paymentMethodAdditionalFee,
    String? checkoutAttributeInfo,
    bool? pricesIncludeTax,
    bool? displayTaxShippingInfo,
    String? tax,
    List<TaxRate>? taxRates,
    bool? displayTax,
    bool? displayTaxRates,
    String? orderTotalDiscount,
    int? redeemedRewardPoints,
    dynamic redeemedRewardPointsAmount,
    String? orderTotal,
    List<dynamic>? giftCards,
    bool? showSku,
    List<Items>? items,
    List<dynamic>? orderNotes,
    bool? showVendorName,
    int? id,
  }) {
    return Data(
      printMode: printMode ?? this.printMode,
      pdfInvoiceDisabled: pdfInvoiceDisabled ?? this.pdfInvoiceDisabled,
      customOrderNumber: customOrderNumber ?? this.customOrderNumber,
      createdOn: createdOn ?? this.createdOn,
      orderStatus: orderStatus ?? this.orderStatus,
      isReOrderAllowed: isReOrderAllowed ?? this.isReOrderAllowed,
      isReturnRequestAllowed:
          isReturnRequestAllowed ?? this.isReturnRequestAllowed,
      isShippable: isShippable ?? this.isShippable,
      pickupInStore: pickupInStore ?? this.pickupInStore,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      shippingStatus: shippingStatus ?? this.shippingStatus,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      shippingMethod: shippingMethod ?? this.shippingMethod,
      shipments: shipments ?? this.shipments,
      billingAddress: billingAddress ?? this.billingAddress,
      vatNumber: vatNumber ?? this.vatNumber,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentMethodStatus: paymentMethodStatus ?? this.paymentMethodStatus,
      canRePostProcessPayment:
          canRePostProcessPayment ?? this.canRePostProcessPayment,
      orderSubtotal: orderSubtotal ?? this.orderSubtotal,
      orderSubTotalDiscount:
          orderSubTotalDiscount ?? this.orderSubTotalDiscount,
      orderShipping: orderShipping ?? this.orderShipping,
      paymentMethodAdditionalFee:
          paymentMethodAdditionalFee ?? this.paymentMethodAdditionalFee,
      checkoutAttributeInfo:
          checkoutAttributeInfo ?? this.checkoutAttributeInfo,
      pricesIncludeTax: pricesIncludeTax ?? this.pricesIncludeTax,
      displayTaxShippingInfo:
          displayTaxShippingInfo ?? this.displayTaxShippingInfo,
      tax: tax ?? this.tax,
      taxRates: taxRates ?? this.taxRates,
      displayTax: displayTax ?? this.displayTax,
      displayTaxRates: displayTaxRates ?? this.displayTaxRates,
      orderTotalDiscount: orderTotalDiscount ?? this.orderTotalDiscount,
      redeemedRewardPoints: redeemedRewardPoints ?? this.redeemedRewardPoints,
      redeemedRewardPointsAmount:
          redeemedRewardPointsAmount ?? this.redeemedRewardPointsAmount,
      orderTotal: orderTotal ?? this.orderTotal,
      giftCards: giftCards ?? this.giftCards,
      showSku: showSku ?? this.showSku,
      items: items ?? this.items,
      orderNotes: orderNotes ?? this.orderNotes,
      showVendorName: showVendorName ?? this.showVendorName,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'print_mode': printMode,
      'pdf_invoice_disabled': pdfInvoiceDisabled,
      'custom_order_number': customOrderNumber,
      'created_on': createdOn,
      'order_status': orderStatus,
      'is_re_order_allowed': isReOrderAllowed,
      'is_return_request_allowed': isReturnRequestAllowed,
      'is_shippable': isShippable,
      'pickup_in_store': pickupInStore,
      'pickup_address': pickupAddress?.toMap(),
      'shipping_status': shippingStatus,
      'shipping_address': shippingAddress?.toMap(),
      'shipping_method': shippingMethod,
      'shipments': shipments,
      'billing_address': billingAddress?.toMap(),
      'vat_number': vatNumber,
      'payment_method': paymentMethod,
      'payment_method_status': paymentMethodStatus,
      'can_re_post_process_payment': canRePostProcessPayment,
      'order_subtotal': orderSubtotal,
      'order_sub_total_discount': orderSubTotalDiscount,
      'order_shipping': orderShipping,
      'payment_method_additional_fee': paymentMethodAdditionalFee,
      'checkout_attribute_info': checkoutAttributeInfo,
      'prices_include_tax': pricesIncludeTax,
      'display_tax_shipping_info': displayTaxShippingInfo,
      'tax': tax,
      'tax_rates': taxRates?.map((x) => x.toMap()).toList(),
      'display_tax': displayTax,
      'display_tax_rates': displayTaxRates,
      'order_total_discount': orderTotalDiscount,
      'redeemed_reward_points': redeemedRewardPoints,
      'redeemed_reward_points_amount': redeemedRewardPointsAmount,
      'order_total': orderTotal,
      'gift_cards': giftCards,
      'show_sku': showSku,
      'items': items?.map((x) => x.toMap()).toList(),
      'order_notes': orderNotes,
      'show_vendor_name': showVendorName,
      'id': id,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      printMode: map['print_mode'],
      pdfInvoiceDisabled: map['pdf_invoice_disabled'],
      customOrderNumber: map['custom_order_number'],
      createdOn: map['created_on'],
      orderStatus: map['order_status'],
      isReOrderAllowed: map['is_re_order_allowed'],
      isReturnRequestAllowed: map['is_return_request_allowed'],
      isShippable: map['is_shippable'],
      pickupInStore: map['pickup_in_store'],
      pickupAddress: map['pickup_address'] != null
          ? Address.fromMap(map['pickup_address'])
          : null,
      shippingStatus: map['shipping_status'],
      shippingAddress: map['shipping_address'] != null
          ? Address.fromMap(map['shipping_address'])
          : null,
      shippingMethod: map['shipping_method'],
      shipments: List<dynamic>.from(map['shipments']),
      billingAddress: map['billing_address'] != null
          ? Address.fromMap(map['billing_address'])
          : null,
      vatNumber: map['vat_number'],
      paymentMethod: map['payment_method'],
      paymentMethodStatus: map['payment_method_status'],
      canRePostProcessPayment: map['can_re_post_process_payment'],
      orderSubtotal: map['order_subtotal'],
      orderSubTotalDiscount: map['order_sub_total_discount'],
      orderShipping: map['order_shipping'],
      paymentMethodAdditionalFee: map['payment_method_additional_fee'],
      checkoutAttributeInfo: map['checkout_attribute_info'],
      pricesIncludeTax: map['prices_include_tax'],
      displayTaxShippingInfo: map['display_tax_shipping_info'],
      tax: map['tax'],
      taxRates: map['tax_rates'] != null
          ? List<TaxRate>.from(map['tax_rates']?.map((x) => TaxRate.fromMap(x)))
          : null,
      displayTax: map['display_tax'],
      displayTaxRates: map['display_tax_rates'],
      orderTotalDiscount: map['order_total_discount'],
      redeemedRewardPoints: map['redeemed_reward_points']?.toInt(),
      redeemedRewardPointsAmount: map['redeemed_reward_points_amount'],
      orderTotal: map['order_total'],
      giftCards: List<dynamic>.from(map['gift_cards']),
      showSku: map['show_sku'],
      items: map['items'] != null
          ? List<Items>.from(map['items']?.map((x) => Items.fromMap(x)))
          : null,
      orderNotes: List<dynamic>.from(map['order_notes']),
      showVendorName: map['show_vendor_name'],
      id: map['id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Data(print_mode: $printMode, pdf_invoice_disabled: $pdfInvoiceDisabled, custom_order_number: $customOrderNumber, created_on: $createdOn, order_status: $orderStatus, is_re_order_allowed: $isReOrderAllowed, is_return_request_allowed: $isReturnRequestAllowed, is_shippable: $isShippable, pickup_in_store: $pickupInStore, pickup_address: $pickupAddress, shipping_status: $shippingStatus, shipping_address: $shippingAddress, shipping_method: $shippingMethod, shipments: $shipments, billing_address: $billingAddress, vat_number: $vatNumber, payment_method: $paymentMethod, payment_method_status: $paymentMethodStatus, can_re_post_process_payment: $canRePostProcessPayment, order_subtotal: $orderSubtotal, order_sub_total_discount: $orderSubTotalDiscount, order_shipping: $orderShipping, payment_method_additional_fee: $paymentMethodAdditionalFee, checkout_attribute_info: $checkoutAttributeInfo, prices_include_tax: $pricesIncludeTax, display_tax_shipping_info: $displayTaxShippingInfo, tax: $tax, tax_rates: $taxRates, display_tax: $displayTax, display_tax_rates: $displayTaxRates, order_total_discount: $orderTotalDiscount, redeemed_reward_points: $redeemedRewardPoints, redeemed_reward_points_amount: $redeemedRewardPointsAmount, order_total: $orderTotal, gift_cards: $giftCards, show_sku: $showSku, items: $items, order_notes: $orderNotes, show_vendor_name: $showVendorName, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Data &&
        other.printMode == printMode &&
        other.pdfInvoiceDisabled == pdfInvoiceDisabled &&
        other.customOrderNumber == customOrderNumber &&
        other.createdOn == createdOn &&
        other.orderStatus == orderStatus &&
        other.isReOrderAllowed == isReOrderAllowed &&
        other.isReturnRequestAllowed == isReturnRequestAllowed &&
        other.isShippable == isShippable &&
        other.pickupInStore == pickupInStore &&
        other.pickupAddress == pickupAddress &&
        other.shippingStatus == shippingStatus &&
        other.shippingAddress == shippingAddress &&
        other.shippingMethod == shippingMethod &&
        listEquals(other.shipments, shipments) &&
        other.billingAddress == billingAddress &&
        other.vatNumber == vatNumber &&
        other.paymentMethod == paymentMethod &&
        other.paymentMethodStatus == paymentMethodStatus &&
        other.canRePostProcessPayment == canRePostProcessPayment &&
        other.orderSubtotal == orderSubtotal &&
        other.orderSubTotalDiscount == orderSubTotalDiscount &&
        other.orderShipping == orderShipping &&
        other.paymentMethodAdditionalFee == paymentMethodAdditionalFee &&
        other.checkoutAttributeInfo == checkoutAttributeInfo &&
        other.pricesIncludeTax == pricesIncludeTax &&
        other.displayTaxShippingInfo == displayTaxShippingInfo &&
        other.tax == tax &&
        listEquals(other.taxRates, taxRates) &&
        other.displayTax == displayTax &&
        other.displayTaxRates == displayTaxRates &&
        other.orderTotalDiscount == orderTotalDiscount &&
        other.redeemedRewardPoints == redeemedRewardPoints &&
        other.redeemedRewardPointsAmount == redeemedRewardPointsAmount &&
        other.orderTotal == orderTotal &&
        listEquals(other.giftCards, giftCards) &&
        other.showSku == showSku &&
        listEquals(other.items, items) &&
        listEquals(other.orderNotes, orderNotes) &&
        other.showVendorName == showVendorName &&
        other.id == id;
  }

  @override
  int get hashCode {
    return printMode.hashCode ^
        pdfInvoiceDisabled.hashCode ^
        customOrderNumber.hashCode ^
        createdOn.hashCode ^
        orderStatus.hashCode ^
        isReOrderAllowed.hashCode ^
        isReturnRequestAllowed.hashCode ^
        isShippable.hashCode ^
        pickupInStore.hashCode ^
        pickupAddress.hashCode ^
        shippingStatus.hashCode ^
        shippingAddress.hashCode ^
        shippingMethod.hashCode ^
        shipments.hashCode ^
        billingAddress.hashCode ^
        vatNumber.hashCode ^
        paymentMethod.hashCode ^
        paymentMethodStatus.hashCode ^
        canRePostProcessPayment.hashCode ^
        orderSubtotal.hashCode ^
        orderSubTotalDiscount.hashCode ^
        orderShipping.hashCode ^
        paymentMethodAdditionalFee.hashCode ^
        checkoutAttributeInfo.hashCode ^
        pricesIncludeTax.hashCode ^
        displayTaxShippingInfo.hashCode ^
        tax.hashCode ^
        taxRates.hashCode ^
        displayTax.hashCode ^
        displayTaxRates.hashCode ^
        orderTotalDiscount.hashCode ^
        redeemedRewardPoints.hashCode ^
        redeemedRewardPointsAmount.hashCode ^
        orderTotal.hashCode ^
        giftCards.hashCode ^
        showSku.hashCode ^
        items.hashCode ^
        orderNotes.hashCode ^
        showVendorName.hashCode ^
        id.hashCode;
  }
}

class Items {
  String? orderItemGuid;
  String? sku;
  int? productId;
  String? productName;
  String? productSeName;
  String? unitPrice;
  String? subTotal;
  int? quantity;
  String? attributeInfo;
  dynamic rentalInfo;
  String? vendorName;
  int? downloadId;
  int? licenseId;
  DefaultPictureModel? picture;
  String? shortDescription;
  int? id;
  Items({
    this.orderItemGuid,
    this.sku,
    this.productId,
    this.productName,
    this.productSeName,
    this.unitPrice,
    this.subTotal,
    this.quantity,
    this.attributeInfo,
    required this.rentalInfo,
    this.vendorName,
    this.downloadId,
    this.licenseId,
    this.picture,
    this.shortDescription,
    this.id,
  });

  Items copyWith({
    String? orderItemGuid,
    String? sku,
    int? productId,
    String? productName,
    String? productSeName,
    String? unitPrice,
    String? subTotal,
    int? quantity,
    String? attributeInfo,
    dynamic rentalInfo,
    String? vendorName,
    int? downloadId,
    int? licenseId,
    DefaultPictureModel? picture,
    String? shortDescription,
    int? id,
  }) {
    return Items(
      orderItemGuid: orderItemGuid ?? this.orderItemGuid,
      sku: sku ?? this.sku,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productSeName: productSeName ?? this.productSeName,
      unitPrice: unitPrice ?? this.unitPrice,
      subTotal: subTotal ?? this.subTotal,
      quantity: quantity ?? this.quantity,
      attributeInfo: attributeInfo ?? this.attributeInfo,
      rentalInfo: rentalInfo ?? this.rentalInfo,
      vendorName: vendorName ?? this.vendorName,
      downloadId: downloadId ?? this.downloadId,
      licenseId: licenseId ?? this.licenseId,
      picture: picture ?? this.picture,
      shortDescription: shortDescription ?? this.shortDescription,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'order_item_guid': orderItemGuid,
      'sku': sku,
      'product_id': productId,
      'product_name': productName,
      'product_se_name': productSeName,
      'unit_price': unitPrice,
      'sub_total': subTotal,
      'quantity': quantity,
      'attribute_info': attributeInfo,
      'rental_info': rentalInfo,
      'vendor_name': vendorName,
      'download_id': downloadId,
      'license_id': licenseId,
      'picture': picture?.toMap(),
      'short_description': shortDescription,
      'id': id,
    };
  }

  factory Items.fromMap(Map<String, dynamic> map) {
    return Items(
      orderItemGuid: map['order_item_guid'],
      sku: map['sku'],
      productId: map['product_id']?.toInt(),
      productName: map['product_name'],
      productSeName: map['product_se_name'],
      unitPrice: map['unit_price'],
      subTotal: map['sub_total'],
      quantity: map['quantity']?.toInt(),
      attributeInfo: map['attribute_info'],
      rentalInfo: map['rental_info'],
      vendorName: map['vendor_name'],
      downloadId: map['download_id']?.toInt(),
      licenseId: map['license_id']?.toInt(),
      picture: map['picture'] != null
          ? DefaultPictureModel.fromMap(map['picture'])
          : null,
      shortDescription: map['short_description'],
      id: map['id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Items.fromJson(String source) => Items.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Items(order_item_guid: $orderItemGuid, sku: $sku, product_id: $productId, product_name: $productName, product_se_name: $productSeName, unit_price: $unitPrice, sub_total: $subTotal, quantity: $quantity, attribute_info: $attributeInfo, rental_info: $rentalInfo, vendor_name: $vendorName, download_id: $downloadId, license_id: $licenseId, picture: $picture, short_description: $shortDescription, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Items &&
        other.orderItemGuid == orderItemGuid &&
        other.sku == sku &&
        other.productId == productId &&
        other.productName == productName &&
        other.productSeName == productSeName &&
        other.unitPrice == unitPrice &&
        other.subTotal == subTotal &&
        other.quantity == quantity &&
        other.attributeInfo == attributeInfo &&
        other.rentalInfo == rentalInfo &&
        other.vendorName == vendorName &&
        other.downloadId == downloadId &&
        other.licenseId == licenseId &&
        other.picture == picture &&
        other.shortDescription == shortDescription &&
        other.id == id;
  }

  @override
  int get hashCode {
    return orderItemGuid.hashCode ^
        sku.hashCode ^
        productId.hashCode ^
        productName.hashCode ^
        productSeName.hashCode ^
        unitPrice.hashCode ^
        subTotal.hashCode ^
        quantity.hashCode ^
        attributeInfo.hashCode ^
        rentalInfo.hashCode ^
        vendorName.hashCode ^
        downloadId.hashCode ^
        licenseId.hashCode ^
        picture.hashCode ^
        shortDescription.hashCode ^
        id.hashCode;
  }
}
