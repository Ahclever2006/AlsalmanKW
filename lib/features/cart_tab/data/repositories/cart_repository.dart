import '../../../../core/data/models/cart_model.dart';
import '../../../../core/data/models/payment_summary.dart';
import '../datasources/cart_remote_data_source.dart';

abstract class CartRepository {
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

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource _cartRemoteDataSource;

  CartRepositoryImpl({required CartRemoteDataSource cartRemoteDataSource})
      : _cartRemoteDataSource = cartRemoteDataSource;

  @override
  Future<void> addToCart(String id, int quantity, Map<String, dynamic> data) =>
      _cartRemoteDataSource.addToCart(id, quantity, data);

  @override
  Future<void> addToCartFromCatalog(String id, int quantity) =>
      _cartRemoteDataSource.addToCartFromCatalog(id, quantity);

  @override
  Future<CartModel?> getCartItems() => _cartRemoteDataSource.getCartItems();

  @override
  Future<void> removeFromCart(String id) =>
      _cartRemoteDataSource.removeFromCart(id);

  @override
  Future<void> notifyMe(int productId) =>
      _cartRemoteDataSource.notifyMe(productId);

  @override
  Future<CartModel> changeCartItemQuantity(
          String id, int quantity, List<Item> cartItems) =>
      _cartRemoteDataSource.changeCartItemQuantity(
        id,
        quantity,
        cartItems,
      );

  @override
  Future<PaymentSummaryModel> getPaymentSummary() =>
      _cartRemoteDataSource.getPaymentSummary();

  @override
  Future<bool> checkCartQuantityAvailable() =>
      _cartRemoteDataSource.checkCartQuantityAvailable();

  @override
  Future<void> refreshCartItems() => _cartRemoteDataSource.refreshCartItems();
   @override
  Future<void> applyCoupon(String couponCode) =>
      _cartRemoteDataSource.applyCoupon(couponCode);

  @override
  Future<void> deactivateCoupon(String couponCode) =>
      _cartRemoteDataSource.deactivateCoupon(couponCode);
}
