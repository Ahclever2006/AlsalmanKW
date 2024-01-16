import '../../../../core/data/datasources/device_type_data_source.dart';
import '../datasources/payment_remote_data_source.dart';
import '../models/confirm_order_model.dart';
import '../models/payment_methods_model.dart';

abstract class PaymentRepository {
  Future<PaymentMethodsModel> getPaymentMethods();

  Future<void> setPaymentMethod({String? paymentMethod});

  Future<ConfirmOrderModel> confirmOrder();

  Future<void> confirmPayment(String? invoiceId);
}

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource _paymentRemoteDataSource;
  final DeviceTypeDataSource _deviceTypeDataSource;

  PaymentRepositoryImpl(
    this._paymentRemoteDataSource,
    this._deviceTypeDataSource,
  );

  @override
  Future<PaymentMethodsModel> getPaymentMethods() =>
      _paymentRemoteDataSource.getPaymentMethods();

  @override
  Future<void> setPaymentMethod({String? paymentMethod}) =>
      _paymentRemoteDataSource.setPaymentMethod(paymentMethod: paymentMethod);

  @override
  Future<ConfirmOrderModel> confirmOrder() {
    final deviceType = _deviceTypeDataSource.getDeviceType();
    return _paymentRemoteDataSource.confirmOrder(deviceType: deviceType);
  }

  @override
  Future<void> confirmPayment(String? invoiceId) =>
      _paymentRemoteDataSource.confirmPayment(invoiceId: invoiceId);
}
