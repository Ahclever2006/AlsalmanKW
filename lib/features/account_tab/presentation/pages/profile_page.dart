import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/other/show_delete_account_bottom_sheet.dart';
import '../../../../shared_widgets/other/show_edit_user_bottom_sheet.dart';
import '../../../../shared_widgets/other/show_simple_bottom_sheet.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import '../../../../shared_widgets/stateless/inner_appbar.dart';
import '../../../../shared_widgets/stateless/title_text.dart';
import '../../../address/presentation/blocs/address_cubit/address_cubit.dart';
import '../../../auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import '../../../cart_tab/presentation/cubit/cart_cubit.dart';
import '../../../layout/presentation/cubit/main_layout_cubit.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/ProfilePage';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppPage(
      safeTop: true,
      child: Scaffold(
        body: Column(
          children: [
            InnerPagesAppBar(
              label: 'profile'.tr().toUpperCase(),
            ),
            ..._buildBody(context),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBody(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    final addressCubit = context.read<AddressCubit>();
    final authCubit = context.read<AuthCubit>();
    final userInfo = authCubit.state.userInfo;
    return [
      _buildProfileItemRow(
          label: 'account_info',
          onPress: () {
            showEditUserBottomSheet(context, userInfo);
          },
          suffixIcon: userInfo?.data?.firstName != null
              ? const Icon(
                  Icons.chevron_right,
                  color: AppColors.PRIMARY_COLOR_DARK,
                )
              : const Icon(
                  FontAwesomeIcons.exclamation,
                  color: Colors.red,
                )),
      _buildProfileItemRow(
          label: 'logout',
          showSuffix: false,
          onPress: () {
            showSimpleBottomSheet(context,
                label: 'logout',
                subtitle: 'log_out_subtitle', onPress: () async {
              await authCubit
                  .logOut()
                  .then((value) => authCubit.loginAsGuest())
                  .whenComplete(() => cartCubit.clearCart())
                  .whenComplete(() => addressCubit.refreshAddresses())
                  .whenComplete(() => _goToHomePage(context));
            });
          }),
      _buildProfileItemRow(
          label: 'delete_account',
          showSuffix: false,
          onPress: () {
            showDeleteAccountBottomSheet(context,
                label: 'delete_account_title',
                subtitle: 'delete_account_subtitle',
                checkMessage: 'delete_account_check_message',
                onPress: () => authCubit
                    .deleteAccount()
                    .then((value) => authCubit.loginAsGuest())
                    .whenComplete(() => cartCubit.clearCart())
                    .whenComplete(() => addressCubit.refreshAddresses())
                    .whenComplete(() => _goToHomePage(context)));
          }),
    ];
  }

  Widget _buildProfileItemRow(
      {required String label,
      bool showSuffix = true,
      Icon? suffixIcon = const Icon(
        Icons.chevron_right,
        color: AppColors.PRIMARY_COLOR_DARK,
      ),
      required VoidCallback onPress}) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TitleText(text: label),
            if (showSuffix) suffixIcon!,
          ],
        ),
      ),
    );
  }

  void _goToHomePage(BuildContext context) {
    final mainLayoutCubit = context.read<MainLayoutCubit>();

    mainLayoutCubit.onBottomNavPressed(0);

    NavigatorHelper.of(context)
        .popUntil(ModalRoute.withName("/MainLayOutPage"));

    showSnackBar(context, message: 'guest_mode');
  }
}
