import 'package:alsalman_app/core/utils/media_query_values.dart';
import 'package:alsalman_app/res/style/app_colors.dart';
import 'package:alsalman_app/shared_widgets/stateless/title_text.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../../../shared_widgets/other/show_delete_account_bottom_sheet.dart';
import '../../../address/presentation/blocs/address_cubit/address_cubit.dart';
import '../../../auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import '../../../../shared_widgets/stateless/inner_appbar.dart';
import '../../../../shared_widgets/stateless/subtitle_text.dart';

import '../../../cart_tab/presentation/cubit/cart_cubit.dart';
import '/shared_widgets/stateless/custom_app_page.dart';
import '/shared_widgets/stateful/default_button.dart';
import '/shared_widgets/other/show_snack_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteAccountPage extends StatefulWidget {
  static const routeName = '/DeleteAccountPage';
  const DeleteAccountPage({Key? key}) : super(key: key);

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isError) showSnackBar(context, message: state.errorMessage);
      },
      child: Builder(
        builder: (context) => CustomAppPage(
          safeTop: true,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const InnerPagesAppBar(label: 'delete_account'),
                  _buildDeleteAccountWarningText(context),
                  _buildDeleteAccountWarningSubtitleText(context),
                  const SizedBox(height: 48.0),
                  SvgPicture.asset(
                    'lib/res/assets/delete_account_icon.svg',
                    height: context.height * 0.1,
                  ),
                  const SizedBox(height: 16.0),
                  _buildReadInformationText(context),
                  _buildDeleteAccountSubText(context),
                  const SizedBox(height: 16.0),
                  const Spacer(),
                  _buildSavePasswordButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteAccountSubText(BuildContext context) {
    return const SubtitleText(
      text: 'delete_account_subtitle',
      textAlign: TextAlign.center,
      color: AppColors.PRIMARY_COLOR_DARK,
    );
  }

  Widget _buildDeleteAccountWarningText(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: TitleText.large(
        text: 'warning',
        color: AppColors.PRIMARY_COLOR_DARK,
      ),
    );
  }

  Widget _buildDeleteAccountWarningSubtitleText(BuildContext context) {
    return const SubtitleText(
      text: 'warning_subtitle',
      color: AppColors.PRIMARY_COLOR_DARK,
    );
  }

  Widget _buildReadInformationText(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: TitleText(
        text: 'read_information',
        color: AppColors.PRIMARY_COLOR_DARK,
      ),
    );
  }

  Widget _buildSavePasswordButton(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    final addressCubit = context.read<AddressCubit>();
    final authCubit = context.read<AuthCubit>();
    return DefaultButton(
        label: 'delete'.tr(),
        isExpanded: true,
        onPressed: () => showDeleteAccountBottomSheet(context,
            label: 'delete_account_title',
            subtitle: '',
            checkMessage: 'delete_account_check_message',
            onPress: () => authCubit
                .deleteAccount()
                .then((value) => authCubit.loginAsGuest())
                .whenComplete(() => cartCubit.clearCart())
                .whenComplete(() => addressCubit.refreshAddresses())
                .whenComplete(() => _goToHomePage(context))));
  }

  void _goToHomePage(BuildContext context) {
    // final mainLayoutCubit = context.read<MainLayoutCubit>();

    // mainLayoutCubit.onBottomNavPressed(0);

    NavigatorHelper.of(context)
        .popUntil(ModalRoute.withName("/MainLayOutPage"));

    showSnackBar(context, message: 'guest_mode');
  }
}
