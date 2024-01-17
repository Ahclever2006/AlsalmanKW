import 'package:size_helper/size_helper.dart';
import '../../../../shared_widgets/stateless/drawer_appbar.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../../../wallet/presentation/pages/wallet_page.dart';
import 'change_password_page.dart';
import 'contact_us_page.dart';
import 'language_chooser_page.dart';
import '../../../../core/utils/media_query_values.dart';
import '../../../../di/injector.dart';
import '../../../orders/presentation/pages/orders_page.dart';
import '../../../../core/enums/topic_type.dart';
import '../blocs/cubit/account_cubit.dart';
import 'profile_page.dart';
import 'topic_page.dart';
import '../../../address/presentation/pages/address_screen.dart';
import '../../../auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import '../../../favorites/presentation/pages/favorites_products_page.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/other/show_ads_and_notifications_bottom_sheet.dart';
import '../../../../shared_widgets/stateful/default_button.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import '../../../../shared_widgets/stateless/subtitle_text.dart';
import '../../../../shared_widgets/stateless/title_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils/navigator_helper.dart';

class AccountTab extends StatelessWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final isLoggedIn = authCubit.state.isUserLoggedIn;
    if (isLoggedIn) {
      final authCubit = context.read<AuthCubit>();
      authCubit.getUserData();
    }

    return CustomAppPage(
      child: BlocProvider(
        create: (context) => Injector().accountCubit,
        child: ListView(
          children: [
            _buildTitle(context),
            if (!isLoggedIn) _buildGuestUserSection(context),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (!state.isUserLoggedIn || state.userInfo == null) {
                  return const SizedBox();
                } else {
                  return _buildNormalUserSection(
                      context,
                      state.userInfo?.data?.firstName,
                      state.userInfo?.data?.email);
                }
              },
            ),
            if (isLoggedIn) ..._buildNormalUserAccountRows(context),
            ..._buildGuestAccountRows(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return DrawerAppBarWidget(
        key: ValueKey(context.locale.toString()),
        title: TitleText(text: 'account'.tr().toUpperCase()));
  }

  Widget _buildGuestUserSection(BuildContext context) {
    var width = context.width;
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.PRIMARY_COLOR_DARK),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: DefaultButton(
            label: 'login'.tr().toUpperCase(),
            margin: EdgeInsets.symmetric(horizontal: width * 0.20),
            onPressed: () => _goToSignUpPage(context)));
  }

  Future<void> _goToSignUpPage(BuildContext context) =>
      NavigatorHelper.of(context).pushNamed(LoginPage.routeName);

  Widget _buildNormalUserSection(
      BuildContext context, String? username, String? phone) {
    return Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.PRIMARY_COLOR_DARK),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TitleText(
                      text: 'welcome'.tr(args: [username ?? 'user_name'.tr()]),
                      maxLines: 2),
                  const SizedBox(height: 12.0),
                  SubtitleText(text: phone ?? 'Unknown'),
                ],
              ),
            ),
            InkWell(
                onTap: () => _goToProfilePage(context),
                child: Icon(
                  Icons.chevron_right,
                  color: username == null
                      ? Colors.red
                      : AppColors.PRIMARY_COLOR_DARK,
                )),
          ],
        ));
  }

  List<Widget> _buildGuestAccountRows(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return [
      BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final isNotificationEnabled = state.isNotificationEnabled;
          final isAdTrackingNotificationEnabled =
              state.isAdTrackingNotificationEnabled;

          return _buildAccountItemRow(context,
              icon: 'notification_account_icon',
              label: 'notifications', onPress: () {
            showAdsAndNotificationBottomSheet(context,
                onPressAds: (value) =>
                    authCubit.changeAdTrackingNotificationStatus(value),
                onPressNotification: (value) =>
                    authCubit.changeNotificationStatus(value),
                isNotificationEnabled: isNotificationEnabled,
                isAdsEnabled: isAdTrackingNotificationEnabled);
          });
        },
      ),
      _buildAccountItemRow(context,
          label: 'about_us',
          icon: 'about_us_account_icon',
          onPress: () => _goToTopicsPage(context, TopicType.AboutUs.value)),
      _buildAccountItemRow(context,
          label: 'terms_of_use',
          icon: 'terms_account_icon',
          onPress: () => _goToTopicsPage(context, TopicType.Terms.value)),
      _buildAccountItemRow(context,
          label: 'privacy_policy',
          icon: 'privacy_account_icon',
          onPress: () => _goToTopicsPage(context, TopicType.Privacy.value)),
      _buildAccountItemRow(context,
          icon: 'language_account_icon',
          label: 'language_title',
          onPress: () => _goToLanguagePage(context)),
      _buildAccountItemRow(context,
          icon: 'contact_us_account_icon',
          label: 'contact_us',
          onPress: () => _goToContactUsPage(context)),
    ];
  }

  List<Widget> _buildNormalUserAccountRows(BuildContext context) {
    return [
      _buildAccountItemRow(context,
          icon: 'orders_account_icon',
          label: 'orders',
          onPress: () => _goToOrdersPage(context)),
      _buildAccountItemRow(context,
          icon: 'addresses_account_icon',
          label: 'addresses',
          onPress: () => _goToAddressesPage(context)),
      _buildAccountItemRow(context,
          icon: 'wallet_account_icon',
          label: 'wallet',
          onPress: () => _goToWalletPage(context)),
      _buildAccountItemRow(context,
          icon: 'fav_account_icon',
          label: 'favorites',
          onPress: () => _goToFavoritesPage(context)),
      _buildAccountItemRow(context,
          icon: 'change_password_account_icon',
          label: 'change_password',
          onPress: () => _goToChangePasswordPage(context)),
    ];
  }

  Widget _buildAccountItemRow(BuildContext context,
      {required String label,
      required String icon,
      required VoidCallback onPress}) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: context.sizeHelper(
              tabletNormal: 8.0,
              desktopLarge: 16.0,
              mobileLarge: 16.0,
            )),
        child: Row(
          children: [
            SvgPicture.asset('lib/res/assets/$icon.svg', width: 24.0),
            const SizedBox(width: 32.0),
            TitleText(text: label),
            const Spacer(),
            const Icon(
              Icons.chevron_right,
              color: AppColors.PRIMARY_COLOR_DARK,
            ),
          ],
        ),
      ),
    );
  }

  void _goToLanguagePage(BuildContext context) {
    NavigatorHelper.of(context).pushNamed(LanguageChooserPage.routeName);
  }

  void _goToContactUsPage(BuildContext context) {
    NavigatorHelper.of(context).pushNamed(ContactUsPage.routeName);
  }

  void _goToTopicsPage(BuildContext context, int topicId) {
    NavigatorHelper.of(context).push(MaterialPageRoute(builder: (_) {
      return TopicPage(id: topicId);
    }));
  }

  void _goToProfilePage(BuildContext context) {
    NavigatorHelper.of(context).pushNamed(ProfilePage.routeName);
  }

  void _goToOrdersPage(BuildContext context) {
    NavigatorHelper.of(context).pushNamed(OrdersPage.routeName);
  }

  void _goToWalletPage(BuildContext context) {
    NavigatorHelper.of(context).pushNamed(WalletPage.routeName);
  }

  void _goToAddressesPage(BuildContext context) {
    NavigatorHelper.of(context).pushNamed(AddressesScreen.routeName);
  }

  void _goToFavoritesPage(BuildContext context) {
    NavigatorHelper.of(context).pushNamed(FavoritesProductsPage.routeName);
  }

  void _goToChangePasswordPage(BuildContext context) {
    NavigatorHelper.of(context).pushNamed(ChangePasswordPage.routeName);
  }

  // void _goToNotificationsPage(BuildContext context) {
  //   NavigatorHelper.of(context).pushNamed(routeName);
  // }

  // void _goToAboutUsPage(BuildContext context) {
  //   NavigatorHelper.of(context).pushNamed(routeName);
  // }

  // void _goToTermsAndConditionsPage(BuildContext context) {
  //   NavigatorHelper.of(context).pushNamed(routeName);
  // }

  // void _goToPolicyPage(BuildContext context) {
  //   NavigatorHelper.of(context).pushNamed(routeName);
  // }
}
