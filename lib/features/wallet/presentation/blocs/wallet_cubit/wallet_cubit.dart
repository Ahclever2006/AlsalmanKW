import 'dart:developer';

import 'package:flutter/foundation.dart';
import '../../../../../core/abstract/base_cubit.dart';
import '../../../../../core/data/models/wallet_transaction_model.dart';
import '../../../../../core/exceptions/redundant_request_exception.dart';
import '../../../data/repositories/wallet_repository_impl.dart';
part 'wallet_state.dart';

class WalletCubit extends BaseCubit<WalletState> {
  final WalletRepository _walletRepository;

  WalletCubit(
    this._walletRepository,
  ) : super(const WalletState());

  Future<void> init({int pageSize = 10, bool refresh = false}) async {
    if (!refresh) emit(state.copyWith(status: WalletStateStatus.loading));
    try {
      final transactions = await _walletRepository.getTransactions();

      final balance = await _walletRepository.getWalletBalance();

      final walletStatus = await _walletRepository.getWalletStatus();

      emit(state.copyWith(
        status: WalletStateStatus.loaded,
        totalBalance: balance,
        walletStatus: walletStatus,
        transactions: transactions,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: WalletStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> getTransactions(
      {int pageSize = 10, bool refresh = false}) async {
    if (!refresh) emit(state.copyWith(status: WalletStateStatus.loading));
    try {
      final transactions = await _walletRepository.getTransactions();
      emit(state.copyWith(
        status: WalletStateStatus.loaded,
        transactions: transactions,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: WalletStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> refresh() => getTransactions(refresh: true);

  Future<void> getMoreTransactions({
    int sort = 0,
    int pageSize = 10,
  }) async {
    var oldTransactionsList = state.transactions;
    int pageNumber = ((oldTransactionsList!.length / 10).floor() + 1);
    if (oldTransactionsList.length % 10 != 0) return;
    try {
      emit(state.copyWith(status: WalletStateStatus.loadingMore));

      final newTransactionsList = await _walletRepository.getTransactions(
        pageSize: pageSize,
        pageNumber: pageNumber,
      );

      emit(
        state.copyWith(
            status: WalletStateStatus.loaded,
            transactions: [...oldTransactionsList, ...newTransactionsList]),
      );
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: WalletStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> changeWalletStatus({required bool status}) async {
    emit(state.copyWith(status: WalletStateStatus.loadChangeWalletStatus));
    try {
      await _walletRepository.changeWalletStatus(status);
      emit(state.copyWith(status: WalletStateStatus.loaded));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: WalletStateStatus.error, errorMessage: e.toString()));
    }
  }
}
