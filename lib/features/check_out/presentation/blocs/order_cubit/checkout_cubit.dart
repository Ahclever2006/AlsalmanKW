import 'dart:developer';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../../../core/abstract/base_cubit.dart';
import '../../../../../core/data/models/confirm_order_model.dart';
import '../../../../../core/data/models/payment_summary.dart';
import '../../../../../core/data/models/schedule_delivery_shipping_dates_model.dart';
import '../../../../../core/data/models/schedule_delivery_shipping_methods_model.dart';
import '../../../../../core/data/models/schedule_delivery_shipping_times_model.dart';
import '../../../../../core/exceptions/redundant_request_exception.dart';
import '../../../../../core/service/share_service.dart';
import '../../../../../features/cart_tab/data/repositories/cart_repository.dart';
import '../../../../wallet/data/repositories/wallet_repository_impl.dart';
import '../../../data/repositories/checkout_repository_impl.dart';

part 'checkout_state.dart';

class CheckoutCubit extends BaseCubit<CheckoutState> {
  final CheckoutRepository _checkoutRepository;
  final CartRepository _cartRepository;
  final WalletRepository _walletRepository;
  final ShareService _shareService;

  CheckoutCubit(
    this._checkoutRepository,
    this._cartRepository,
    this._walletRepository,
    this._shareService,
  ) : super(const CheckoutState());

  Future<void> chooseAddresses(int addressId) async {
    try {
      emit(state.copyWith(
        status: CheckoutStateStatus.loaded,
        addressId: addressId,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CheckoutStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> setShippingAndBillingAddress() async {
    emit(state.copyWith(status: CheckoutStateStatus.loading));
    try {
      await _checkoutRepository.setShippingAddress(state.addressId!);
      await _checkoutRepository.setBillingAddress(state.addressId!);
      emit(state.copyWith(status: CheckoutStateStatus.addressChosen));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CheckoutStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> changePageIndex(int index) async {
    try {
      emit(state.copyWith(
        status: CheckoutStateStatus.loaded,
        pageIndex: index,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CheckoutStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> getShippingMethods() async {
    emit(state.copyWith(status: CheckoutStateStatus.loading));
    try {
      final shippingMethods = await _checkoutRepository.getShippingMethods();

      emit(state.copyWith(
        status: CheckoutStateStatus.loaded,
        shippingMethods: shippingMethods,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CheckoutStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> getShippingDates(int id) async {
    try {
      final shippingMethodDates =
          await _checkoutRepository.getShippingDates(id);

      emit(state.copyWith(
        status: CheckoutStateStatus.loaded,
        shippingMethodDates: shippingMethodDates,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CheckoutStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> getShippingTimes(int id, String date) async {
    try {
      final shippingMethodTimes =
          await _checkoutRepository.getShippingTimes(id);

      emit(state.copyWith(
        status: CheckoutStateStatus.loaded,
        shippingMethodTimes: shippingMethodTimes,
        selectedShippingDate: date,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CheckoutStateStatus.error, errorMessage: e.toString()));
    }
  }

  void clearDatesAndTimes() {
    emit(state.copyWith(
      status: CheckoutStateStatus.loaded,
      shippingMethodDates: [],
      shippingMethodTimes: [],
      selectedTimeSlotId: -1,
      selectedShippingDate: '',
      selectedShippingTime: '',
    ));
  }

  void chooseShippingMethod(
    String shippingMethodSystemName,
    String shippingOption,
    String shippingMethodType,
  ) {
    try {
      emit(state.copyWith(
        status: CheckoutStateStatus.loaded,
        shippingMethodSystemName: shippingMethodSystemName,
        shippingOption: shippingOption,
        shippingMethodType: shippingMethodType,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CheckoutStateStatus.error, errorMessage: e.toString()));
    }
  }

  void chooseShippingTime(int id, String time) {
    try {
      emit(state.copyWith(
        status: CheckoutStateStatus.loaded,
        selectedTimeSlotId: id,
        selectedShippingTime: time,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CheckoutStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> setShippingMethods() async {
    emit(state.copyWith(status: CheckoutStateStatus.loading));
    try {
      await _checkoutRepository.setShippingMethod(
          shippingMethodSystemName: state.shippingMethodSystemName!,
          shippingOption: state.shippingOption!);

      emit(state.copyWith(status: CheckoutStateStatus.shippingChosen));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CheckoutStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> setShippingTime() async {
    if (state.selectedTimeSlotId == null || state.selectedTimeSlotId == -1)
      return;
    try {
      await _checkoutRepository.setShippingTime(
          timeId: state.selectedTimeSlotId!);
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CheckoutStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> getPaymentSummary() async {
    emit(state.copyWith(status: CheckoutStateStatus.loading));
    try {
      final paymentSummary = await _cartRepository.getPaymentSummary();
      emit(state.copyWith(
        status: CheckoutStateStatus.loaded,
        paymentSummaryModel: paymentSummary,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CheckoutStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> getAndSetPaymentMethods() async {
    emit(state.copyWith(status: CheckoutStateStatus.loading));
    try {
      final paymentMethods = await _checkoutRepository.getPaymentMethods();
      await _checkoutRepository.setPaymentMethod(
        paymentMethod: paymentMethods.model!.paymentMethods!
            .firstWhere((e) =>
                e.paymentMethodSystemName!.contains('Payments.TapPayment'))
            .paymentMethodSystemName,
      );

      final walletStatus = await _walletRepository.getWalletStatus();

      await getPaymentSummary();

      emit(state.copyWith(
        status: CheckoutStateStatus.paymentChosen,
        walletStatus: walletStatus,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CheckoutStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> changeWalletStatus({required bool status}) async {
    try {
      await _walletRepository.changeWalletStatus(status);
      await getPaymentSummary();
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CheckoutStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> confirmOrder() async {
    emit(state.copyWith(status: CheckoutStateStatus.loading));
    try {
      final confirmModel = await _checkoutRepository.confirmOrder();

      emit(state.copyWith(
        status: CheckoutStateStatus.loaded,
        confirmModel: confirmModel,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CheckoutStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> createOrderShareLink() async {
    emit(state.copyWith(status: CheckoutStateStatus.loading));
    try {
      final link = await _checkoutRepository
          .createOrderShareLink(state.confirmModel!.id ?? 5447);
      emit(state.copyWith(
        status: CheckoutStateStatus.loaded,
        orderShareLink: link,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CheckoutStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> shareOrder(Rect? sharePositionOrigin) async {
    await _shareService.shareLink(state.orderShareLink ?? '',
        sharePositionOrigin: sharePositionOrigin);
    emit(state.copyWith(status: CheckoutStateStatus.orderShared));
  }

  Future<void> confirmPayment({required String? invoiceId}) async {
    try {
      await _checkoutRepository.confirmPayment(invoiceId);
      emit(state.copyWith(status: CheckoutStateStatus.loaded));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CheckoutStateStatus.error, errorMessage: e.toString()));
    }
  }

  void onPaymentOptionRadioPressed(int? newVal, String s) {
    emit(state.copyWith(
        status: CheckoutStateStatus.loaded, selectedPaymentMethod: newVal));
  }

  Future<void> reOrder(int orderId) async {
    try {
      await _checkoutRepository.reOrder(orderId);

      emit(state.copyWith(status: CheckoutStateStatus.loaded));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CheckoutStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> getWalletBalance() async {
    try {
      final balance = await _walletRepository.getWalletBalance();
      emit(state.copyWith(
        status: CheckoutStateStatus.loaded,
        totalBalance: balance,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CheckoutStateStatus.error, errorMessage: e.toString()));
    }
  }
}
