import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:size_helper/size_helper.dart';
import 'cart_icon.dart';

import '../../core/utils/navigator_helper.dart';
import '../../core/utils/type_defs.dart';
import '../../features/search/presentation/pages/search_products_page.dart';
import '../../res/style/app_colors.dart';
import '../stateful/default_button.dart';
import 'title_text.dart';

class InnerPagesAppBar extends StatelessWidget {
  const InnerPagesAppBar({
    this.label,
    this.snackBarMargin,
    this.onActionPress,
    this.actionIcon,
    this.backIcon,
    this.onSearchPress,
    this.viewCartIcon = false,
    this.viewSearchIcon = false,
    this.padding = const EdgeInsets.symmetric(vertical: 16.0),
    this.forceHideBackButton = false,
    Key? key,
  }) : super(key: key);

  final String? label;
  final EdgeInsetsGeometry? snackBarMargin;
  final EdgeInsetsGeometry padding;
  final FutureCallback? onActionPress;
  final FutureCallback? onSearchPress;
  final String? actionIcon;
  final String? backIcon;
  final bool forceHideBackButton;
  final bool viewCartIcon;
  final bool viewSearchIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: TitleText(
              text: label ?? '',
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              textAlign: TextAlign.center,
            ),
          ),
          if (NavigatorHelper.of(context).canPop() && !forceHideBackButton)
            PositionedDirectional(
              top: 0.0,
              start: 8.0,
              child: InkWell(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: backIcon == null
                      ? SvgPicture.asset(
                          'lib/res/assets/back_arrow.svg',
                          height: 20.0,
                          matchTextDirection: true,
                        )
                      : SvgPicture.asset(
                          'lib/res/assets/$backIcon.svg',
                          height: 20.0,
                          matchTextDirection: true,
                        ),
                ),
                onTap: () {
                  NavigatorHelper.of(context).pop();
                },
              ),
            ),
          if (viewSearchIcon)
            PositionedDirectional(
              top: -8.0,
              end: viewCartIcon ? 48.0 : 16.0,
              child: DefaultButton(
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  icon: SvgPicture.asset('lib/res/assets/search_icon.svg',
                      color: AppColors.PRIMARY_COLOR,
                      width: context.sizeHelper(
                          tabletExtraLarge: 24.0,
                          desktopSmall: 36.0,
                          mobileNormal: 26.0)),
                  onPressed: () {
                    _goToSearchPage(context);
                  }),
            ),
          if (viewCartIcon) const CartIcon(),
          if (actionIcon != null)
            PositionedDirectional(
              top: -8.0,
              end: 8.0,
              child: DefaultButton(
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  icon: SvgPicture.asset(
                    'lib/res/assets/$actionIcon.svg',
                    color: AppColors.PRIMARY_COLOR,
                    width: context.sizeHelper(
                        tabletExtraLarge: 24.0,
                        desktopSmall: 36.0,
                        mobileNormal: 26.0),
                  ),
                  onPressed: onActionPress),
            ),
        ],
      ),
    );
  }

  void _goToSearchPage(BuildContext context) {
    NavigatorHelper.of(context).push(MaterialPageRoute(builder: (_) {
      return const SearchProductsPage();
    }));
  }
}
