import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:size_helper/size_helper.dart';

import '../../../cart_tab/presentation/cubit/cart_cubit.dart';
import '../../../cart_tab/presentation/pages/cart_page.dart';
import '../cubit/main_layout_cubit.dart';
import '../../../../shared_widgets/stateless/title_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../res/style/app_colors.dart';
import '../../../account_tab/presentation/pages/account_tab.dart';
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
      const CartTab(),
      const AccountTab(),
    ];
    return BlocBuilder<MainLayoutCubit, MainLayoutState>(
      builder: (context, state) {
        var widget =
            Scaffold(extendBody: true, body: pages[state.currentIndex!]);
        return Material(
            color: AppColors.BACKGROUND_COLOR,
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
      slideWidth: width * 0.45,
      mainScreenOverlayColor: Colors.black12,
      mainScreen: mainScreen,
      menuScreen: _buildDrawer(context, selectedIndex),
    );
  }

  Widget _buildLogo() => Container(
        width: 100,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: SvgPicture.asset(
          'lib/res/assets/app_logo.svg',
        ),
      );

  Widget _buildDrawer(BuildContext context, int selectedIndex) {
    final padding = context.sizeHelper(
      tabletNormal: 8.0,
      tabletLarge: 12.0,
      desktopSmall: 24.0,
    );

    final fontSize = context.sizeHelper(
      tabletLarge: 16.0,
      desktopSmall: 24.0,
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
              title: 'home'.tr(),
              icon: SvgPicture.asset(
                'lib/res/assets/home_icon.svg',
                color: selectedIndex == 0
                    ? AppColors.PRIMARY_COLOR
                    : AppColors.GREY_NORMAL_COLOR,
                width: context.sizeHelper(
                  tabletExtraLarge: 24.0,
                  desktopSmall: 36.0,
                ),
              ),
              onTap: () => _createNavbarCallback(context, 0),
            ),
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
                        color: selectedIndex == 1
                            ? AppColors.PRIMARY_COLOR
                            : AppColors.GREY_NORMAL_COLOR,
                        width: context.sizeHelper(
                          tabletExtraLarge: 24.0,
                          desktopSmall: 36.0,
                        ),
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
              onTap: () => _createNavbarCallback(context, 1),
            ),
            _buildDrawerItem(
              title: 'my_account'.tr(),
              icon: SvgPicture.asset(
                'lib/res/assets/user_icon.svg',
                color: selectedIndex == 2
                    ? AppColors.PRIMARY_COLOR
                    : AppColors.GREY_NORMAL_COLOR,
                width: context.sizeHelper(
                  tabletExtraLarge: 24.0,
                  desktopSmall: 36.0,
                ),
              ),
              onTap: () => _createNavbarCallback(context, 2),
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            icon,
            const SizedBox(width: 8),
            TitleText(text: title),
          ],
        ),
      ),
    );
  }

// class _CustomBottomNavBar extends StatefulWidget {
//   const _CustomBottomNavBar({
//     required this.selectedIndex,
//     Key? key,
//   }) : super(key: key);

//   final int selectedIndex;

//   @override
//   State<_CustomBottomNavBar> createState() => _CustomBottomNavBarState();
// }

// class _CustomBottomNavBarState extends State<_CustomBottomNavBar> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: context.sizeHelper(
//         tabletExtraLarge: navbarHeight,
//         desktopSmall: navbarHeight * 1.5,
//       ),
//       width: context.width,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Container(
//             margin: const EdgeInsets.all(8.0),
//             height: context.sizeHelper(
//               tabletExtraLarge: navbarHeight,
//               desktopSmall: navbarHeight * 1.5,
//             ),
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               boxShadow: AppColors.SHADOW_LIGHT,
//               borderRadius: BorderRadius.vertical(
//                   top: Radius.circular(24.0), bottom: Radius.circular(8.0)),
//             ),
//           ),
//           Container(
//             height: context.sizeHelper(
//               tabletExtraLarge: navbarHeight,
//               desktopSmall: navbarHeight * 1.5,
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 12.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildNormalNavBarItem(
//                   title: 'account'.tr(),
//                   icon: SvgPicture.asset(
//                     'lib/res/assets/home_icon.svg',
//                     color: widget.selectedIndex == 0
//                         ? AppColors.PRIMARY_COLOR
//                         : AppColors.GREY_NORMAL_COLOR,
//                     width: context.sizeHelper(
//                       tabletExtraLarge: 24.0,
//                       desktopSmall: 36.0,
//                     ),
//                   ),
//                   onTap: () => _createNavbarCallback(context, 0),
//                 ),
//                 _buildNormalNavBarItem(
//                   title: 'projects'.tr(),
//                   icon: SvgPicture.asset(
//                     'lib/res/assets/search_icon.svg',
//                     color: widget.selectedIndex == 1
//                         ? AppColors.PRIMARY_COLOR
//                         : AppColors.GREY_NORMAL_COLOR,
//                     width: context.sizeHelper(
//                       tabletExtraLarge: 24.0,
//                       desktopSmall: 36.0,
//                     ),
//                   ),
//                   onTap: () => _createNavbarCallback(context, 1),
//                 ),
//                 _buildNormalNavBarItem(
//                   title: 'developer'.tr(),
//                   icon: BlocBuilder<CartCubit, CartState>(
//                     builder: (context, state) {
//                       return Stack(
//                         alignment: AlignmentDirectional.center,
//                         clipBehavior: Clip.none,
//                         children: [
//                           SvgPicture.asset(
//                             'lib/res/assets/basket_fill_icon.svg',
//                             color: widget.selectedIndex == 2
//                                 ? AppColors.PRIMARY_COLOR
//                                 : AppColors.GREY_NORMAL_COLOR,
//                             width: context.sizeHelper(
//                               tabletExtraLarge: 24.0,
//                               desktopSmall: 36.0,
//                             ),
//                           ),
//                           if (state.cartCount > 0)
//                             PositionedDirectional(
//                               top: -8.0,
//                               end: 16.0,
//                               child: Container(
//                                 decoration: const BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: AppColors.PRIMARY_COLOR_DARK),
//                                 padding: const EdgeInsets.all(6.0),
//                                 child: TitleText.medium(
//                                   text: '${state.cartCount}',
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                         ],
//                       );
//                     },
//                   ),
//                   onTap: () => _createNavbarCallback(context, 2),
//                 ),
//                 _buildNormalNavBarItem(
//                   title: 'account'.tr(),
//                   icon: SvgPicture.asset(
//                     'lib/res/assets/user_icon.svg',
//                     color: widget.selectedIndex == 3
//                         ? AppColors.PRIMARY_COLOR
//                         : AppColors.GREY_NORMAL_COLOR,
//                     width: context.sizeHelper(
//                       tabletExtraLarge: 24.0,
//                       desktopSmall: 36.0,
//                     ),
//                   ),
//                   onTap: () => _createNavbarCallback(context, 3),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

  // Widget _buildNormalNavBarItem({
  //   required String title,
  //   required Widget icon,
  //   required VoidCallback onTap,
  // }) {
  //   return Flexible(
  //     child: Container(
  //       margin: const EdgeInsets.symmetric(horizontal: 4.0),
  //       alignment: Alignment.center,
  //       child: InkWell(
  //         onTap: onTap,
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [icon],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void _createNavbarCallback(BuildContext context, int tabNum) {
    drawerController.toggle!();
    final cubit = context.read<MainLayoutCubit>();
    cubit.onBottomNavPressed(tabNum);
  }
}
