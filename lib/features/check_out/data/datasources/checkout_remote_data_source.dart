import '../../../../core/data/models/confirm_order_model.dart';
import '../../../../core/data/models/payment_methods_model.dart';
import '../../../../core/data/models/schedule_delivery_shipping_dates_model.dart';
import '../../../../core/data/models/schedule_delivery_shipping_methods_model.dart';
import '../../../../core/data/models/schedule_delivery_shipping_times_model.dart';
import '/api_end_point.dart';
import '/core/exceptions/request_exception.dart';
import '/core/service/network_service.dart';


abstract class CheckoutRemoteDataSource {
  Future<void> setBillingAddress(int id);

  Future<void> setShippingAddress(int id);

  Future<List<ScheduleDeliveryShippingMethodsModel>> getShippingMethods();
  Future<List<ScheduleDeliveryShippingDatesModel>> getShippingDates(int id);
  Future<List<ScheduleDeliveryShippingTimesModel>> getShippingTimes(int id);
  Future<void> setShippingMethods(
      {required String shippingOption,
      required String shippingMethodSystemName});

  Future<void> setShippingTime({required int timeId});

  Future<PaymentMethodsModel> getPaymentMethods();

  Future<void> setPaymentMethod({String? paymentMethod});

  Future<ConfirmOrderModel> confirmOrder({required String deviceType});

  Future<String> createOrderShareLink(int orderId);

  Future<void> confirmPayment({String? invoiceId});
  Future<void> reOrder(int id);
}

class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSource {
  final NetworkService _networkService;

  CheckoutRemoteDataSourceImpl(this._networkService);

  @override
  Future<void> setBillingAddress(int id) {
    final url = ApiEndPoint.SET_BILLING_ADDRESS + id.toString();
    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['success'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['errors']);
    });
  }

  @override
  Future<void> setShippingAddress(int id) {
    final url = ApiEndPoint.SET_SHIPPING_ADDRESS + id.toString();
    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['success'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['errors']);
    });
  }

  @override
  Future<List<ScheduleDeliveryShippingMethodsModel>> getShippingMethods() {
    const url = ApiEndPoint.GET_DELIVERY_SHIPPING_METHODS;
    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      final shippingMethods = result['Data'] as List;
      return shippingMethods
          .map((e) => ScheduleDeliveryShippingMethodsModel.fromMap(e))
          .toList();
    });
  }

  @override
  Future<List<ScheduleDeliveryShippingDatesModel>> getShippingDates(int id) {
    final url = "${ApiEndPoint.GET_DELIVERY_SHIPPING_DATES}$id/days";
    return _networkService
        .get(url, queryParameters: {"nextDays": 3}).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      final shippingMethodDates = result['Data'] as List;
      return shippingMethodDates
          .map((e) => ScheduleDeliveryShippingDatesModel.fromMap(e))
          .toList();
    });
  }

  @override
  Future<List<ScheduleDeliveryShippingTimesModel>> getShippingTimes(int id) {
    const url = ApiEndPoint.GET_DELIVERY_SHIPPING_TIMES;
    return _networkService
        .get(url, queryParameters: {"dayId": id}).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      final shippingMethodTimes = result['Data'] as List;
      return shippingMethodTimes
          .map((e) => ScheduleDeliveryShippingTimesModel.fromMap(e))
          .toList();
    });
  }

  @override
  Future<void> setShippingMethods(
      {required String shippingOption,
      required String shippingMethodSystemName}) {
    const url = ApiEndPoint.SET_SHIPPING_METHODS;
    return _networkService.post(
      url,
      data: {},
      queryParameters: {
        "shippingOption": shippingOption,
        "shippingMethodSystemName": shippingMethodSystemName
      },
    ).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['success'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['errors']);
    });
  }

  @override
  Future<void> setShippingTime({required int timeId}) {
    const url = ApiEndPoint.SET_SHIPPING_TIME;
    return _networkService.post(
      url,
      data: {"TimeSlotId": timeId},
    ).then((response) {
      if (response.statusCode != 200 && response.statusCode != 201)
        throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['success'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['errors']);
    });
  }

  @override
  Future<PaymentMethodsModel> getPaymentMethods() {
    const url = ApiEndPoint.getPaymentMethod;
    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
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
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
    });
  }

  @override
  Future<ConfirmOrderModel> confirmOrder({required String deviceType}) {
    const url = ApiEndPoint.confirmOrder;
    return _networkService.post(
      url,
      queryParameters: {
        "processPayment": false,
        //"Device": deviceType == 'IOS' ? 'IOS App' : 'Android App',
      },
    ).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return ConfirmOrderModel.fromMap(result['Data']);
    });
  }

  @override
  Future<void> confirmPayment({String? invoiceId}) {
    const url = ApiEndPoint.verifyByInvoiceId;
    return _networkService.post(
      url,
      data: {},
      queryParameters: {"invoiceId": invoiceId, "useRewardPoint": true},
    ).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
    });
  }

  @override
  Future<String> createOrderShareLink(int orderId) {
    const url = ApiEndPoint.createOrderShareLink;
    return _networkService.post(
      url,
      queryParameters: {"orderId": orderId},
    ).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Message']);
      return result['Data'];
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
