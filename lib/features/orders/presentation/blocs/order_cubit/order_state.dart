part of 'order_cubit.dart';

enum OrderStateStatus {
  initial,
  loading,
  loaded,
  loadingMore,
  error,
}

extension OrderStateX on OrderState {
  bool get isInitial => status == OrderStateStatus.initial;
  bool get isLoading => status == OrderStateStatus.loading;
  bool get isLoaded => status == OrderStateStatus.loaded;
  bool get isLoadingMore => status == OrderStateStatus.loadingMore;
  bool get isError => status == OrderStateStatus.error;
}

@immutable
class OrderState {
  final MyOrdersModel? currentOrders;
  final MyOrdersModel? previousOrders;
  final OrderStateStatus status;
  final String? errorMessage;

  const OrderState({
    this.currentOrders,
    this.previousOrders,
    this.status = OrderStateStatus.initial,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as OrderState).currentOrders == currentOrders &&
        other.previousOrders == previousOrders &&
        other.status == status &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      currentOrders.hashCode ^
      previousOrders.hashCode ^
      status.hashCode ^
      errorMessage.hashCode;

  OrderState copyWith({
    OrderStateStatus? status,
    MyOrdersModel? currentOrders,
    MyOrdersModel? previousOrders,
    String? errorMessage,
  }) {
    return OrderState(
      status: status ?? this.status,
      currentOrders: currentOrders ?? this.currentOrders,
      previousOrders: previousOrders ?? this.previousOrders,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
