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
      final currentOrders = await _orderRepository.getCurrentOrders();
      final previousOrders = await _orderRepository.getPreviousOrders();
      emit(state.copyWith(
        status: OrderStateStatus.loaded,
        currentOrders: currentOrders,
        previousOrders: previousOrders,
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
        currentOrders: orderModel,
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
    var oldCurrentOrders = state.currentOrders!.orders;
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
            currentOrders: state.currentOrders!.copyWith(
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

  Future<void> getPreviousOrders() async {
    try {
      final orderModel = await _orderRepository.getPreviousOrders();
      emit(state.copyWith(
        status: OrderStateStatus.loaded,
        previousOrders: orderModel,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: OrderStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> getMorePreviousOrders({
    int sort = 0,
    int pageSize = 10,
  }) async {
    var oldPreviousOrders = state.previousOrders!.orders;
    int pageNumber = ((oldPreviousOrders!.length / 10).floor() + 1);
    if (oldPreviousOrders.length % 10 != 0) return;
    try {
      emit(state.copyWith(status: OrderStateStatus.loadingMore));

      final newPreviousOrders = await _orderRepository.getPreviousOrders(
        pageSize: pageSize,
        pageNumber: pageNumber,
      );

      emit(
        state.copyWith(
            status: OrderStateStatus.loaded,
            previousOrders: state.previousOrders!.copyWith(
                orders: [...oldPreviousOrders, ...?newPreviousOrders?.orders])),
      );
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: OrderStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> refreshPreviousOrders() => getPreviousOrders();
}
