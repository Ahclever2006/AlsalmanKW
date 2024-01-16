part of 'order_details_cubit.dart';

enum OrderDetailsStateStatus {
  initial,
  loading,
  loaded,
  reOrder,
  error,
}

extension OrderStateX on OrderDetailsState {
  bool get isInitial => status == OrderDetailsStateStatus.initial;
  bool get isLoading => status == OrderDetailsStateStatus.loading;
  bool get isLoaded => status == OrderDetailsStateStatus.loaded;
  bool get isReOrder => status == OrderDetailsStateStatus.reOrder;
  bool get isError => status == OrderDetailsStateStatus.error;
}

@immutable
class OrderDetailsState {
  final OrderDetailsModel? orderDetails;
  final OrderDetailsStateStatus status;
  final String? errorMessage;

  const OrderDetailsState({
    this.orderDetails,
    this.status = OrderDetailsStateStatus.initial,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as OrderDetailsState).orderDetails == orderDetails &&
        other.status == status &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      orderDetails.hashCode ^ status.hashCode ^ errorMessage.hashCode;

  OrderDetailsState copyWith({
    OrderDetailsStateStatus? status,
    OrderDetailsModel? orderDetails,
    String? errorMessage,
  }) {
    return OrderDetailsState(
      status: status ?? this.status,
      orderDetails: orderDetails ?? this.orderDetails,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
