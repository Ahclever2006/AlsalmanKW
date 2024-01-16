import '/api_end_point.dart';
import '/core/exceptions/request_exception.dart';
import '/core/service/network_service.dart';
import '../models/my_orders_model.dart';
import '../models/order_details_model.dart';

abstract class OrderRemoteDataSource {
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

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final NetworkService _networkService;

  OrderRemoteDataSourceImpl(this._networkService);

  @override
  Future<MyOrdersModel?> getCurrentOrders({
    int pageNumber = 1,
    int pageSize = 10,
  }) {
    const url = ApiEndPoint.getUserOrders;
    return _networkService.post(url, queryParameters: {
      "withFirstProductPicture": false,
      "dateBasedStatus": 1,
      'PageNumber': pageNumber,
      'PageSize': pageSize
    }).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Errors']);
      return MyOrdersModel.fromMap(result['Data']);
    });
  }

  @override
  Future<MyOrdersModel?> getPreviousOrders({
    int pageNumber = 1,
    int pageSize = 10,
  }) {
    const url = ApiEndPoint.getUserOrders;
    return _networkService.post(url, queryParameters: {
      "withFirstProductPicture": false,
      "dateBasedStatus": 0,
      'PageNumber': pageNumber,
      'PageSize': pageSize
    }).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Errors']);
      return MyOrdersModel.fromMap(result['Data']);
    });
  }

  @override
  Future<OrderDetailsModel?> getOrderDetails(int id) {
    final url = ApiEndPoint.getOrderDetails + id.toString();
    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Errors']);
      return OrderDetailsModel.fromMap(result);
    });
  }

  @override
  Future<void> reOrder(int id) {
    final url = ApiEndPoint.reOrder + id.toString();
    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Errors']);
    });
  }
}
