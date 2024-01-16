import '/api_end_point.dart';
import '/core/exceptions/request_exception.dart';
import '/core/service/network_service.dart';
import '../models/confirm_order_model.dart';
import '../models/payment_methods_model.dart';

abstract class PaymentRemoteDataSource {
  Future<PaymentMethodsModel> getPaymentMethods();

  Future<void> setPaymentMethod({String? paymentMethod});

  Future<ConfirmOrderModel> confirmOrder({required String deviceType});

  Future<void> confirmPayment({String? invoiceId});
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final NetworkService _networkService;

  PaymentRemoteDataSourceImpl(this._networkService);

  @override
  Future<PaymentMethodsModel> getPaymentMethods() {
    const url = ApiEndPoint.getPaymentMethod;
    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['isSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Errors']);

      return PaymentMethodsModel.fromMap(result['Data']);
    });
  }

  @override
  Future<void> setPaymentMethod({String? paymentMethod}) {
    const url = ApiEndPoint.setPaymentMethod;
    return _networkService.post(
      url,
      data: {},
      queryParameters: {"paymentMethod": paymentMethod},
    ).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['success'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['errors']);
    });
  }

  @override
  Future<ConfirmOrderModel> confirmOrder({required String deviceType}) {
    const url = ApiEndPoint.confirmOrder;
    return _networkService.get(
      url,
      queryParameters: {
        "processPayment": false,
        "Device": deviceType == "IOS" ? 'IOS App' : 'Android App',
      },
    ).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['isSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Errors']);

      return ConfirmOrderModel.fromMap(result['Data']);
    });
  }

  @override
  Future<void> confirmPayment({String? invoiceId}) {
    const url = ApiEndPoint.verifyByInvoiceId;
    return _networkService.post(
      url,
      data: {},
      queryParameters: {"invoiceId": invoiceId},
    ).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['isSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Errors']);
    });
  }
}
