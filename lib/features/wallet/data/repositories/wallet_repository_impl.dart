import '../../../../core/data/models/wallet_transaction_model.dart';

import '../datasources/wallet_remote_data_source.dart';

abstract class WalletRepository {
  Future<List<WalletTransactionModel>> getTransactions({
    int pageNumber = 1,
    int pageSize = 9,
  });
  Future<num> getWalletBalance();

  Future<void> submitWithDrawRequest({
    required String bankName,
    required String IBAN,
    required String accountNumber,
    required String amount,
  });
  Future<bool> getWalletStatus();
  Future<void> changeWalletStatus(bool status);
}

class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource _walletRemoteDataSource;

  const WalletRepositoryImpl(this._walletRemoteDataSource);

  @override
  Future<List<WalletTransactionModel>> getTransactions({
    int pageNumber = 1,
    int pageSize = 10,
  }) =>
      _walletRemoteDataSource.getTransactions(
        pageNumber: pageNumber,
        pageSize: pageSize,
      );

  @override
  Future<num> getWalletBalance() => _walletRemoteDataSource.getWalletBalance();

  @override
  Future<void> changeWalletStatus(bool status) =>
      _walletRemoteDataSource.changeWalletStatus(status);

  @override
  Future<bool> getWalletStatus() => _walletRemoteDataSource.getWalletStatus();

  @override
  Future<void> submitWithDrawRequest(
          {required String bankName,
          required String IBAN,
          required String accountNumber,
          required String amount}) =>
      _walletRemoteDataSource.submitWithDrawRequest(
          bankName: bankName,
          IBAN: IBAN,
          accountNumber: accountNumber,
          amount: amount);
}
