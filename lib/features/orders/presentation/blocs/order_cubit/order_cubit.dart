import 'dart:developer';

import 'package:meta/meta.dart';

import '../../../../../core/abstract/base_cubit.dart';
import '../../../../../core/exceptions/redundant_request_exception.dart';
import '../../../data/models/my_orders_model.dart';
import '../../../data/repositories/order_repository_impl.dart';

part 'order_state.dart';

class OrderCubit extends BaseCubit<OrderState> {
  final OrderRepository _orderRepository;

  OrderCubit(
    this._orderRepository,
  ) : super(const OrderState());

  Future<void> getOrders() async {
    emit(state.copyWith(status: OrderStateStatus.loading));
    try {
      final orders = await _orderRepository.getCurrentOrders();
      emit(state.copyWith(
        status: OrderStateStatus.loaded,
        orders: orders,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: OrderStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> getCurrentOrders() async {
    try {
      final orderModel = await _orderRepository.getCurrentOrders();

      emit(state.copyWith(
        status: OrderStateStatus.loaded,
        orders: orderModel,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: OrderStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> getMoreCurrentOrders({
    int sort = 0,
    int pageSize = 10,
  }) async {
    var oldCurrentOrders = state.orders!.orders;
    int pageNumber = ((oldCurrentOrders!.length / 10).floor() + 1);
    if (oldCurrentOrders.length % 10 != 0) return;
    try {
      emit(state.copyWith(status: OrderStateStatus.loadingMore));

      final newCurrentOrders = await _orderRepository.getCurrentOrders(
        pageSize: pageSize,
        pageNumber: pageNumber,
      );

      emit(
        state.copyWith(
            status: OrderStateStatus.loaded,
            orders: state.orders!.copyWith(
                orders: [...oldCurrentOrders, ...?newCurrentOrders?.orders])),
      );
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: OrderStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> refreshCurrentOrders() => getCurrentOrders();

  Future<void> reOrder(int orderId) async {
    try {
      await _orderRepository.reOrder(orderId);

      emit(state.copyWith(status: OrderStateStatus.reOrder));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: OrderStateStatus.error, errorMessage: e.toString()));
    }
  }
}
