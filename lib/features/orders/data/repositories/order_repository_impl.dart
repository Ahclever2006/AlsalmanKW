import '../datasources/order_remote_data_source.dart';
import '../models/my_orders_model.dart';
import '../models/order_details_model.dart';

abstract class OrderRepository {
  Future<MyOrdersModel?> getCurrentOrders({
    int pageNumber = 1,
    int pageSize = 10,
  });
  Future<MyOrdersModel?> getPreviousOrders({
    int pageNumber = 1,
    int pageSize = 10,
  });
  Future<OrderDetailsModel?> getOrderDetails(int id);

  Future<void> reOrder(int id);
}

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource _orderRemoteDataSource;

  const OrderRepositoryImpl(this._orderRemoteDataSource);

  @override
  Future<MyOrdersModel?> getCurrentOrders({
    int pageNumber = 1,
    int pageSize = 10,
  }) =>
      _orderRemoteDataSource.getCurrentOrders(
        pageNumber: pageNumber,
        pageSize: pageSize,
      );

  @override
  Future<MyOrdersModel?> getPreviousOrders({
    int pageNumber = 1,
    int pageSize = 10,
  }) =>
      _orderRemoteDataSource.getPreviousOrders(
        pageNumber: pageNumber,
        pageSize: pageSize,
      );

  @override
  Future<OrderDetailsModel?> getOrderDetails(int id) =>
      _orderRemoteDataSource.getOrderDetails(id);

  @override
  Future<void> reOrder(int id) => _orderRemoteDataSource.reOrder(id);
}
