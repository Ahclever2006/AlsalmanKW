part of 'order_cubit.dart';

enum OrderStateStatus {
  initial,
  loading,
  loaded,
  loadingMore,
  reOrder,
  error,
}

extension OrderStateX on OrderState {
  bool get isInitial => status == OrderStateStatus.initial;
  bool get isLoading => status == OrderStateStatus.loading;
  bool get isLoaded => status == OrderStateStatus.loaded;
  bool get isLoadingMore => status == OrderStateStatus.loadingMore;
  bool get isReOrder => status == OrderStateStatus.reOrder;
  bool get isError => status == OrderStateStatus.error;
}

@immutable
class OrderState {
  final MyOrdersModel? orders;
  final OrderStateStatus status;
  final String? errorMessage;

  const OrderState({
    this.orders,
    this.status = OrderStateStatus.initial,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as OrderState).orders == orders &&
        other.status == status &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => orders.hashCode ^ status.hashCode ^ errorMessage.hashCode;

  OrderState copyWith({
    OrderStateStatus? status,
    MyOrdersModel? orders,
    String? errorMessage,
  }) {
    return OrderState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
