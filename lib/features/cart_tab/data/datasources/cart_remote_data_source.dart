import '../../../../api_end_point.dart';
import '../../../../core/data/models/cart_model.dart';
import '../../../../core/data/models/payment_summary.dart';
import '../../../../core/exceptions/request_exception.dart';
import '../../../../core/service/network_service.dart';

abstract class CartRemoteDataSource {
  Future<void> addToCart(String id, int quantity, Map<String, dynamic> data);
  Future<void> addToCartFromCatalog(String id, int quantity);
  Future<void> removeFromCart(String id);
  Future<CartModel?> getCartItems();
  Future<void> notifyMe(int productId);

  Future<bool> checkCartQuantityAvailable();
  Future<void> refreshCartItems();

  Future<CartModel> changeCartItemQuantity(
      String id, int quantity, List<Item> cartItems);

  Future<PaymentSummaryModel> getPaymentSummary();
   Future<void> applyCoupon(String couponCode);
  Future<void> deactivateCoupon(String couponCode);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final NetworkService _networkService;
  CartRemoteDataSourceImpl(this._networkService);

  @override
  Future<void> addToCart(String id, int quantity, Map<String, dynamic> data) {
    final url = ApiEndPoint.addToCart + id.toString();

    Map<String, dynamic> dataWithQuantity = {
      ...data,
      'addtocart_$id.EnteredQuantity': quantity
    };

    return _networkService.post(
      url,
      data: dataWithQuantity,
      queryParameters: {'shoppingCartType': 'ShoppingCart'},
    ).then((response) {
      if (response.statusCode != 200)
        throw RequestException(response.data['Data']['errors']);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
    });
  }

  @override
  Future<void> addToCartFromCatalog(String id, int quantity) {
    final url = ApiEndPoint.addToCartFromCatalog + id.toString();

    return _networkService.post(
      url,
      queryParameters: {
        'shoppingCartType': 'ShoppingCart',
        'quantity': quantity
      },
    ).then((response) {
      if (response.statusCode != 200)
        throw RequestException(response.data['Data']['errors']);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
    });
  }

  @override
  Future<void> removeFromCart(String id) {
    final url = ApiEndPoint.removeFromCart + id.toString();
    return _networkService.delete(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
    });
  }

  @override
  Future<CartModel?> getCartItems() {
    const url = ApiEndPoint.getCart;
    return _networkService
        .get(
      url,
    )
        .then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return CartModel.fromMap(result['Data']);
    });
  }

  @override
  Future<void> notifyMe(int productId) {
    final url = ApiEndPoint.NOTIFY_ME + productId.toString();

    return _networkService.post(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
    });
  }

  @override
  Future<CartModel> changeCartItemQuantity(
    String id,
    int quantity,
    List<Item> cartItems,
  ) {
    Map<String, dynamic> body = {
      "removefromcart": "",
      "itemquantity$id": quantity,
    };
    for (Item e in cartItems) {
      if (e.id.toString() == id) {
      } else {
        body.putIfAbsent("itemquantity${e.id}", () => e.quantity);
      }
    }
    const url = ApiEndPoint.UPDATE_CART;
    return _networkService.post(url, data: body).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return CartModel.fromMap(result['Data']);
    });
  }

  @override
  Future<PaymentSummaryModel> getPaymentSummary() {
    const url = ApiEndPoint.PAYMENT_SUMMARY;
    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      if (result == null)
        throw RequestException('failed to get payment summary');
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);

      return PaymentSummaryModel.fromMap(result['Data']);
    });
  }

  @override
  Future<bool> checkCartQuantityAvailable() {
    const url = ApiEndPoint.checkCartProductsAvailability;
    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return result['Data'];
    });
  }

  @override
  Future<void> refreshCartItems() {
    const url = ApiEndPoint.refreshCartItems;
    return _networkService.post(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return result['Data'];
    });
  }
   @override
  Future<void> applyCoupon(String couponCode) {
    const url = ApiEndPoint.APPLY_COUPON;
    return _networkService.post(url,
        data: {},
        queryParameters: {"discountCouponCode": couponCode}).then((response) {
      if (response.statusCode != 200)
        throw RequestException(response.data['Data']['ErrorMessages']);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return result['Data'];
    });
  }

  @override
  Future<void> deactivateCoupon(String couponCode) {
    const url = ApiEndPoint.REMOVE_COUPON;
    return _networkService.delete(url,
        queryParameters: {"couponCode": couponCode}).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return result['Data'];
    });
  }
}
