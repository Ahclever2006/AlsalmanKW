import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../core/utils/navigator_helper.dart';
import '../../features/search/presentation/pages/search_products_page.dart';
import '../../res/style/app_colors.dart';
import '../stateful/default_button.dart';
import 'cart_icon.dart';
import 'package:gif/gif.dart';

import 'custom_loading.dart';

class DrawerAppBarWidget extends StatefulWidget {
  final String gifUrl;

  const DrawerAppBarWidget({Key? key, required this.gifUrl}) : super(key: key);

  @override
  State<DrawerAppBarWidget> createState() => _DrawerAppBarWidgetState();
}

class _DrawerAppBarWidgetState extends State<DrawerAppBarWidget>
    with TickerProviderStateMixin {
  late final GifController _controller;
  @override
  void initState() {
    _controller = GifController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              Transform.translate(
                  offset: const Offset(24.0, 0),
                  child: SizedBox(
                    height: 75.0,
                    child: Gif(
                      image: AssetImage(widget.gifUrl),
                      controller: _controller,
                      autostart: Autostart.loop,
                      placeholder: (context) => const CustomLoading(),
                      onFetchCompleted: () {
                        _controller.reset();
                        _controller.forward();
                      },
                    ),
                  )),
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
                  // const SizedBox(width: 4.0),
                  // const CartIcon(fromDrawer: true),
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
