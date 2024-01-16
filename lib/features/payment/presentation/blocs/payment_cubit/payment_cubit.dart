import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:myfatoorah_flutter/model/initpayment/SDKInitiatePaymentResponse.dart';

import '/../../../features/payment/data/models/payment_methods_model.dart';
import '/../core/abstract/base_cubit.dart';
import '/../core/exceptions/redundant_request_exception.dart';
import '../../../../../core/data/models/payment_summary.dart';
import '../../../../cart_tab/data/repositories/cart_repository.dart';
import '../../../data/models/confirm_order_model.dart';
import '../../../data/repositories/payment_repository_impl.dart';

part 'payment_state.dart';

class PaymentCubit extends BaseCubit<PaymentState> {
  final PaymentRepository _paymentRepository;
  final CartRepository _cartRepository;

  PaymentCubit(
    this._paymentRepository,
    this._cartRepository,
  ) : super(const PaymentInitial());

  Future<void> getUserData() async {
    try {
      emit(PaymentStateLoading(
        state.paymentMethodsModel,
        state.paymentSummaryModel,
      ));
      emit(PaymentStateLoaded(
        state.paymentMethodsModel,
        state.paymentSummaryModel,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(PaymentStateError(
        e.toString(),
        state.paymentMethodsModel,
        state.paymentSummaryModel,
      ));
    }
  }

  Future<void> getPaymentSummary() async {
    emit(PaymentStateLoading(
      state.paymentMethodsModel,
      state.paymentSummaryModel,
    ));
    try {
      final paymentSummary = await _cartRepository.getPaymentSummary();
      emit(PaymentStateLoaded(
        state.paymentMethodsModel,
        paymentSummary,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(PaymentStateError(
        e.toString(),
        state.paymentMethodsModel,
        state.paymentSummaryModel,
      ));
    }
  }

  Future<void> getAndSetPaymentMethods() async {
    emit(PaymentStateLoading(
      state.paymentMethodsModel,
      state.paymentSummaryModel,
    ));
    try {
      final paymentMethods = await _paymentRepository.getPaymentMethods();

      await _paymentRepository.setPaymentMethod(
        paymentMethod: paymentMethods.model!.paymentMethods!
            .firstWhere((e) =>
                e.paymentMethodSystemName!.contains('Payments.MyFatoorah'))
            .paymentMethodSystemName,
      );
      emit(PaymentStateLoaded(
        paymentMethods,
        state.paymentSummaryModel,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(PaymentStateError(
        e.toString(),
        state.paymentMethodsModel,
        state.paymentSummaryModel,
      ));
    }
  }

  ConfirmOrderModel? confirmModel;

  Future<void> confirmOrder() async {
    emit(PaymentStateLoading(
      state.paymentMethodsModel,
      state.paymentSummaryModel,
    ));
    try {
      confirmModel = await _paymentRepository.confirmOrder();
      emit(PaymentStateLoaded(
        state.paymentMethodsModel,
        state.paymentSummaryModel,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(PaymentStateError(
        e.toString(),
        state.paymentMethodsModel,
        state.paymentSummaryModel,
      ));
    }
  }

  List<PaymentMethods>? myfatoorahPaymentMethods;

  void changeFatoorahPaymentMethods(List<PaymentMethods>? data) {
    emit(PaymentStateLoading(
      state.paymentMethodsModel,
      state.paymentSummaryModel,
    ));
    myfatoorahPaymentMethods = data;

    emit(PaymentStateLoaded(
      state.paymentMethodsModel,
      state.paymentSummaryModel,
    ));
  }

  int? selectedPaymentMethodId;

  void changeSelectedPaymentMethodId(int value) {
    emit(PaymentStateLoading(
      state.paymentMethodsModel,
      state.paymentSummaryModel,
    ));
    selectedPaymentMethodId = value;

    emit(PaymentStateLoaded(
      state.paymentMethodsModel,
      state.paymentSummaryModel,
    ));
  }

  Future<void> confirmPayment({required String? invoiceId}) async {
    emit(PaymentStateLoading(
      state.paymentMethodsModel,
      state.paymentSummaryModel,
    ));
    try {
      await _paymentRepository.confirmPayment(invoiceId);
      emit(PaymentStateSuccess(
        state.paymentMethodsModel,
        state.paymentSummaryModel,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(PaymentStateError(
        e.toString(),
        state.paymentMethodsModel,
        state.paymentSummaryModel,
      ));
    }
  }
}
