import 'wallet_withdraw_page.dart';
import '../../../../shared_widgets/other/show_wallet_status_change_dialog.dart';
import '../../../../shared_widgets/stateless/custom_loading.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../../../shared_widgets/other/show_wallet_transaction_bottom_sheet.dart';

import '../../../../core/data/models/wallet_transaction_model.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/stateful/wallet_switch.dart';
import '../../../../shared_widgets/stateless/subtitle_text.dart';
import '../../../../shared_widgets/stateless/title_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:intl/intl.dart' as intl;
import '../../../../shared_widgets/stateless/empty_page_message.dart';
import '../blocs/wallet_cubit/wallet_cubit.dart';
import '/di/injector.dart';
import '/shared_widgets/other/show_snack_bar.dart';
import '/shared_widgets/stateless/custom_app_page.dart';
import '../../../../shared_widgets/stateless/inner_appbar.dart';

class WalletPage extends StatefulWidget {
  static const routeName = '/WalletPage';
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Injector().walletCubit..init(),
      child: CustomAppPage(
        onWillPop: () async {
          return false;
        },
        safeTop: true,
        child: Scaffold(
          body: Column(
            children: [
              Builder(builder: (context) {
                final cubit = context.read<WalletCubit>();
                return InnerPagesAppBar(
                    label: 'wallet'.tr().toUpperCase(),
                    actionIcon: 'withdraw_icon',
                    onActionPress: () async {
                      final result = await _goToWithDrawPage(context);

                      if (result == true) {
                        await cubit.init();
                      }
                    });
              }),
              BlocConsumer<WalletCubit, WalletState>(
                listener: (context, state) {
                  if (state.isError)
                    showSnackBar(context, message: state.errorMessage);
                },
                builder: (context, state) {
                  if (state.isInitial || state.isLoading)
                    return const Expanded(
                      child:
                          CustomLoading(loadingStyle: LoadingStyle.ShimmerList),
                    );

                  final cubit = context.read<WalletCubit>();

                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBalance(state.totalBalance),
                        WalletSwitchButton(
                            isEnabled: state.walletStatus!,
                            onPress: (value) {
                              cubit
                                  .changeWalletStatus(status: value)
                                  .whenComplete(() {
                                showWalletStatusDialog(context,
                                    label: value
                                        ? 'label_active'
                                        : 'label_deactive',
                                    subtitle: value
                                        ? 'subtitle_active'
                                        : 'subtitle_deactive');
                              });
                            }),
                        const SizedBox(height: 12.0),
                        const TitleText(
                          text: 'recent_transactions',
                          margin: EdgeInsets.symmetric(horizontal: 16.0),
                        ),
                        Expanded(
                          child: _buildTransactionsList(context,
                              transactions: state.transactions),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> _goToWithDrawPage(BuildContext context) async {
    final cubit = context.read<WalletCubit>();
    return await NavigatorHelper.of(context)
        .push(MaterialPageRoute(builder: (_) {
      return WalletWithDrawPage(walletBalance: cubit.state.totalBalance ?? 0);
    }));
  }

  Widget _buildTransactionsList(BuildContext context,
      {required List<WalletTransactionModel>? transactions}) {
    final cubit = context.read<WalletCubit>();

    return transactions?.isNotEmpty == true
        ? LazyLoadScrollView(
            onEndOfPage: () => cubit.getMoreTransactions(),
            isLoading: cubit.state.isLoadingMore,
            child: RefreshIndicator(
              onRefresh: () => cubit.refresh(),
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: transactions!.length,
                itemBuilder: (BuildContext context, int index) {
                  final transaction = transactions[index];
                  final expiryDate =
                      transaction.expiredDateTime.toString().split(' ').first;
                  final createDate =
                      transaction.createDateTime.toString().split(' ').first;
                  var isReward = (transaction.walletHistoryType == 'Reward' &&
                      !transaction.expired!);
                  return _buildTransactionItem(
                      isReward, transaction, context, expiryDate, createDate);
                },
              ),
            ),
          )
        : EmptyPageMessage(
            message: 'no_transactions'.tr(),
            heightRatio: 0.4,
            onRefresh: cubit.refresh,
          );
  }

  Widget _buildTransactionItem(
    bool isReward,
    WalletTransactionModel transaction,
    BuildContext context,
    String expiryDate,
    String createDate,
  ) {
    int originatedEntityId = transaction.originatedEntityId ?? 0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: InkWell(
        child: Row(
          children: [
            SvgPicture.asset(isReward
                ? 'lib/res/assets/transaction_add_icon.svg'
                : 'lib/res/assets/transaction_remove_icon.svg'),
            const SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(
                    text: originatedEntityId > 0
                        ? '${'order_no'.tr()} # $originatedEntityId'
                        : isReward
                            ? 'wallet_charge'
                            : 'wallet_withdraw'),
                const SizedBox(height: 12.0),
                SubtitleText(
                  text: intl.DateFormat(
                          'dd MMMM, yyyy', context.locale.languageCode)
                      .format(DateTime(
                    int.parse(createDate.split('/').first),
                    int.parse(createDate.split('/')[1]),
                    int.parse(createDate.split('/').last),
                  )),
                ),
              ],
            ),
            const Spacer(),
            SubtitleText(text: isReward ? '+' : '-'),
            SubtitleText(text: transaction.amount!.toStringAsFixed(3)),
          ],
        ),
        onTap: () {
          if (expiryDate != 'null')
            showWalletTransactionBottomSheet(context,
                label: 'expired_date',
                subtitle1:
                    '${'order_no'.tr()} # ${transaction.originatedEntityId}',
                subtitle2: intl.DateFormat(
                        'dd MMMM, yyyy', context.locale.languageCode)
                    .format(DateTime(
                  int.parse(expiryDate.split('/').first),
                  int.parse(expiryDate.split('/')[1]),
                  int.parse(expiryDate.split('/').last),
                )));
        },
      ),
    );
  }

  Widget _buildBalance(num? totalBalance) {
    return Container(
        height: MediaQuery.of(context).size.height / 6,
        margin: const EdgeInsets.all(16.0),
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: AppColors.PRIMARY_COLOR_DARK,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SubtitleText(
              text: 'available_credit',
              color: Colors.white,
              isBold: true,
            ),
            const SizedBox(height: 16.0),
            TitleText(
              text: '${totalBalance!.toStringAsFixed(3)} ${'currency'.tr()}',
              color: Colors.white,
            ),
          ],
        ));
  }
}
