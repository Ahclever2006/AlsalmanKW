import 'dart:developer';

import '../../../../core/abstract/base_cubit.dart';
import '../../../../core/data/models/cart_model.dart';
import '../../../../core/data/models/home_section_product_model.dart';
import '../../../../core/data/models/payment_summary.dart';
import '../../../../core/exceptions/redundant_request_exception.dart';
import '../../../product_details/data/model/product_details_model.dart';
import '../../data/repositories/cart_repository.dart';

part 'cart_state.dart';

class CartCubit extends BaseCubit<CartState> {
  CartCubit(
    this._cartRepository,
  ) : super(const CartState());

  final CartRepository _cartRepository;

  Future<void> loadCart([bool refresh = false]) async {
    try {
      if (!refresh) {
        emit(state.copyWith(status: CartStateStatus.loading));
      }
      final cart = await _cartRepository.getCartItems();

      PaymentSummaryModel? paymentSummary;
      ProductDetailsModel? messageCardData;

      if (cart?.items?.isNotEmpty == true) {
        paymentSummary = await getPaymentSummary();
      }

      emit(state.copyWith(
          status: CartStateStatus.loaded,
          cart: cart,
          productDetailsData: messageCardData,
          paymentSummary: paymentSummary));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CartStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> refresh() => loadCart(true);

  Future<void> addToCart(
      String id, int quantity, Map<String, dynamic> data) async {
    try {
      await _cartRepository.addToCart(id, quantity, data);
      await refresh();
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CartStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<bool> addToCartFromCatalog(String id, int quantity) async {
    try {
      await _cartRepository.addToCartFromCatalog(id, quantity);
      await refresh();
      return true;
    } on RedundantRequestException catch (e) {
      log(e.toString());
      return false;
    } catch (e) {
      emit(state.copyWith(
          status: CartStateStatus.error, errorMessage: e.toString()));
      return false;
    }
  }

  Future<void> removeFromCart(String id) async {
    try {
      await _cartRepository.removeFromCart(id);
      await loadCart();
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CartStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> notifyMe(int productId) async {
    emit(state.copyWith(status: CartStateStatus.loaded));
    try {
      await _cartRepository.notifyMe(productId);
      emit(state.copyWith(status: CartStateStatus.notifiedSuccess));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CartStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<bool> updateCartItems(
      String id, int quantity, List<Item> cartItems) async {
    emit(state.copyWith(status: CartStateStatus.loading));
    try {
      final cartData = await _cartRepository.changeCartItemQuantity(
        id,
        quantity,
        cartItems,
      );

      final paymentSummary = await _cartRepository.getPaymentSummary();

      emit(state.copyWith(
        status: CartStateStatus.loaded,
        cart: cartData,
        paymentSummary: paymentSummary,
      ));
      if (cartData.items!
          .firstWhere((e) => e.id.toString() == id)
          .warnings!
          .isNotEmpty)
        return false;
      else
        return true;
    } on RedundantRequestException catch (e) {
      log(e.toString());
      return false;
    } catch (e) {
      emit(state.copyWith(
          status: CartStateStatus.error, errorMessage: e.toString()));
      return false;
    }
  }

  Future<PaymentSummaryModel?> getPaymentSummary() async {
    try {
      PaymentSummaryModel? paymentSummary;

      paymentSummary = await _cartRepository.getPaymentSummary();

      return paymentSummary;
    } on RedundantRequestException catch (e) {
      log(e.toString());
      return null;
    } catch (e) {
      emit(state.copyWith(
          status: CartStateStatus.error, errorMessage: e.toString()));
      return null;
    }
  }

  void clearCart() {
    emit(state.copyWith(cart: CartModel()));
  }

  Future<bool?> checkCartQuantityAvailable() async {
    try {
      final isAvailable = await _cartRepository.checkCartQuantityAvailable();

      return isAvailable;
    } on RedundantRequestException catch (e) {
      log(e.toString());
      return null;
    } catch (e) {
      emit(state.copyWith(
          status: CartStateStatus.error, errorMessage: e.toString()));
      return null;
    }
  }

  Future<void> refreshCartItems() async {
    try {
      await _cartRepository.refreshCartItems();
      await loadCart();
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CartStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> applyCoupon(String couponCode) async {
    emit(state.copyWith(status: CartStateStatus.loaded));
    try {
      await _cartRepository.applyCoupon(couponCode);
      emit(state.copyWith(status: CartStateStatus.loaded));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CartStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> deactivateCoupon() async {
    emit(state.copyWith(status: CartStateStatus.loaded));
    try {
      final couponCode =
          state.cart!.discountBox!.appliedDiscountsWithCodes!.first.couponCode;
      await _cartRepository.deactivateCoupon(couponCode!);
      emit(state.copyWith(status: CartStateStatus.loaded));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CartStateStatus.error, errorMessage: e.toString()));
    }
  }
}
