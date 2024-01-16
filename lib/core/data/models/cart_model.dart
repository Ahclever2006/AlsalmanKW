import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../features/address/data/models/addresses_model.dart';

class CartModel {
  bool? onePageCheckoutEnabled;
  bool? showSku;
  bool? showProductImages;
  bool? isEditable;
  List<Item>? items;
  List<dynamic>? checkoutAttributes;
  List<dynamic>? warnings;
  dynamic minOrderSubtotalWarning;
  bool? displayTaxShippingInfo;
  bool? termsOfServiceOnShoppingCartPage;
  bool? termsOfServiceOnOrderConfirmPage;
  bool? termsOfServicePopup;
  DiscountBox? discountBox;
  GiftCardBox? giftCardBox;
  OrderReviewData? orderReviewData;
  List<dynamic>? buttonPaymentMethodViewComponentNames;
  bool? hideCheckoutButton;
  bool? showVendorName;
  CartModel({
    this.onePageCheckoutEnabled,
    this.showSku,
    this.showProductImages,
    this.isEditable,
    this.items,
    this.checkoutAttributes,
    this.warnings,
    this.minOrderSubtotalWarning,
    this.displayTaxShippingInfo,
    this.termsOfServiceOnShoppingCartPage,
    this.termsOfServiceOnOrderConfirmPage,
    this.termsOfServicePopup,
    this.discountBox,
    this.giftCardBox,
    this.orderReviewData,
    this.buttonPaymentMethodViewComponentNames,
    this.hideCheckoutButton,
    this.showVendorName,
  });

  CartModel copyWith({
    bool? onePageCheckoutEnabled,
    bool? showSku,
    bool? showProductImages,
    bool? isEditable,
    List<Item>? items,
    List<dynamic>? checkoutAttributes,
    List<dynamic>? warnings,
    dynamic minOrderSubtotalWarning,
    bool? displayTaxShippingInfo,
    bool? termsOfServiceOnShoppingCartPage,
    bool? termsOfServiceOnOrderConfirmPage,
    bool? termsOfServicePopup,
    DiscountBox? discountBox,
    GiftCardBox? giftCardBox,
    OrderReviewData? orderReviewData,
    List<dynamic>? buttonPaymentMethodViewComponentNames,
    bool? hideCheckoutButton,
    bool? showVendorName,
  }) {
    return CartModel(
      onePageCheckoutEnabled:
          onePageCheckoutEnabled ?? this.onePageCheckoutEnabled,
      showSku: showSku ?? this.showSku,
      showProductImages: showProductImages ?? this.showProductImages,
      isEditable: isEditable ?? this.isEditable,
      items: items ?? this.items,
      checkoutAttributes: checkoutAttributes ?? this.checkoutAttributes,
      warnings: warnings ?? this.warnings,
      minOrderSubtotalWarning:
          minOrderSubtotalWarning ?? this.minOrderSubtotalWarning,
      displayTaxShippingInfo:
          displayTaxShippingInfo ?? this.displayTaxShippingInfo,
      termsOfServiceOnShoppingCartPage: termsOfServiceOnShoppingCartPage ??
          this.termsOfServiceOnShoppingCartPage,
      termsOfServiceOnOrderConfirmPage: termsOfServiceOnOrderConfirmPage ??
          this.termsOfServiceOnOrderConfirmPage,
      termsOfServicePopup: termsOfServicePopup ?? this.termsOfServicePopup,
      discountBox: discountBox ?? this.discountBox,
      giftCardBox: giftCardBox ?? this.giftCardBox,
      orderReviewData: orderReviewData ?? this.orderReviewData,
      buttonPaymentMethodViewComponentNames:
          buttonPaymentMethodViewComponentNames ??
              this.buttonPaymentMethodViewComponentNames,
      hideCheckoutButton: hideCheckoutButton ?? this.hideCheckoutButton,
      showVendorName: showVendorName ?? this.showVendorName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'one_page_checkout_enabled': onePageCheckoutEnabled,
      'show_sku': showSku,
      'show_product_images': showProductImages,
      'is_editable': isEditable,
      'items': items?.map((x) => x.toMap()).toList(),
      'checkout_attributes': checkoutAttributes,
      'warnings': warnings,
      'min_order_subtotal_warning': minOrderSubtotalWarning,
      'display_tax_shipping_info': displayTaxShippingInfo,
      'terms_of_service_on_shopping_cart_page':
          termsOfServiceOnShoppingCartPage,
      'terms_of_service_on_order_confirm_page':
          termsOfServiceOnOrderConfirmPage,
      'terms_of_service_popup': termsOfServicePopup,
      'discount_box': discountBox?.toMap(),
      'gift_card_box': giftCardBox?.toMap(),
      'order_review_data': orderReviewData?.toMap(),
      'button_payment_method_view_component_names':
          buttonPaymentMethodViewComponentNames,
      'hide_checkout_button': hideCheckoutButton,
      'show_vendor_name': showVendorName,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      onePageCheckoutEnabled: map['one_page_checkout_enabled'],
      showSku: map['show_sku'],
      showProductImages: map['show_product_images'],
      isEditable: map['is_editable'],
      items: map['items'] != null
          ? List<Item>.from(map['items']?.map((x) => Item.fromMap(x)))
          : null,
      checkoutAttributes: List<dynamic>.from(map['checkout_attributes']),
      warnings: List<dynamic>.from(map['warnings']),
      minOrderSubtotalWarning: map['min_order_subtotal_warning'],
      displayTaxShippingInfo: map['display_tax_shipping_info'],
      termsOfServiceOnShoppingCartPage:
          map['terms_of_service_on_shopping_cart_page'],
      termsOfServiceOnOrderConfirmPage:
          map['terms_of_service_on_order_confirm_page'],
      termsOfServicePopup: map['terms_of_service_popup'],
      discountBox: map['discount_box'] != null
          ? DiscountBox.fromMap(map['discount_box'])
          : null,
      giftCardBox: map['gift_card_box'] != null
          ? GiftCardBox.fromMap(map['gift_card_box'])
          : null,
      orderReviewData: map['order_review_data'] != null
          ? OrderReviewData.fromMap(map['order_review_data'])
          : null,
      buttonPaymentMethodViewComponentNames:
          List<dynamic>.from(map['button_payment_method_view_component_names']),
      hideCheckoutButton: map['hide_checkout_button'],
      showVendorName: map['show_vendor_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CartModel(one_page_checkout_enabled: $onePageCheckoutEnabled, show_sku: $showSku, show_product_images: $showProductImages, is_editable: $isEditable, items: $items, checkout_attributes: $checkoutAttributes, warnings: $warnings, min_order_subtotal_warning: $minOrderSubtotalWarning, display_tax_shipping_info: $displayTaxShippingInfo, terms_of_service_on_shopping_cart_page: $termsOfServiceOnShoppingCartPage, terms_of_service_on_order_confirm_page: $termsOfServiceOnOrderConfirmPage, terms_of_service_popup: $termsOfServicePopup, discount_box: $discountBox, gift_card_box: $giftCardBox, order_review_data: $orderReviewData, button_payment_method_view_component_names: $buttonPaymentMethodViewComponentNames, hide_checkout_button: $hideCheckoutButton, show_vendor_name: $showVendorName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartModel &&
        other.onePageCheckoutEnabled == onePageCheckoutEnabled &&
        other.showSku == showSku &&
        other.showProductImages == showProductImages &&
        other.isEditable == isEditable &&
        listEquals(other.items, items) &&
        listEquals(other.checkoutAttributes, checkoutAttributes) &&
        listEquals(other.warnings, warnings) &&
        other.minOrderSubtotalWarning == minOrderSubtotalWarning &&
        other.displayTaxShippingInfo == displayTaxShippingInfo &&
        other.termsOfServiceOnShoppingCartPage ==
            termsOfServiceOnShoppingCartPage &&
        other.termsOfServiceOnOrderConfirmPage ==
            termsOfServiceOnOrderConfirmPage &&
        other.termsOfServicePopup == termsOfServicePopup &&
        other.discountBox == discountBox &&
        other.giftCardBox == giftCardBox &&
        other.orderReviewData == orderReviewData &&
        listEquals(other.buttonPaymentMethodViewComponentNames,
            buttonPaymentMethodViewComponentNames) &&
        other.hideCheckoutButton == hideCheckoutButton &&
        other.showVendorName == showVendorName;
  }

  @override
  int get hashCode {
    return onePageCheckoutEnabled.hashCode ^
        showSku.hashCode ^
        showProductImages.hashCode ^
        isEditable.hashCode ^
        items.hashCode ^
        checkoutAttributes.hashCode ^
        warnings.hashCode ^
        minOrderSubtotalWarning.hashCode ^
        displayTaxShippingInfo.hashCode ^
        termsOfServiceOnShoppingCartPage.hashCode ^
        termsOfServiceOnOrderConfirmPage.hashCode ^
        termsOfServicePopup.hashCode ^
        discountBox.hashCode ^
        giftCardBox.hashCode ^
        orderReviewData.hashCode ^
        buttonPaymentMethodViewComponentNames.hashCode ^
        hideCheckoutButton.hashCode ^
        showVendorName.hashCode;
  }
}

class DiscountBox {
  List<CouponCodeData>? appliedDiscountsWithCodes;
  bool? display;
  List<dynamic>? messages;
  bool? isApplied;
  DiscountBox({
    this.appliedDiscountsWithCodes,
    this.display,
    this.messages,
    this.isApplied,
  });

  DiscountBox copyWith({
    List<CouponCodeData>? appliedDiscountsWithCodes,
    bool? display,
    List<dynamic>? messages,
    bool? isApplied,
  }) {
    return DiscountBox(
      appliedDiscountsWithCodes:
          appliedDiscountsWithCodes ?? this.appliedDiscountsWithCodes,
      display: display ?? this.display,
      messages: messages ?? this.messages,
      isApplied: isApplied ?? this.isApplied,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'applied_discounts_with_codes':
          appliedDiscountsWithCodes?.map((x) => x.toMap()).toList(),
      'display': display,
      'messages': messages,
      'is_applied': isApplied,
    };
  }

  factory DiscountBox.fromMap(Map<String, dynamic> map) {
    return DiscountBox(
      appliedDiscountsWithCodes: map['applied_discounts_with_codes'] != null
          ? List<CouponCodeData>.from(map['applied_discounts_with_codes']
              ?.map((x) => CouponCodeData.fromMap(x)))
          : null,
      display: map['display'],
      messages: List<dynamic>.from(map['messages']),
      isApplied: map['is_applied'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DiscountBox.fromJson(String source) =>
      DiscountBox.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DiscountBox(appliedDiscountsWithCodes: $appliedDiscountsWithCodes, display: $display, messages: $messages, isApplied: $isApplied)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DiscountBox &&
        listEquals(
            other.appliedDiscountsWithCodes, appliedDiscountsWithCodes) &&
        other.display == display &&
        listEquals(other.messages, messages) &&
        other.isApplied == isApplied;
  }

  @override
  int get hashCode {
    return appliedDiscountsWithCodes.hashCode ^
        display.hashCode ^
        messages.hashCode ^
        isApplied.hashCode;
  }
}

class CouponCodeData {
  final String? couponCode;
  final int? id;
  CouponCodeData({
    this.couponCode,
    this.id,
  });

  CouponCodeData copyWith({
    String? couponCode,
    int? id,
  }) {
    return CouponCodeData(
      couponCode: couponCode ?? this.couponCode,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'coupon_code': couponCode,
      'id': id,
    };
  }

  factory CouponCodeData.fromMap(Map<String, dynamic> map) {
    return CouponCodeData(
      couponCode: map['coupon_code'],
      id: map['id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CouponCodeData.fromJson(String source) =>
      CouponCodeData.fromMap(json.decode(source));

  @override
  String toString() => 'CouponCodeData(coupon_code: $couponCode, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CouponCodeData &&
        other.couponCode == couponCode &&
        other.id == id;
  }

  @override
  int get hashCode => couponCode.hashCode ^ id.hashCode;
}

class GiftCardBox {
  bool? display;
  dynamic message;
  bool? isApplied;
  GiftCardBox({
    this.display,
    required this.message,
    this.isApplied,
  });

  GiftCardBox copyWith({
    bool? display,
    dynamic message,
    bool? isApplied,
  }) {
    return GiftCardBox(
      display: display ?? this.display,
      message: message ?? this.message,
      isApplied: isApplied ?? this.isApplied,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'display': display,
      'message': message,
      'is_applied': isApplied,
    };
  }

  factory GiftCardBox.fromMap(Map<String, dynamic> map) {
    return GiftCardBox(
      display: map['display'],
      message: map['message'],
      isApplied: map['is_applied'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GiftCardBox.fromJson(String source) =>
      GiftCardBox.fromMap(json.decode(source));

  @override
  String toString() =>
      'GiftCardBox(display: $display, message: $message, is_applied: $isApplied)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GiftCardBox &&
        other.display == display &&
        other.message == message &&
        other.isApplied == isApplied;
  }

  @override
  int get hashCode => display.hashCode ^ message.hashCode ^ isApplied.hashCode;
}

class Item {
  dynamic sku;
  String? vendorName;
  Picture? picture;
  int? productId;
  String? productName;
  String? productSeName;
  String? unitPrice;
  String? subTotal;
  dynamic discount;
  dynamic maximumDiscountedQty;
  int? quantity;
  List<dynamic>? allowedQuantities;
  String? attributeInfo;
  dynamic recurringInfo;
  dynamic rentalInfo;
  bool? allowItemEditing;
  bool? disableRemoval;
  List<dynamic>? warnings;
  int? id;
  Item({
    required this.sku,
    this.vendorName,
    this.picture,
    this.productId,
    this.productName,
    this.productSeName,
    this.unitPrice,
    this.subTotal,
    required this.discount,
    required this.maximumDiscountedQty,
    this.quantity,
    this.allowedQuantities,
    this.attributeInfo,
    required this.recurringInfo,
    required this.rentalInfo,
    this.allowItemEditing,
    this.disableRemoval,
    this.warnings,
    this.id,
  });

  Item copyWith({
    dynamic sku,
    String? vendorName,
    Picture? picture,
    int? productId,
    String? productName,
    String? productSeName,
    String? unitPrice,
    String? subTotal,
    dynamic discount,
    dynamic maximumDiscountedQty,
    int? quantity,
    List<dynamic>? allowedQuantities,
    String? attributeInfo,
    dynamic recurringInfo,
    dynamic rentalInfo,
    bool? allowItemEditing,
    bool? disableRemoval,
    List<dynamic>? warnings,
    int? id,
  }) {
    return Item(
      sku: sku ?? this.sku,
      vendorName: vendorName ?? this.vendorName,
      picture: picture ?? this.picture,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productSeName: productSeName ?? this.productSeName,
      unitPrice: unitPrice ?? this.unitPrice,
      subTotal: subTotal ?? this.subTotal,
      discount: discount ?? this.discount,
      maximumDiscountedQty: maximumDiscountedQty ?? this.maximumDiscountedQty,
      quantity: quantity ?? this.quantity,
      allowedQuantities: allowedQuantities ?? this.allowedQuantities,
      attributeInfo: attributeInfo ?? this.attributeInfo,
      recurringInfo: recurringInfo ?? this.recurringInfo,
      rentalInfo: rentalInfo ?? this.rentalInfo,
      allowItemEditing: allowItemEditing ?? this.allowItemEditing,
      disableRemoval: disableRemoval ?? this.disableRemoval,
      warnings: warnings ?? this.warnings,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sku': sku,
      'vendor_name': vendorName,
      'picture': picture?.toMap(),
      'product_id': productId,
      'product_name': productName,
      'product_se_name': productSeName,
      'unit_price': unitPrice,
      'sub_total': subTotal,
      'discount': discount,
      'maximum_discounted_qty': maximumDiscountedQty,
      'quantity': quantity,
      'allowed_quantities': allowedQuantities,
      'attribute_info': attributeInfo,
      'recurring_info': recurringInfo,
      'rental_info': rentalInfo,
      'allow_item_editing': allowItemEditing,
      'disable_removal': disableRemoval,
      'warnings': warnings,
      'id': id,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      sku: map['sku'],
      vendorName: map['vendor_name'],
      picture: map['picture'] != null ? Picture.fromMap(map['picture']) : null,
      productId: map['product_id']?.toInt(),
      productName: map['product_name'],
      productSeName: map['product_se_name'],
      unitPrice: map['unit_price'],
      subTotal: map['sub_total'],
      discount: map['discount'],
      maximumDiscountedQty: map['maximum_discounted_qty'],
      quantity: map['quantity']?.toInt(),
      allowedQuantities: List<dynamic>.from(map['allowed_quantities']),
      attributeInfo: map['attribute_info'],
      recurringInfo: map['recurring_info'],
      rentalInfo: map['rental_info'],
      allowItemEditing: map['allow_item_editing'],
      disableRemoval: map['disable_removal'],
      warnings: List<dynamic>.from(map['warnings']),
      id: map['id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Item(sku: $sku, vendor_name: $vendorName, picture: $picture, product_id: $productId, product_name: $productName, product_se_name: $productSeName, unit_price: $unitPrice, sub_total: $subTotal, discount: $discount, maximum_discounted_qty: $maximumDiscountedQty, quantity: $quantity, allowed_quantities: $allowedQuantities, attribute_info: $attributeInfo, recurring_info: $recurringInfo, rental_info: $rentalInfo, allow_item_editing: $allowItemEditing, disable_removal: $disableRemoval, warnings: $warnings, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Item &&
        other.sku == sku &&
        other.vendorName == vendorName &&
        other.picture == picture &&
        other.productId == productId &&
        other.productName == productName &&
        other.productSeName == productSeName &&
        other.unitPrice == unitPrice &&
        other.subTotal == subTotal &&
        other.discount == discount &&
        other.maximumDiscountedQty == maximumDiscountedQty &&
        other.quantity == quantity &&
        listEquals(other.allowedQuantities, allowedQuantities) &&
        other.attributeInfo == attributeInfo &&
        other.recurringInfo == recurringInfo &&
        other.rentalInfo == rentalInfo &&
        other.allowItemEditing == allowItemEditing &&
        other.disableRemoval == disableRemoval &&
        listEquals(other.warnings, warnings) &&
        other.id == id;
  }

  @override
  int get hashCode {
    return sku.hashCode ^
        vendorName.hashCode ^
        picture.hashCode ^
        productId.hashCode ^
        productName.hashCode ^
        productSeName.hashCode ^
        unitPrice.hashCode ^
        subTotal.hashCode ^
        discount.hashCode ^
        maximumDiscountedQty.hashCode ^
        quantity.hashCode ^
        allowedQuantities.hashCode ^
        attributeInfo.hashCode ^
        recurringInfo.hashCode ^
        rentalInfo.hashCode ^
        allowItemEditing.hashCode ^
        disableRemoval.hashCode ^
        warnings.hashCode ^
        id.hashCode;
  }
}

class Picture {
  String? imageUrl;
  dynamic thumbImageUrl;
  dynamic fullSizeImageUrl;
  String? title;
  String? alternateText;
  Picture({
    this.imageUrl,
    required this.thumbImageUrl,
    required this.fullSizeImageUrl,
    this.title,
    this.alternateText,
  });

  Picture copyWith({
    String? imageUrl,
    dynamic thumbImageUrl,
    dynamic fullSizeImageUrl,
    String? title,
    String? alternateText,
  }) {
    return Picture(
      imageUrl: imageUrl ?? this.imageUrl,
      thumbImageUrl: thumbImageUrl ?? this.thumbImageUrl,
      fullSizeImageUrl: fullSizeImageUrl ?? this.fullSizeImageUrl,
      title: title ?? this.title,
      alternateText: alternateText ?? this.alternateText,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image_url': imageUrl,
      'thumb_image_url': thumbImageUrl,
      'full_size_image_url': fullSizeImageUrl,
      'title': title,
      'alternate_text': alternateText,
    };
  }

  factory Picture.fromMap(Map<String, dynamic> map) {
    return Picture(
      imageUrl: map['image_url'],
      thumbImageUrl: map['thumb_image_url'],
      fullSizeImageUrl: map['full_size_image_url'],
      title: map['title'],
      alternateText: map['alternate_text'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Picture.fromJson(String source) =>
      Picture.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Picture(image_url: $imageUrl, thumb_image_url: $thumbImageUrl, full_size_image_url: $fullSizeImageUrl, title: $title, alternate_text: $alternateText)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Picture &&
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

class OrderReviewData {
  bool? display;
  CartAddress? billingAddress;
  bool? isShippable;
  CartAddress? shippingAddress;
  bool? selectedPickupInStore;
  CartAddress? pickupAddress;
  dynamic shippingMethod;
  dynamic paymentMethod;
  OrderReviewData({
    this.display,
    this.billingAddress,
    this.isShippable,
    this.shippingAddress,
    this.selectedPickupInStore,
    this.pickupAddress,
    required this.shippingMethod,
    required this.paymentMethod,
  });

  OrderReviewData copyWith({
    bool? display,
    CartAddress? billingAddress,
    bool? isShippable,
    CartAddress? shippingAddress,
    bool? selectedPickupInStore,
    CartAddress? pickupAddress,
    dynamic shippingMethod,
    dynamic paymentMethod,
  }) {
    return OrderReviewData(
      display: display ?? this.display,
      billingAddress: billingAddress ?? this.billingAddress,
      isShippable: isShippable ?? this.isShippable,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      selectedPickupInStore:
          selectedPickupInStore ?? this.selectedPickupInStore,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      shippingMethod: shippingMethod ?? this.shippingMethod,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'display': display,
      'billing_address': billingAddress?.toMap(),
      'is_shippable': isShippable,
      'shipping_address': shippingAddress?.toMap(),
      'selected_pickup_in_store': selectedPickupInStore,
      'pickup_address': pickupAddress?.toMap(),
      'shipping_method': shippingMethod,
      'payment_method': paymentMethod,
    };
  }

  factory OrderReviewData.fromMap(Map<String, dynamic> map) {
    return OrderReviewData(
      display: map['display'],
      billingAddress: map['billing_address'] != null
          ? CartAddress.fromMap(map['billing_address'])
          : null,
      isShippable: map['is_shippable'],
      shippingAddress: map['shipping_address'] != null
          ? CartAddress.fromMap(map['shipping_address'])
          : null,
      selectedPickupInStore: map['selected_pickup_in_store'],
      pickupAddress: map['pickup_address'] != null
          ? CartAddress.fromMap(map['pickup_address'])
          : null,
      shippingMethod: map['shipping_method'],
      paymentMethod: map['payment_method'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderReviewData.fromJson(String source) =>
      OrderReviewData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderReviewData(display: $display, billing_address: $billingAddress, is_shippable: $isShippable, shipping_address: $shippingAddress, selected_pickup_in_store: $selectedPickupInStore, pickup_address: $pickupAddress, shipping_method: $shippingMethod, payment_method: $paymentMethod)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderReviewData &&
        other.display == display &&
        other.billingAddress == billingAddress &&
        other.isShippable == isShippable &&
        other.shippingAddress == shippingAddress &&
        other.selectedPickupInStore == selectedPickupInStore &&
        other.pickupAddress == pickupAddress &&
        other.shippingMethod == shippingMethod &&
        other.paymentMethod == paymentMethod;
  }

  @override
  int get hashCode {
    return display.hashCode ^
        billingAddress.hashCode ^
        isShippable.hashCode ^
        shippingAddress.hashCode ^
        selectedPickupInStore.hashCode ^
        pickupAddress.hashCode ^
        shippingMethod.hashCode ^
        paymentMethod.hashCode;
  }
}

class CartAddress {
  String? firstName;
  String? lastName;
  String? email;
  bool? companyEnabled;
  bool? companyRequired;
  dynamic company;
  bool? countryEnabled;
  int? countryId;
  String? countryName;
  bool? stateProvinceEnabled;
  dynamic stateProvinceId;
  dynamic stateProvinceName;
  bool? countyEnabled;
  bool? countyRequired;
  dynamic county;
  bool? cityEnabled;
  bool? cityRequired;
  dynamic city;
  bool? streetAddressEnabled;
  bool? streetAddressRequired;
  String? address1;
  bool? streetAddress2Enabled;
  bool? streetAddress2Required;
  dynamic address2;
  bool? zipPostalCodeEnabled;
  bool? zipPostalCodeRequired;
  dynamic zipPostalCode;
  bool? phoneEnabled;
  bool? phoneRequired;
  String? phoneNumber;
  bool? faxEnabled;
  bool? faxRequired;
  dynamic faxNumber;
  List<Available>? availableCountries;
  List<Available>? availableStates;
  String? formattedCustomAddressAttributes;
  List<CustomAddressAttributeModel>? customAddressAttributes;
  int? id;
  CartAddress({
    this.firstName,
    this.lastName,
    this.email,
    this.companyEnabled,
    this.companyRequired,
    required this.company,
    this.countryEnabled,
    this.countryId,
    this.countryName,
    this.stateProvinceEnabled,
    required this.stateProvinceId,
    required this.stateProvinceName,
    this.countyEnabled,
    this.countyRequired,
    required this.county,
    this.cityEnabled,
    this.cityRequired,
    required this.city,
    this.streetAddressEnabled,
    this.streetAddressRequired,
    this.address1,
    this.streetAddress2Enabled,
    this.streetAddress2Required,
    required this.address2,
    this.zipPostalCodeEnabled,
    this.zipPostalCodeRequired,
    required this.zipPostalCode,
    this.phoneEnabled,
    this.phoneRequired,
    this.phoneNumber,
    this.faxEnabled,
    this.faxRequired,
    required this.faxNumber,
    this.availableCountries,
    this.availableStates,
    this.formattedCustomAddressAttributes,
    this.customAddressAttributes,
    this.id,
  });

  CartAddress copyWith({
    String? firstName,
    String? lastName,
    String? email,
    bool? companyEnabled,
    bool? companyRequired,
    dynamic company,
    bool? countryEnabled,
    int? countryId,
    String? countryName,
    bool? stateProvinceEnabled,
    dynamic stateProvinceId,
    dynamic stateProvinceName,
    bool? countyEnabled,
    bool? countyRequired,
    dynamic county,
    bool? cityEnabled,
    bool? cityRequired,
    dynamic city,
    bool? streetAddressEnabled,
    bool? streetAddressRequired,
    String? address1,
    bool? streetAddress2Enabled,
    bool? streetAddress2Required,
    dynamic address2,
    bool? zipPostalCodeEnabled,
    bool? zipPostalCodeRequired,
    dynamic zipPostalCode,
    bool? phoneEnabled,
    bool? phoneRequired,
    String? phoneNumber,
    bool? faxEnabled,
    bool? faxRequired,
    dynamic faxNumber,
    List<Available>? availableCountries,
    List<Available>? availableStates,
    String? formattedCustomAddressAttributes,
    List<CustomAddressAttributeModel>? customAddressAttributes,
    int? id,
  }) {
    return CartAddress(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      companyEnabled: companyEnabled ?? this.companyEnabled,
      companyRequired: companyRequired ?? this.companyRequired,
      company: company ?? this.company,
      countryEnabled: countryEnabled ?? this.countryEnabled,
      countryId: countryId ?? this.countryId,
      countryName: countryName ?? this.countryName,
      stateProvinceEnabled: stateProvinceEnabled ?? this.stateProvinceEnabled,
      stateProvinceId: stateProvinceId ?? this.stateProvinceId,
      stateProvinceName: stateProvinceName ?? this.stateProvinceName,
      countyEnabled: countyEnabled ?? this.countyEnabled,
      countyRequired: countyRequired ?? this.countyRequired,
      county: county ?? this.county,
      cityEnabled: cityEnabled ?? this.cityEnabled,
      cityRequired: cityRequired ?? this.cityRequired,
      city: city ?? this.city,
      streetAddressEnabled: streetAddressEnabled ?? this.streetAddressEnabled,
      streetAddressRequired:
          streetAddressRequired ?? this.streetAddressRequired,
      address1: address1 ?? this.address1,
      streetAddress2Enabled:
          streetAddress2Enabled ?? this.streetAddress2Enabled,
      streetAddress2Required:
          streetAddress2Required ?? this.streetAddress2Required,
      address2: address2 ?? this.address2,
      zipPostalCodeEnabled: zipPostalCodeEnabled ?? this.zipPostalCodeEnabled,
      zipPostalCodeRequired:
          zipPostalCodeRequired ?? this.zipPostalCodeRequired,
      zipPostalCode: zipPostalCode ?? this.zipPostalCode,
      phoneEnabled: phoneEnabled ?? this.phoneEnabled,
      phoneRequired: phoneRequired ?? this.phoneRequired,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      faxEnabled: faxEnabled ?? this.faxEnabled,
      faxRequired: faxRequired ?? this.faxRequired,
      faxNumber: faxNumber ?? this.faxNumber,
      availableCountries: availableCountries ?? this.availableCountries,
      availableStates: availableStates ?? this.availableStates,
      formattedCustomAddressAttributes: formattedCustomAddressAttributes ??
          this.formattedCustomAddressAttributes,
      customAddressAttributes:
          customAddressAttributes ?? this.customAddressAttributes,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'company_enabled': companyEnabled,
      'company_required': companyRequired,
      'company': company,
      'country_enabled': countryEnabled,
      'country_id': countryId,
      'country_name': countryName,
      'state_province_enabled': stateProvinceEnabled,
      'state_province_id': stateProvinceId,
      'state_province_name': stateProvinceName,
      'county_enabled': countyEnabled,
      'county_required': countyRequired,
      'county': county,
      'city_enabled': cityEnabled,
      'city_required': cityRequired,
      'city': city,
      'street_address_enabled': streetAddressEnabled,
      'street_address_required': streetAddressRequired,
      'address1': address1,
      'street_address2_enabled': streetAddress2Enabled,
      'street_address2_required': streetAddress2Required,
      'address2': address2,
      'zip_postal_code_enabled': zipPostalCodeEnabled,
      'zip_postal_code_required': zipPostalCodeRequired,
      'zip_postal_code': zipPostalCode,
      'phone_enabled': phoneEnabled,
      'phone-required': phoneRequired,
      'phone_number': phoneNumber,
      'fax_enabled': faxEnabled,
      'fax_required': faxRequired,
      'fax_number': faxNumber,
      'available_countries': availableCountries?.map((x) => x.toMap()).toList(),
      'available_states': availableStates?.map((x) => x.toMap()).toList(),
      'formatted_custom_address_attributes': formattedCustomAddressAttributes,
      'custom_address_attributes':
          customAddressAttributes?.map((x) => x.toMap()).toList(),
      'id': id,
    };
  }

  factory CartAddress.fromMap(Map<String, dynamic> map) {
    return CartAddress(
      firstName: map['first_name'],
      lastName: map['last_name'],
      email: map['email'],
      companyEnabled: map['company_enabled'],
      companyRequired: map['company_required'],
      company: map['company'],
      countryEnabled: map['country_enabled'],
      countryId: map['country_id']?.toInt(),
      countryName: map['country_name'],
      stateProvinceEnabled: map['state_province_enabled'],
      stateProvinceId: map['state_province_id'],
      stateProvinceName: map['state_province_name'],
      countyEnabled: map['county_enabled'],
      countyRequired: map['county_required'],
      county: map['county'],
      cityEnabled: map['city_enabled'],
      cityRequired: map['city_required'],
      city: map['city'],
      streetAddressEnabled: map['street_address_enabled'],
      streetAddressRequired: map['street_address_required'],
      address1: map['address1'],
      streetAddress2Enabled: map['street_address2-enabled'],
      streetAddress2Required: map['street_address2-required'],
      address2: map['address2'],
      zipPostalCodeEnabled: map['zip_postal_code_enabled'],
      zipPostalCodeRequired: map['zip_postal_code_required'],
      zipPostalCode: map['zip_postal_code'],
      phoneEnabled: map['phone_enabled'],
      phoneRequired: map['phone_required'],
      phoneNumber: map['phone_number'],
      faxEnabled: map['fax_enabled'],
      faxRequired: map['fax_required'],
      faxNumber: map['fax_number'],
      availableCountries: map['available_countries'] != null
          ? List<Available>.from(
              map['available_countries']?.map((x) => Available.fromMap(x)))
          : null,
      availableStates: map['available_states'] != null
          ? List<Available>.from(
              map['available_states']?.map((x) => Available.fromMap(x)))
          : null,
      formattedCustomAddressAttributes:
          map['formatted_custom_address_attributes'],
      customAddressAttributes: List<CustomAddressAttributeModel>.from(
          map['custom_address_attributes']
              ?.map((x) => CustomAddressAttributeModel.fromMap(x))),
      id: map['id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartAddress.fromJson(String source) =>
      CartAddress.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CartAddress(first_name: $firstName, last_name: $lastName, email: $email, company_enabled: $companyEnabled, company_required: $companyRequired, company: $company, country_enabled: $countryEnabled, country_id: $countryId, country_name: $countryName, state_province_enabled: $stateProvinceEnabled, state_province_id: $stateProvinceId, state_province_name: $stateProvinceName, county_enabled: $countyEnabled, county_required: $countyRequired, county: $county, city_enabled: $cityEnabled, city_required: $cityRequired, city: $city, street_address_enabled: $streetAddressEnabled, street_address_required: $streetAddressRequired, address1: $address1, street_address2-enabled: $streetAddress2Enabled, street_address2_required: $streetAddress2Required, address2: $address2, zip_postal_code_enabled: $zipPostalCodeEnabled, zip_postal_code_required: $zipPostalCodeRequired, zip_postal_code: $zipPostalCode, phone_enabled: $phoneEnabled, phone_required: $phoneRequired, phone_number: $phoneNumber, fax_enabled: $faxEnabled, fax_required: $faxRequired, fax_number: $faxNumber, available_countries: $availableCountries, available_states: $availableStates, formatted_custom_address_attributes: $formattedCustomAddressAttributes, custom_address_attributes: $customAddressAttributes, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartAddress &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.companyEnabled == companyEnabled &&
        other.companyRequired == companyRequired &&
        other.company == company &&
        other.countryEnabled == countryEnabled &&
        other.countryId == countryId &&
        other.countryName == countryName &&
        other.stateProvinceEnabled == stateProvinceEnabled &&
        other.stateProvinceId == stateProvinceId &&
        other.stateProvinceName == stateProvinceName &&
        other.countyEnabled == countyEnabled &&
        other.countyRequired == countyRequired &&
        other.county == county &&
        other.cityEnabled == cityEnabled &&
        other.cityRequired == cityRequired &&
        other.city == city &&
        other.streetAddressEnabled == streetAddressEnabled &&
        other.streetAddressRequired == streetAddressRequired &&
        other.address1 == address1 &&
        other.streetAddress2Enabled == streetAddress2Enabled &&
        other.streetAddress2Required == streetAddress2Required &&
        other.address2 == address2 &&
        other.zipPostalCodeEnabled == zipPostalCodeEnabled &&
        other.zipPostalCodeRequired == zipPostalCodeRequired &&
        other.zipPostalCode == zipPostalCode &&
        other.phoneEnabled == phoneEnabled &&
        other.phoneRequired == phoneRequired &&
        other.phoneNumber == phoneNumber &&
        other.faxEnabled == faxEnabled &&
        other.faxRequired == faxRequired &&
        other.faxNumber == faxNumber &&
        listEquals(other.availableCountries, availableCountries) &&
        listEquals(other.availableStates, availableStates) &&
        other.formattedCustomAddressAttributes ==
            formattedCustomAddressAttributes &&
        listEquals(other.customAddressAttributes, customAddressAttributes) &&
        other.id == id;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        companyEnabled.hashCode ^
        companyRequired.hashCode ^
        company.hashCode ^
        countryEnabled.hashCode ^
        countryId.hashCode ^
        countryName.hashCode ^
        stateProvinceEnabled.hashCode ^
        stateProvinceId.hashCode ^
        stateProvinceName.hashCode ^
        countyEnabled.hashCode ^
        countyRequired.hashCode ^
        county.hashCode ^
        cityEnabled.hashCode ^
        cityRequired.hashCode ^
        city.hashCode ^
        streetAddressEnabled.hashCode ^
        streetAddressRequired.hashCode ^
        address1.hashCode ^
        streetAddress2Enabled.hashCode ^
        streetAddress2Required.hashCode ^
        address2.hashCode ^
        zipPostalCodeEnabled.hashCode ^
        zipPostalCodeRequired.hashCode ^
        zipPostalCode.hashCode ^
        phoneEnabled.hashCode ^
        phoneRequired.hashCode ^
        phoneNumber.hashCode ^
        faxEnabled.hashCode ^
        faxRequired.hashCode ^
        faxNumber.hashCode ^
        availableCountries.hashCode ^
        availableStates.hashCode ^
        formattedCustomAddressAttributes.hashCode ^
        customAddressAttributes.hashCode ^
        id.hashCode;
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
