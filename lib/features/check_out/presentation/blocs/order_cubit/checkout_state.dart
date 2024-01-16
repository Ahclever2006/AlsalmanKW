part of 'checkout_cubit.dart';

enum CheckoutStateStatus {
  initial,
  loading,
  loaded,
  addressChosen,
  shippingChosen,
  paymentChosen,
  orderShared,
  error
}

extension CheckoutStateX on CheckoutState {
  bool get isInitial => status == CheckoutStateStatus.initial;
  bool get isLoading => status == CheckoutStateStatus.loading;
  bool get isLoaded => status == CheckoutStateStatus.loaded;
  bool get isAddressChosen => status == CheckoutStateStatus.addressChosen;
  bool get isShippingMethodChosen =>
      status == CheckoutStateStatus.shippingChosen;
  bool get isPaymentChosen => status == CheckoutStateStatus.paymentChosen;
  bool get isOrderShared => status == CheckoutStateStatus.orderShared;
  bool get isError => status == CheckoutStateStatus.error;
}

@immutable
class CheckoutState {
  final int? addressId;
  final int pageIndex;
  final String? shippingMethodSystemName;
  final String? shippingOption;
  final String? orderShareLink;
  final num? totalBalance;
  final List<ScheduleDeliveryShippingMethodsModel>? shippingMethods;
  final String? shippingMethodType;
  final List<ScheduleDeliveryShippingDatesModel>? shippingMethodDates;
  final List<ScheduleDeliveryShippingTimesModel>? shippingMethodTimes;
  final PaymentSummaryModel? paymentSummaryModel;
  final int selectedPaymentMethod;
  final int? selectedTimeSlotId;
  final String? selectedShippingDate;
  final String? selectedShippingTime;
  final bool? walletStatus;
  final ConfirmOrderModel? confirmModel;
  final CheckoutStateStatus status;
  final String? errorMessage;

  const CheckoutState({
    this.addressId,
    this.pageIndex = 0,
    this.shippingMethods,
    this.shippingMethodType,
    this.shippingMethodDates,
    this.shippingMethodTimes,
    this.shippingMethodSystemName,
    this.shippingOption,
    this.orderShareLink,
    this.totalBalance,
    this.paymentSummaryModel,
    this.selectedPaymentMethod = 1,
    this.selectedShippingDate,
    this.selectedShippingTime,
    this.selectedTimeSlotId,
    this.walletStatus = false,
    this.confirmModel,
    this.status = CheckoutStateStatus.initial,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as CheckoutState).addressId == addressId &&
        listEquals(other.shippingMethods, shippingMethods) &&
        listEquals(other.shippingMethodDates, shippingMethodDates) &&
        listEquals(other.shippingMethodTimes, shippingMethodTimes) &&
        other.shippingMethodType == shippingMethodType &&
        other.selectedShippingDate == selectedShippingDate &&
        other.selectedShippingTime == selectedShippingTime &&
        other.selectedTimeSlotId == selectedTimeSlotId &&
        other.shippingMethodSystemName == shippingMethodSystemName &&
        other.totalBalance == totalBalance &&
        other.shippingOption == shippingOption &&
        other.walletStatus == walletStatus &&
        other.paymentSummaryModel == paymentSummaryModel &&
        other.selectedPaymentMethod == selectedPaymentMethod &&
        other.confirmModel == confirmModel &&
        other.orderShareLink == orderShareLink &&
        other.pageIndex == pageIndex &&
        other.status == status &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      addressId.hashCode ^
      shippingMethods.hashCode ^
      shippingMethodDates.hashCode ^
      shippingMethodTimes.hashCode ^
      shippingMethodSystemName.hashCode ^
      shippingOption.hashCode ^
      orderShareLink.hashCode ^
      walletStatus.hashCode ^
      confirmModel.hashCode ^
      selectedPaymentMethod.hashCode ^
      selectedShippingDate.hashCode ^
      selectedShippingTime.hashCode ^
      shippingMethodType.hashCode ^
      selectedTimeSlotId.hashCode ^
      totalBalance.hashCode ^
      paymentSummaryModel.hashCode ^
      pageIndex.hashCode ^
      status.hashCode ^
      errorMessage.hashCode;

  CheckoutState copyWith({
    CheckoutStateStatus? status,
    List<ScheduleDeliveryShippingMethodsModel>? shippingMethods,
    List<ScheduleDeliveryShippingDatesModel>? shippingMethodDates,
    List<ScheduleDeliveryShippingTimesModel>? shippingMethodTimes,
    int? addressId,
    String? shippingMethodSystemName,
    String? shippingOption,
    String? orderShareLink,
    PaymentSummaryModel? paymentSummaryModel,
    int? selectedPaymentMethod,
    String? selectedShippingDate,
    String? selectedShippingTime,
    String? shippingMethodType,
    int? selectedTimeSlotId,
    num? totalBalance,
    bool? walletStatus,
    ConfirmOrderModel? confirmModel,
    int? pageIndex,
    String? errorMessage,
  }) {
    return CheckoutState(
      status: status ?? this.status,
      addressId: addressId ?? this.addressId,
      totalBalance: totalBalance ?? this.totalBalance,
      shippingMethodSystemName:
          shippingMethodSystemName ?? this.shippingMethodSystemName,
      shippingOption: shippingOption ?? this.shippingOption,
      paymentSummaryModel: paymentSummaryModel ?? this.paymentSummaryModel,
      pageIndex: pageIndex ?? this.pageIndex,
      confirmModel: confirmModel ?? this.confirmModel,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      shippingMethods: shippingMethods ?? this.shippingMethods,
      shippingMethodDates: shippingMethodDates ?? this.shippingMethodDates,
      shippingMethodTimes: shippingMethodTimes ?? this.shippingMethodTimes,
      orderShareLink: orderShareLink ?? this.orderShareLink,
      shippingMethodType: shippingMethodType ?? this.shippingMethodType,
      selectedTimeSlotId: selectedTimeSlotId ?? this.selectedTimeSlotId,
      selectedShippingDate: selectedShippingDate ?? this.selectedShippingDate,
      selectedShippingTime: selectedShippingTime ?? this.selectedShippingTime,
      walletStatus: walletStatus ?? this.walletStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
