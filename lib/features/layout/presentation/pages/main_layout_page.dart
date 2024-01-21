import 'package:alsalman_app/core/utils/media_query_values.dart';
import 'package:alsalman_app/shared_widgets/stateless/subtitle_text.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:size_helper/size_helper.dart';

import '../../../../core/enums/topic_type.dart';
import '../../../../core/utils/navigator_helper.dart';
import '../../../../shared_widgets/stateful/default_button.dart';
import '../../../account_tab/presentation/pages/change_password_page.dart';
import '../../../account_tab/presentation/pages/contact_us_page.dart';
import '../../../account_tab/presentation/pages/language_chooser_page.dart';
import '../../../account_tab/presentation/pages/profile_page.dart';
import '../../../account_tab/presentation/pages/topic_page.dart';
import '../../../address/presentation/pages/address_screen.dart';
import '../../../auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../../../cart_tab/presentation/cubit/cart_cubit.dart';
import '../../../cart_tab/presentation/pages/cart_page.dart';
import '../../../favorites/presentation/pages/favorites_products_page.dart';
import '../../../notifications/presentation/pages/notifications_page.dart';
import '../../../orders/presentation/pages/orders_page.dart';
import '../../../wallet/presentation/pages/wallet_page.dart';
import '../cubit/main_layout_cubit.dart';
import '../../../../shared_widgets/stateless/title_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../res/style/app_colors.dart';
import '../../../home_tab/presentation/pages/home_tab.dart';

class MainLayOutPage extends StatefulWidget {
  static const routeName = '/MainLayOutPage';
  const MainLayOutPage({Key? key}) : super(key: key);

  @override
  State<MainLayOutPage> createState() => _MainLayOutPageState();
}

class _MainLayOutPageState extends State<MainLayOutPage> {
  final drawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const HomeTab(),
    ];
    return BlocBuilder<MainLayoutCubit, MainLayoutState>(
      builder: (context, state) {
        var widget =
            Scaffold(extendBody: true, body: pages[state.currentIndex!]);
        return Material(
            color: AppColors.CUSTOM_APP_PAGE_COLOR,
            type: MaterialType.card,
            child: _buildZoomDrawer(context, widget));
      },
    );
  }

  ZoomDrawer _buildZoomDrawer(BuildContext context, Widget mainScreen) {
    var width = MediaQuery.of(context).size.width;
    return ZoomDrawer(
      controller: drawerController,
      duration: const Duration(milliseconds: 400),
      mainScreenScale: 0.3,
      boxShadow: AppColors.SHADOW,
      angle: 0,
      isRtl: context.locale == const Locale('ar'),
      clipMainScreen: true,
      borderRadius: 20,
      disableDragGesture: true,
      androidCloseOnBackTap: true,
      mainScreenTapClose: true,
      menuScreenWidth: width,
      slideWidth: width * 0.80,
      mainScreenOverlayColor: Colors.black12,
      mainScreen: mainScreen,
      menuScreen: _buildDrawer(context),
    );
  }

  Widget _buildLogo() => Padding(
        padding: EdgeInsets.only(
            left: 32.0, right: 32.0, top: context.toPadding, bottom: 24.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: double.infinity,
              height: 70.0,
              padding: const EdgeInsets.only(top: 8.0),
              child: SvgPicture.asset('lib/res/assets/app_logo.svg'),
            ),
            PositionedDirectional(
              top: 16.0,
              end: 8.0,
              child: InkWell(
                child: Container(
                  padding: const EdgeInsets.all(2.0),
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Icon(
                    Icons.chevron_left,
                    color: AppColors.PRIMARY_COLOR,
                    size: context.sizeHelper(
                      tabletLarge: 36.0,
                      desktopSmall: 45.0,
                    ),
                  ),
                ),
                onTap: () {
                  drawerController.toggle!();
                },
              ),
            ),
          ],
        ),
      );

  Widget _buildDrawer(BuildContext context) {
    final padding = context.sizeHelper(
      tabletNormal: 8.0,
      tabletLarge: 12.0,
      desktopSmall: 24.0,
    );

    final fontSize = context.sizeHelper(
      tabletLarge: 16.0,
      desktopSmall: 24.0,
    );

    final iconWidth = context.sizeHelper(
      tabletExtraLarge: 24.0,
      desktopSmall: 36.0,
    );
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final isLoggedIn = state.isUserLoggedIn;
            if (isLoggedIn && state.userInfo == null) {
              final authCubit = context.read<AuthCubit>();
              authCubit.getUserData();
            }
            return ListView(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              children: [
                _buildLogo(),
                if (!isLoggedIn) _buildGuestUserSection(context),
                if (isLoggedIn)
                  _buildNormalUserSection(
                      context,
                      state.userInfo?.data?.firstName ?? '',
                      state.userInfo?.data?.email ?? ''),
                _buildDrawerItem(
                  padding: padding,
                  fontSize: fontSize,
                  title: 'basket'.tr(),
                  icon: BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      return Stack(
                        alignment: AlignmentDirectional.center,
                        clipBehavior: Clip.none,
                        children: [
                          SvgPicture.asset(
                            'lib/res/assets/basket_fill_icon.svg',
                            width: iconWidth,
                            height: iconWidth,
                          ),
                          if (state.cartCount > 0)
                            PositionedDirectional(
                              top: -8.0,
                              end: 16.0,
                              child: Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.PRIMARY_COLOR_DARK),
                                padding: const EdgeInsets.all(6.0),
                                child: TitleText.medium(
                                  text: '${state.cartCount}',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  onTap: () => _goToCartPage(context),
                ),
                if (isLoggedIn)
                  _buildDrawerItem(
                    title: 'favorites'.tr(),
                    icon: SvgPicture.asset(
                      'lib/res/assets/fav_account_icon.svg',
                      width: iconWidth,
                      height: iconWidth,
                    ),
                    onTap: () => _goToFavoritesPage(context),
                    padding: padding,
                    fontSize: fontSize,
                  ),
                if (isLoggedIn)
                  _buildDrawerItem(
                    title: 'wallet'.tr(),
                    icon: SvgPicture.asset(
                      'lib/res/assets/wallet_account_icon.svg',
                      width: iconWidth,
                      height: iconWidth,
                    ),
                    onTap: () => _goToWalletPage(context),
                    padding: padding,
                    fontSize: fontSize,
                  ),
                if (isLoggedIn) _buildDivider(),
                if (isLoggedIn)
                  _buildDrawerItem(
                    title: 'orders'.tr(),
                    icon: SvgPicture.asset(
                      'lib/res/assets/orders_account_icon.svg',
                      width: iconWidth,
                      height: iconWidth,
                    ),
                    onTap: () => _goToOrdersPage(context),
                    padding: padding,
                    fontSize: fontSize,
                  ),
                if (isLoggedIn)
                  _buildDrawerItem(
                    title: 'addresses'.tr(),
                    icon: SvgPicture.asset(
                      'lib/res/assets/addresses_account_icon.svg',
                      width: iconWidth,
                      height: iconWidth,
                    ),
                    onTap: () => _goToAddressesPage(context),
                    padding: padding,
                    fontSize: fontSize,
                  ),
                _buildDivider(),
                _buildDrawerItem(
                  title: 'change_password'.tr(),
                  icon: SvgPicture.asset(
                    'lib/res/assets/change_password_account_icon.svg',
                    width: iconWidth,
                  ),
                  onTap: () => _goToChangePasswordPage(context),
                  padding: padding,
                  fontSize: fontSize,
                ),
                _buildDrawerItem(
                  title: 'notifications'.tr(),
                  icon: SvgPicture.asset(
                    'lib/res/assets/notification_account_icon.svg',
                    width: iconWidth,
                    height: iconWidth,
                  ),
                  onTap: () => _goToNotificationsPage(context),
                  padding: padding,
                  fontSize: fontSize,
                ),
                _buildDrawerItem(
                  title: 'language'.tr(),
                  icon: SvgPicture.asset(
                    'lib/res/assets/language_icon.svg',
                    width: iconWidth,
                    height: iconWidth,
                  ),
                  onTap: () => _goToLanguagePage(context),
                  padding: padding,
                  fontSize: fontSize,
                ),
                _buildDivider(),
                _buildDrawerItem(
                  title: 'contact_us'.tr(),
                  icon: SvgPicture.asset(
                    'lib/res/assets/contact_us_account_icon.svg',
                    width: iconWidth,
                    height: iconWidth,
                  ),
                  onTap: () => _goToContactUsPage(context),
                  padding: padding,
                  fontSize: fontSize,
                ),
                _buildDrawerItem(
                  title: 'privacy_policy'.tr(),
                  icon: SvgPicture.asset(
                    'lib/res/assets/privacy_account_icon.svg',
                    width: iconWidth,
                    height: iconWidth,
                  ),
                  onTap: () =>
                      _goToTopicsPage(context, TopicType.Privacy.value),
                  padding: padding,
                  fontSize: fontSize,
                ),
                _buildDrawerItem(
                  title: 'terms_of_use'.tr(),
                  icon: SvgPicture.asset(
                    'lib/res/assets/terms_account_icon.svg',
                    width: iconWidth,
                    height: iconWidth,
                  ),
                  onTap: () => _goToTopicsPage(context, TopicType.Terms.value),
                  padding: padding,
                  fontSize: fontSize,
                ),
                _buildDrawerItem(
                  title: 'about_us'.tr(),
                  icon: SvgPicture.asset(
                    'lib/res/assets/about_us_account_icon.svg',
                    width: iconWidth,
                    height: iconWidth,
                  ),
                  onTap: () =>
                      _goToTopicsPage(context, TopicType.AboutUs.value),
                  padding: padding,
                  fontSize: fontSize,
                ),
              ],
            );
          },
        ));
  }

  Widget _buildGuestUserSection(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsetsDirectional.only(end: context.width * 0.2),
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SubtitleText(
              text: 'welcome_guest',
              color: AppColors.PRIMARY_COLOR,
            ),
            const SizedBox(height: 12.0),
            const SubtitleText(text: 'not_logged_in'),
            const SizedBox(height: 12.0),
            DefaultButton(
                label: 'login'.tr().toUpperCase(),
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 12.0),
                onPressed: () => _goToLoginPage(context)),
          ],
        ));
  }

  void _goToLoginPage(BuildContext context) {
    drawerController.toggle!();

    NavigatorHelper.of(context).pushNamed(LoginPage.routeName);
  }

  Widget _buildNormalUserSection(
      BuildContext context, String? username, String? email) {
    return Container(
        width: double.infinity,
        margin: EdgeInsetsDirectional.only(end: context.width * 0.2),
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TitleText(
                  text: 'welcome'.tr(args: [username ?? 'user_name'.tr()]),
                  color: AppColors.PRIMARY_COLOR,
                  maxLines: 2),
              const SizedBox(height: 12.0),
              SubtitleText(
                text: email ?? 'Unknown',
                color: AppColors.PRIMARY_COLOR_DARK,
              ),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: InkWell(
                    onTap: () => _goToProfilePage(context),
                    child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                            color: AppColors.PRIMARY_COLOR,
                            shape: BoxShape.circle),
                        child: SvgPicture.asset(
                            'lib/res/assets/settings_icon.svg'))),
              ),
            ],
          ),
        ));
  }

  void _goToProfilePage(BuildContext context) {
    drawerController.toggle!();

    NavigatorHelper.of(context).pushNamed(ProfilePage.routeName);
  }

  Widget _buildDivider() {
    return Divider(
      thickness: 1,
      color: AppColors.PRIMARY_COLOR,
      endIndent: context.width * 0.22,
    );
  }

  Widget _buildDrawerItem(
      {required String title,
      required VoidCallback onTap,
      required double padding,
      required double fontSize,
      required Widget icon}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 8),
            Expanded(
                flex: 3,
                child: TitleText(
                    text: title, color: AppColors.PRIMARY_COLOR_DARK)),
            const Icon(
              Icons.chevron_right,
              color: AppColors.PRIMARY_COLOR_DARK,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void _goToLanguagePage(BuildContext context) {
    drawerController.toggle!();

    NavigatorHelper.of(context).pushNamed(LanguageChooserPage.routeName);
  }

  void _goToCartPage(BuildContext context) {
    drawerController.toggle!();

    NavigatorHelper.of(context).pushNamed(CartTab.routeName);
  }

  void _goToContactUsPage(BuildContext context) {
    drawerController.toggle!();

    NavigatorHelper.of(context).pushNamed(ContactUsPage.routeName);
  }

  void _goToTopicsPage(BuildContext context, int topicId) {
    drawerController.toggle!();

    NavigatorHelper.of(context).push(MaterialPageRoute(builder: (_) {
      return TopicPage(id: topicId);
    }));
  }

  void _goToFavoritesPage(BuildContext context) {
    drawerController.toggle!();

    NavigatorHelper.of(context).pushNamed(FavoritesProductsPage.routeName);
  }

  void _goToWalletPage(BuildContext context) {
    drawerController.toggle!();

    NavigatorHelper.of(context).pushNamed(WalletPage.routeName);
  }

  void _goToOrdersPage(BuildContext context) {
    drawerController.toggle!();

    NavigatorHelper.of(context).pushNamed(OrdersPage.routeName);
  }

  void _goToAddressesPage(BuildContext context) {
    drawerController.toggle!();

    NavigatorHelper.of(context).pushNamed(AddressesScreen.routeName);
  }

  void _goToChangePasswordPage(BuildContext context) {
    drawerController.toggle!();

    NavigatorHelper.of(context).pushNamed(ChangePasswordPage.routeName);
  }

  void _goToNotificationsPage(BuildContext context) {
    drawerController.toggle!();

    NavigatorHelper.of(context).pushNamed(NotificationsPage.routeName);
  }
}
