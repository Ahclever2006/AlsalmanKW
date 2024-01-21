import 'dart:io';

import 'package:dio/dio.dart';

import '/api_end_point.dart';
import '/core/exceptions/request_exception.dart';
import '/core/service/network_service.dart';
import '../models/my_orders_model.dart';
import '../models/order_details_model.dart';

import 'package:path_provider/path_provider.dart';

abstract class OrderRemoteDataSource {
  Future<MyOrdersModel?> getCurrentOrders({
    int pageNumber = 1,
    int pageSize = 10,
  });

  Future<OrderDetailsModel?> getOrderDetails(int id);
  Future<void> reOrder(int id);

  Future<String> getPdfInvoice(int id);
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
    return _networkService.get(url, queryParameters: {
      "withFirstProductPicture": false,
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

  @override
  Future<String> getPdfInvoice(int id) async {
    final url = ApiEndPoint.getOrderPDF + id.toString();
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/Baqah/orderDetails$id.pdf';

    final headers = await _networkService.getDefaultHeaders();

    headers['Keep-Alive'] = 'true';

    await _networkService.downloadFile(url, filePath, ResponseType.bytes,
        headers: headers);

    return filePath;
  }
}
