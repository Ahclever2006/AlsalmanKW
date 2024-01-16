import 'dart:developer';

import 'package:flutter/foundation.dart';
import '../../../../../core/abstract/base_cubit.dart';
import '../../../../../core/exceptions/redundant_request_exception.dart';
import '../../../data/repositories/wallet_repository_impl.dart';
part 'wallet_withdraw_state.dart';

class WalletWithDrawCubit extends BaseCubit<WalletWithDrawState> {
  final WalletRepository _walletRepository;

  WalletWithDrawCubit(
    this._walletRepository,
  ) : super(const WalletWithDrawState());

  Future<void> submitWithDrawRequest({
    required String bankName,
    required String IBAN,
    required String accountNumber,
    required String amount,
  }) async {
    emit(state.copyWith(status: WalletWithDrawStateStatus.loading));
    try {
      await _walletRepository.submitWithDrawRequest(
          bankName: bankName,
          IBAN: IBAN,
          accountNumber: accountNumber,
          amount: amount);

      emit(state.copyWith(status: WalletWithDrawStateStatus.success));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: WalletWithDrawStateStatus.error, errorMessage: e.toString()));
    }
  }
}
