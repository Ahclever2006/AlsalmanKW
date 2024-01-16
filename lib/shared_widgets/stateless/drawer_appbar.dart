import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../core/utils/navigator_helper.dart';
import '../../features/search/presentation/pages/search_products_page.dart';
import '../../res/style/app_colors.dart';
import '../stateful/default_button.dart';
import 'cart_icon.dart';

class DrawerAppBarWidget extends StatelessWidget {
  final Widget title;

  const DrawerAppBarWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      flexibleSpace: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDrawerIcon(context),
              Transform.translate(offset: const Offset(24.0, 0), child: title),
              Row(
                children: [
                  DefaultButton(
                      backgroundColor: Colors.transparent,
                      icon: SvgPicture.asset(
                        'lib/res/assets/search_icon.svg',
                        color: AppColors.PRIMARY_COLOR,
                      ),
                      onPressed: () {
                        _goToSearchPage(context);
                      }),
                  const SizedBox(width: 4.0),
                  const CartIcon(fromDrawer: true),
                ],
              )
            ],
          )),
    );
  }

  Widget _buildDrawerIcon(BuildContext context) {
    return InkWell(
      onTap: () {
        ZoomDrawer.of(context)!.open();
      },
      child: const Icon(
        Icons.menu,
        color: AppColors.PRIMARY_COLOR,
        size: 30,
      ),
    );
  }

  void _goToSearchPage(BuildContext context) {
    NavigatorHelper.of(context).pushNamed(SearchProductsPage.routeName);
  }
}
