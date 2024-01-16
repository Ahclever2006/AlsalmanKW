import '../../../../core/data/models/wallet_transaction_model.dart';
import '/api_end_point.dart';
import '/core/exceptions/request_exception.dart';
import '/core/service/network_service.dart';

abstract class WalletRemoteDataSource {
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

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  final NetworkService _networkService;

  WalletRemoteDataSourceImpl(this._networkService);

  @override
  Future<List<WalletTransactionModel>> getTransactions({
    int pageNumber = 1,
    int pageSize = 10,
  }) {
    const url = ApiEndPoint.getUserTransactions;
    final params = {
      'pageNumber': pageNumber,
      'pageSize': pageSize,
      "currency": "KWD"
    };
    return _networkService.get(url, queryParameters: params).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Errors']);
      final transactions = result['Data'] as List;
      return transactions
          .map((e) => WalletTransactionModel.fromMap(e))
          .toList();
    });
  }

  @override
  Future<num> getWalletBalance() {
    const url = ApiEndPoint.getWalletBalance;
    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Errors']);
      return result['Data'];
    });
  }

  @override
  Future<bool> getWalletStatus() {
    const url = ApiEndPoint.getWalletStatus;
    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Errors']);
      return result['Data']['UseWalletCredit'];
    });
  }

  @override
  Future<void> changeWalletStatus(bool status) {
    const url = ApiEndPoint.changeWalletStatus;
    final data = {"UseWalletCredit": status};
    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Errors']);
    });
  }

  @override
  Future<void> submitWithDrawRequest(
      {required String bankName,
      required String IBAN,
      required String accountNumber,
      required String amount}) {
    const url = ApiEndPoint.submitWalletWithdrawRequest;
    final data = {
      "CurrencyCode": "KWD",
      "Amount": amount,
      "IBAN": IBAN,
      "AccountNumber": accountNumber,
      "BankName": bankName
    };
    return _networkService.post(url, data: data).then((response) {
      if (response.statusCode != 200)
        throw RequestException(response.data['Message']);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Errors']);
    });
  }
}
