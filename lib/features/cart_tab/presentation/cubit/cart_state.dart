part of 'cart_cubit.dart';

enum CartStateStatus {
  initial,
  loading,
  loaded,
  success,
  notifiedSuccess,
  error
}

extension CartStateX on CartState {
  bool get isInitial => status == CartStateStatus.initial;
  bool get isLoading => status == CartStateStatus.loading;
  bool get isLoaded => status == CartStateStatus.loaded;
  bool get isSuccess => status == CartStateStatus.success;
  bool get isNotifiedSuccess => status == CartStateStatus.notifiedSuccess;
  bool get isError => status == CartStateStatus.error;
}

class CartState {
  final CartModel? cart;
  final PaymentSummaryModel? paymentSummary;
  final ProductDetailsModel? productDetailsData;
  final CartStateStatus status;
  final String? errorMessage;
  const CartState({
    this.cart,
    this.paymentSummary,
    this.productDetailsData,
    this.status = CartStateStatus.initial,
    this.errorMessage,
  });

  int get cartCount => cart?.items?.length ?? 0;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as CartState).cart == cart &&
        other.paymentSummary == paymentSummary &&
        other.productDetailsData == productDetailsData &&
        other.status == status &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      cart.hashCode ^
      paymentSummary.hashCode ^
      productDetailsData.hashCode ^
      status.hashCode ^
      errorMessage.hashCode;

  CartState copyWith({
    CartStateStatus? status,
    CartModel? cart,
    PaymentSummaryModel? paymentSummary,
    ProductDetailsModel? productDetailsData,
    Map<int, HomeSectionProductModel>? cartItemsQuantity,
    String? errorMessage,
  }) {
    return CartState(
      status: status ?? this.status,
      cart: cart ?? this.cart,
      paymentSummary: paymentSummary ?? this.paymentSummary,
      productDetailsData: productDetailsData ?? this.productDetailsData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
