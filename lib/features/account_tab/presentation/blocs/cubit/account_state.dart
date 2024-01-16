part of 'account_cubit.dart';

enum AccountStateStatus {
  initial,
  loading,
  loaded,
  success,
  notifiedSuccess,
  error
}

extension AccountStateX on AccountState {
  bool get isInitial => status == AccountStateStatus.initial;
  bool get isLoading => status == AccountStateStatus.loading;
  bool get isLoaded => status == AccountStateStatus.loaded;
  bool get isSuccess => status == AccountStateStatus.success;
  bool get isNotifiedSuccess => status == AccountStateStatus.notifiedSuccess;
  bool get isError => status == AccountStateStatus.error;
}

@immutable
class AccountState {
  final AccountStateStatus status;
  final bool isSocialExpanded;
  final String? errorMessage;
  const AccountState({
    this.status = AccountStateStatus.initial,
    this.isSocialExpanded = false,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as AccountState).status == status &&
        other.isSocialExpanded == isSocialExpanded &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      status.hashCode ^ isSocialExpanded.hashCode ^ errorMessage.hashCode;

  AccountState copyWith({
    AccountStateStatus? status,
    bool? isSocialExpanded,
    String? errorMessage,
  }) {
    return AccountState(
      status: status ?? this.status,
      isSocialExpanded: isSocialExpanded ?? this.isSocialExpanded,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
