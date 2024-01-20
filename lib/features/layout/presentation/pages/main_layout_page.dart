import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:size_helper/size_helper.dart';

import '../../../../core/enums/topic_type.dart';
import '../../../../core/utils/navigator_helper.dart';
import '../../../account_tab/presentation/pages/contact_us_page.dart';
import '../../../account_tab/presentation/pages/language_chooser_page.dart';
import '../../../account_tab/presentation/pages/topic_page.dart';
import '../../../cart_tab/presentation/cubit/cart_cubit.dart';
import '../../../cart_tab/presentation/pages/cart_page.dart';
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
            child: _buildZoomDrawer(context, widget, state.currentIndex ?? 0));
      },
    );
  }

  ZoomDrawer _buildZoomDrawer(
      BuildContext context, Widget mainScreen, int selectedIndex) {
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

  Widget _buildLogo() => Container(
        width: 100,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: SvgPicture.asset(
          'lib/res/assets/app_logo.svg',
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLogo(),
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
              onTap: () => _goToTopicsPage(context, TopicType.Privacy.value),
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
              onTap: () => _goToTopicsPage(context, TopicType.AboutUs.value),
              padding: padding,
              fontSize: fontSize,
            ),
          ],
        ));
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
    NavigatorHelper.of(context).pushNamed(ContactUsPage.routeName);
  }

  void _goToTopicsPage(BuildContext context, int topicId) {
    NavigatorHelper.of(context).push(MaterialPageRoute(builder: (_) {
      return TopicPage(id: topicId);
    }));
  }
}
