part of 'wallet_withdraw_cubit.dart';

enum WalletWithDrawStateStatus { initial, loading, success, error }

extension WalletWithDrawStateX on WalletWithDrawState {
  bool get isInitial => status == WalletWithDrawStateStatus.initial;
  bool get isLoading => status == WalletWithDrawStateStatus.loading;
  bool get isSuccess => status == WalletWithDrawStateStatus.success;
  bool get isError => status == WalletWithDrawStateStatus.error;
}

@immutable
class WalletWithDrawState {
  final WalletWithDrawStateStatus status;
  final String? errorMessage;

  const WalletWithDrawState({
    this.status = WalletWithDrawStateStatus.initial,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as WalletWithDrawState).status == status &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => status.hashCode ^ errorMessage.hashCode;

  WalletWithDrawState copyWith({
    WalletWithDrawStateStatus? status,
    String? errorMessage,
  }) {
    return WalletWithDrawState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
