import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:size_helper/size_helper.dart';

import '../../core/utils/type_defs.dart';
import '../../res/style/app_colors.dart';
import '../other/show_snack_bar.dart';
import '../stateful/default_button.dart';
import 'custom_cached_network_image.dart';
import 'title_text.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    required this.name,
    this.brand,
    required this.price,
    required this.oldPrice,
    required this.imageUrl,
    required this.onPress,
    this.onAddPress,
    required this.size,
    required this.discount,
    required this.isOutOfStock,
    required this.isSubscribedBackInStock,
    this.isShowAddToCart = false,
    this.notifyMePress,
    required this.heroTag,
  }) : super(key: key);

  final String name;
  final String price;
  final String? oldPrice;
  final String? brand;
  final String imageUrl;
  final VoidCallback onPress;
  final FutureCallback? onAddPress;
  final double size;
  final num discount;
  final bool isOutOfStock;
  final bool isSubscribedBackInStock;
  final bool isShowAddToCart;
  final FutureCallback? notifyMePress;

  final String? heroTag;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final fontSize = context.sizeHelper(
      tabletLarge: 16.0,
      desktopSmall: 26.0,
    );

    Widget customCachedNetworkImage = Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.GREY_BORDER_COLOR),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: CustomCachedNetworkImage(
        imageUrl: widget.imageUrl,
        imageMode: ImageMode.Pad,
        scaleMode: ScaleMode.Both,
        urlWidth: 400,
        urlHeight: 400,
        fit: BoxFit.cover,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        height: widget.size,
        width: widget.size,
      ),
    );

    if (widget.heroTag != null)
      customCachedNetworkImage = Hero(
        transitionOnUserGestures: true,
        tag: widget.heroTag!,
        child: customCachedNetworkImage,
      );

    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        //color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              InkWell(
                onTap: widget.onPress,
                child: customCachedNetworkImage,
              ),
              if (widget.isOutOfStock)
                DefaultButton(
                    label: 'sold_out'.tr(),
                    backgroundColor: Colors.black38,
                    onPressed: widget.isSubscribedBackInStock
                        ? () {
                            showSnackBar(context,
                                message: 'already_subscribed');
                          }
                        : widget.notifyMePress),
              if (widget.discount > 0)
                PositionedDirectional(
                  start: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    decoration: const BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(10.0),
                          bottomEnd: Radius.circular(10.0)),
                    ),
                    child: TitleText.medium(
                        textAlign: TextAlign.center,
                        text: '${widget.discount.floor()} %\n ${'off'.tr()}',
                        color: Colors.white),
                  ),
                ),
            ],
          ),
          if (widget.brand != null) _buildBrandName(fontSize),
          _buildProductName(fontSize),
          _buildProductPrice(fontSize),
        ],
      ),
    );
  }

  Widget _buildProductName(double fontSize) {
    return SizedBox(
      width: widget.size,
      child: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: TitleText.small(
            text: widget.name,
            // textAlign: TextAlign.center,
            maxLines: 2, color: AppColors.PRIMARY_COLOR_DARK,
          )),
    );
  }

  Widget _buildBrandName(double fontSize) {
    return SizedBox(
      width: widget.size,
      child: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: TitleText.medium(
              text: widget.brand ?? '',
              textAlign: TextAlign.center,
              maxLines: 1)),
    );
  }

  Widget _buildProductPrice(double fontSize) {
    return Container(
      width: widget.size,
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          children: [
            TitleText.medium(
              text: widget.price,
              maxLines: 1,
              color: AppColors.PRIMARY_COLOR_DARK,
            ),
            // if (widget.oldPrice != null)
            //   TitleText.medium(
            //     text: widget.oldPrice!,
            //     maxLines: 1,
            //     isLineThrough: true,
            //     color: Colors.red,
            //   ),
          ],
        ),
        if (widget.isShowAddToCart && widget.onAddPress != null)
          DefaultButton(
              icon: const Icon(Icons.add),
              padding: const EdgeInsets.all(8.0),
              onPressed: () => widget.onAddPress!())
      ]),
    );
  }
}
