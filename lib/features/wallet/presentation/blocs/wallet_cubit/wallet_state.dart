part of 'wallet_cubit.dart';

enum WalletStateStatus {
  initial,
  loading,
  loadChangeWalletStatus,
  loaded,
  loadingMore,
  error
}

extension WalletStateX on WalletState {
  bool get isInitial => status == WalletStateStatus.initial;
  bool get isLoading => status == WalletStateStatus.loading;
  bool get isLoaded => status == WalletStateStatus.loaded;
  bool get isLoadingMore => status == WalletStateStatus.loadingMore;
  bool get isLoadChangeWalletStatus =>
      status == WalletStateStatus.loadChangeWalletStatus;
  bool get isError => status == WalletStateStatus.error;
}

@immutable
class WalletState {
  final List<WalletTransactionModel>? transactions;
  final num? totalBalance;
  final bool? walletStatus;
  final WalletStateStatus status;
  final String? errorMessage;

  const WalletState({
    this.transactions,
    this.totalBalance,
    this.walletStatus = false,
    this.status = WalletStateStatus.initial,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as WalletState).status == status &&
        listEquals(other.transactions, transactions) &&
        other.totalBalance == totalBalance &&
        other.walletStatus == walletStatus &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      transactions.hashCode ^
      status.hashCode ^
      totalBalance.hashCode ^
      walletStatus.hashCode ^
      errorMessage.hashCode;

  WalletState copyWith({
    WalletStateStatus? status,
    num? totalBalance,
    bool? walletStatus,
    List<WalletTransactionModel>? transactions,
    String? errorMessage,
  }) {
    return WalletState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
      totalBalance: totalBalance ?? this.totalBalance,
      walletStatus: walletStatus ?? this.walletStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
