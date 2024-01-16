part of 'payment_cubit.dart';

@immutable
abstract class PaymentState {
  final PaymentMethodsModel? paymentMethodsModel;
  final PaymentSummaryModel? paymentSummaryModel;
  const PaymentState([
    this.paymentMethodsModel,
    this.paymentSummaryModel,
  ]);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        other is PaymentState &&
        other.paymentMethodsModel == paymentMethodsModel &&
        other.paymentSummaryModel == paymentSummaryModel;
  }

  @override
  int get hashCode {
    return paymentMethodsModel.hashCode ^ paymentSummaryModel.hashCode;
  }
}

class PaymentInitial extends PaymentState {
  const PaymentInitial();
}

class PaymentStateLoading extends PaymentState {
  const PaymentStateLoading(
    PaymentMethodsModel? paymentMethodsModel,
    PaymentSummaryModel? paymentSummaryModel,
  ) : super(
          paymentMethodsModel,
          paymentSummaryModel,
        );
}

class PaymentStateLoaded extends PaymentState {
  const PaymentStateLoaded(
    PaymentMethodsModel? paymentMethodsModel,
    PaymentSummaryModel? paymentSummaryModel,
  ) : super(
          paymentMethodsModel,
          paymentSummaryModel,
        );
}

class PaymentStateSuccess extends PaymentState {
  const PaymentStateSuccess(
    PaymentMethodsModel? paymentMethodsModel,
    PaymentSummaryModel? paymentSummaryModel,
  ) : super(
          paymentMethodsModel,
          paymentSummaryModel,
        );
}

class PaymentStateError extends PaymentState {
  final String message;
  const PaymentStateError(
    this.message,
    PaymentMethodsModel? paymentMethodsModel,
    PaymentSummaryModel? paymentSummaryModel,
  ) : super(
          paymentMethodsModel,
          paymentSummaryModel,
        );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentStateError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
