import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/media_query_values.dart';
import '../../../../core/utils/navigator_helper.dart';
import '../blocs/wallet_withdraw_cubit/wallet_withdraw_cubit.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import '../../../../shared_widgets/text_fields/default_text_form_field.dart';

import '../../../../di/injector.dart';
import '../../../../shared_widgets/stateless/inner_appbar.dart';

import '../../../../shared_widgets/text_fields/dot_formatter.dart';
import '/shared_widgets/stateless/custom_app_page.dart';
import '/shared_widgets/stateful/default_button.dart';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class WalletWithDrawPage extends StatefulWidget {
  static const routeName = '/WalletWithDrawPage';
  const WalletWithDrawPage({required this.walletBalance, Key? key})
      : super(key: key);

  final num walletBalance;

  @override
  State<WalletWithDrawPage> createState() => _WalletWithDrawPageState();
}

class _WalletWithDrawPageState extends State<WalletWithDrawPage> {
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController _amountTextController;
  late final TextEditingController _ibanTextController;
  late final TextEditingController _bankNameTextController;
  late final TextEditingController _bankAccountTextController;

  late final FocusNode _amountFocusNode;
  late final FocusNode _ibanFocusNode;
  late final FocusNode _bankNameFocusNode;
  late final FocusNode _bankAccountFocusNode;

  bool _isAutoValidating = false;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();

    _amountTextController = TextEditingController();
    _ibanTextController = TextEditingController();
    _bankNameTextController = TextEditingController();
    _bankAccountTextController = TextEditingController();

    _amountFocusNode = FocusNode();
    _ibanFocusNode = FocusNode();
    _bankNameFocusNode = FocusNode();
    _bankAccountFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _amountTextController.dispose();
    _ibanTextController.dispose();
    _bankNameTextController.dispose();
    _bankAccountTextController.dispose();

    _amountFocusNode.dispose();
    _ibanFocusNode.dispose();
    _bankNameFocusNode.dispose();
    _bankAccountFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Injector().walletWithDrawCubit,
      child: CustomAppPage(
        safeTop: true,
        child: Scaffold(
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              InnerPagesAppBar(
                backIcon: 'custom_back_icon',
                label: 'wallet_withdraw'.tr().toUpperCase(),
              ),
              _buildForm(),
              const SizedBox(height: 48.0),
              Builder(builder: (context) {
                return BlocListener<WalletWithDrawCubit, WalletWithDrawState>(
                  listener: (context, state) {
                    if (state.isError)
                      showSnackBar(context, message: state.errorMessage);

                    if (state.isSuccess) NavigatorHelper.of(context).pop(true);
                  },
                  child: _buildWithDrawButton(context),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    final _dotRestrictionFormatter = DotRestrictionFormatter();

    return Form(
      key: _formKey,
      autovalidateMode: _isAutoValidating
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: Column(
        children: [
          DefaultTextFormField(
            isRequired: true,
            currentFocusNode: _amountFocusNode,
            currentController: _amountTextController,
            nextFocusNode: _ibanFocusNode,
            //TODO: prevent use more than one dot
            inputFormatter: [_dotRestrictionFormatter],
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            hint: 'amount'.tr(),
          ),
          const SizedBox(height: 16.0),
          DefaultTextFormField(
            isRequired: true,
            currentFocusNode: _ibanFocusNode,
            currentController: _ibanTextController,
            nextFocusNode: _bankAccountFocusNode,
            hint: 'iban',
          ),
          const SizedBox(height: 16.0),
          DefaultTextFormField(
            isRequired: true,
            currentFocusNode: _bankAccountFocusNode,
            currentController: _bankAccountTextController,
            nextFocusNode: _bankNameFocusNode,
            hint: 'account_number'.tr(),
          ),
          const SizedBox(height: 16.0),
          DefaultTextFormField(
            isRequired: true,
            currentFocusNode: _bankNameFocusNode,
            currentController: _bankNameTextController,
            hint: 'bank_name'.tr(),
          ),
        ],
      ),
    );
  }

  Widget _buildWithDrawButton(BuildContext context) {
    final cubit = context.read<WalletWithDrawCubit>();
    return DefaultButton(
      label: 'submit'.tr(),
      margin: EdgeInsets.symmetric(horizontal: context.width * 0.20),
      onPressed: () async {
        if (_isNotValid()) return;
        if (widget.walletBalance <
            double.parse(_amountTextController.text.trim()))
          return showSnackBar(context, message: 'wallet_insufficient');
        await cubit.submitWithDrawRequest(
            bankName: _bankNameTextController.text.trim(),
            IBAN: _ibanTextController.text.trim(),
            accountNumber: _bankAccountTextController.text.trim(),
            amount: _amountTextController.text.trim());
      },
    );
  }

  bool _isNotValid() {
    if (!_formKey.currentState!.validate()) {
      setState(() => _isAutoValidating = true);
      return true;
    }
    return false;
  }
}
