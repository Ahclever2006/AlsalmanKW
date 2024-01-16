import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:size_helper/size_helper.dart';

import '../../core/utils/navigator_helper.dart';
import '../../features/cart_tab/presentation/cubit/cart_cubit.dart';
import '../../features/cart_tab/presentation/pages/cart_page.dart';
import '../../res/style/app_colors.dart';
import 'title_text.dart';

class CartIcon extends StatelessWidget {
  final bool fromDrawer;
  const CartIcon({super.key, this.fromDrawer = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        var child = InkWell(
          onTap: () {
            _goToCartPage(context);
          },
          child: Padding(
            padding: EdgeInsets.only(
                top: state.cartCount > 0 && !fromDrawer ? 8.0 : 0.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                SvgPicture.asset('lib/res/assets/basket_fill_icon.svg',
                    color: AppColors.PRIMARY_COLOR,
                    width: context.sizeHelper(
                        tabletExtraLarge: 24.0,
                        desktopSmall: 36.0,
                        mobileNormal: state.cartCount > 0 ? 26 : 28)),
                if (state.cartCount > 0)
                  PositionedDirectional(
                    top: context.sizeHelper(
                        tabletExtraLarge: -8.0,
                        desktopSmall: -8.0,
                        mobileNormal: -8.0),
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
            ),
          ),
        );
        if (fromDrawer)
          return child;
        else
          return PositionedDirectional(
              top: state.cartCount > 0 ? 0.0 : 8.0, end: 12, child: child);
      },
    );
  }

  void _goToCartPage(BuildContext context) {
    if (fromDrawer) ZoomDrawer.of(context)!.close();
    NavigatorHelper.of(context)
        .push(MaterialPageRoute(builder: (context) => const CartTab()));
  }
}
