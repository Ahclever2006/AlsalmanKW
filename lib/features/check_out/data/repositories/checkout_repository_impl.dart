import '../../../../core/data/datasources/device_type_data_source.dart';
import '../../../../core/data/models/schedule_delivery_shipping_dates_model.dart';
import '../../../../core/data/models/schedule_delivery_shipping_methods_model.dart';
import '../../../../core/data/models/schedule_delivery_shipping_times_model.dart';
import '../../../payment/data/models/confirm_order_model.dart';
import '../../../payment/data/models/payment_methods_model.dart';
import '../datasources/checkout_remote_data_source.dart';

abstract class CheckoutRepository {
  Future<void> setShippingAddress(int id);

  Future<void> setBillingAddress(int id);

  Future<List<ScheduleDeliveryShippingMethodsModel>> getShippingMethods();
  Future<List<ScheduleDeliveryShippingDatesModel>> getShippingDates(int id);
  Future<List<ScheduleDeliveryShippingTimesModel>> getShippingTimes(int id);

  Future<void> setShippingMethod(
      {required String shippingOption,
      required String shippingMethodSystemName});

  Future<void> setShippingTime({required int timeId});

  Future<PaymentMethodsModel> getPaymentMethods();

  Future<void> setPaymentMethod({String? paymentMethod});

  Future<ConfirmOrderModel> confirmOrder();

  Future<String> createOrderShareLink(int orderId);

  Future<void> confirmPayment(String? invoiceId);
  Future<void> reOrder(int id);
}

class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutRemoteDataSource _checkoutRemoteDataSource;
  final DeviceTypeDataSource _deviceTypeDataSource;

  const CheckoutRepositoryImpl(
      this._checkoutRemoteDataSource, this._deviceTypeDataSource);

  @override
  Future<void> setBillingAddress(int id) =>
      _checkoutRemoteDataSource.setBillingAddress(id);

  @override
  Future<void> setShippingAddress(int id) =>
      _checkoutRemoteDataSource.setShippingAddress(id);

  @override
  Future<List<ScheduleDeliveryShippingMethodsModel>> getShippingMethods() =>
      _checkoutRemoteDataSource.getShippingMethods();

  @override
  Future<List<ScheduleDeliveryShippingDatesModel>> getShippingDates(int id) =>
      _checkoutRemoteDataSource.getShippingDates(id);

  @override
  Future<List<ScheduleDeliveryShippingTimesModel>> getShippingTimes(int id) =>
      _checkoutRemoteDataSource.getShippingTimes(id);

  @override
  Future<void> setShippingMethod(
          {required String shippingOption,
          required String shippingMethodSystemName}) =>
      _checkoutRemoteDataSource.setShippingMethods(
        shippingOption: shippingOption,
        shippingMethodSystemName: shippingMethodSystemName,
      );

  @override
  Future<void> setShippingTime({required int timeId}) =>
      _checkoutRemoteDataSource.setShippingTime(timeId: timeId);

  @override
  Future<PaymentMethodsModel> getPaymentMethods() =>
      _checkoutRemoteDataSource.getPaymentMethods();

  @override
  Future<void> setPaymentMethod({String? paymentMethod}) =>
      _checkoutRemoteDataSource.setPaymentMethod(paymentMethod: paymentMethod);

  @override
  Future<ConfirmOrderModel> confirmOrder() {
    final deviceType = _deviceTypeDataSource.getDeviceType();
    return _checkoutRemoteDataSource.confirmOrder(deviceType: deviceType);
  }

  @override
  Future<void> confirmPayment(String? invoiceId) =>
      _checkoutRemoteDataSource.confirmPayment(invoiceId: invoiceId);

  @override
  Future<String> createOrderShareLink(int orderId) =>
      _checkoutRemoteDataSource.createOrderShareLink(orderId);

  @override
  Future<void> reOrder(int id) => _checkoutRemoteDataSource.reOrder(id);
}
