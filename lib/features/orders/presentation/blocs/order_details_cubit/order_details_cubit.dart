import 'dart:developer';

import 'package:meta/meta.dart';

import '../../../../../core/abstract/base_cubit.dart';
import '../../../../../core/exceptions/redundant_request_exception.dart';
import '../../../../../features/orders/data/models/order_details_model.dart';
import '../../../data/repositories/order_repository_impl.dart';

part 'order_details_state.dart';

class OrderDetailsCubit extends BaseCubit<OrderDetailsState> {
  final OrderRepository _orderRepository;

  OrderDetailsCubit(
    this._orderRepository,
  ) : super(const OrderDetailsState());

  Future<void> getOrderDetails(int id, [bool refresh = false]) async {
    if (!refresh) emit(state.copyWith(status: OrderDetailsStateStatus.loading));
    try {
      final orderDetails = await _orderRepository.getOrderDetails(id);

      emit(state.copyWith(
        status: OrderDetailsStateStatus.loaded,
        orderDetails: orderDetails,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: OrderDetailsStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> refresh(int id) => getOrderDetails(id, true);

    Future<void> reOrder(int orderId) async {
    try {
      await _orderRepository.reOrder(orderId);

      emit(state.copyWith(status: OrderDetailsStateStatus.reOrder));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: OrderDetailsStateStatus.error, errorMessage: e.toString()));
    }
  }
}
