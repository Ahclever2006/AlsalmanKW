import '../../../../core/data/datasources/file_local_data_source.dart';
import '../datasources/order_remote_data_source.dart';
import '../models/my_orders_model.dart';
import '../models/order_details_model.dart';

abstract class OrderRepository {
  Future<MyOrdersModel?> getCurrentOrders({
    int pageNumber = 1,
    int pageSize = 10,
  });

  Future<OrderDetailsModel?> getOrderDetails(int id);
  Future<void> reOrder(int id);

  Future<String> getPdfInvoice(int id);
  Future<String?> getFile({required String id});
}

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource _orderRemoteDataSource;
  final FileLocalDataSource _localDataSource;

  const OrderRepositoryImpl(
    this._orderRemoteDataSource,
    this._localDataSource,
  );

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
  Future<OrderDetailsModel?> getOrderDetails(int id) =>
      _orderRemoteDataSource.getOrderDetails(id);

  @override
  Future<void> reOrder(int id) => _orderRemoteDataSource.reOrder(id);

  @override
  Future<String> getPdfInvoice(int id) =>
      _orderRemoteDataSource.getPdfInvoice(id);

  @override
  Future<String?> getFile({required String id}) async =>
      await _localDataSource.getFile(id: id) ??
      await getPdfInvoice(int.parse(id));
}
