import 'dart:async';

import 'package:alsalman_app/core/utils/media_query_values.dart';
import 'package:flutter/material.dart';
import 'package:size_helper/size_helper.dart';

import '../../core/utils/type_defs.dart';
import '../../res/style/app_colors.dart';
import '../stateless/title_text.dart';

class QuantityButton extends StatefulWidget {
  const QuantityButton(
      {required this.quantity,
      required this.onAddToCart,
      required this.onRemoveFromCart,
      Key? key})
      : super(key: key);

  final int? quantity;
  final FutureValueChanged<int> onAddToCart;
  final FutureValueChanged<int> onRemoveFromCart;

  @override
  State<QuantityButton> createState() => _QuantityButtonState();
}

class _QuantityButtonState extends State<QuantityButton> {
  @override
  void initState() {
    _quantity = widget.quantity ?? 0;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  late int _quantity;
  Timer? timer;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final double iconSize = context.sizeHelper(
      tabletLarge: 28.0,
      desktopSmall: 40.0,
    );
    return Container(
      width: context.width * 0.35,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: AppColors.ADD_TO_CART_COLOR,
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: decreaseQuantity,
            onLongPress: removeProduct,
            child: Icon(
              Icons.remove,
              size: iconSize,
              color: AppColors.PRIMARY_COLOR,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TitleText(text: _quantity.toString()),
          ),
          GestureDetector(
            onTap: increaseQuantity,
            onLongPressStart: (value) {
              _isPressed = true;
              timer =
                  Timer.periodic(const Duration(milliseconds: 100), (timer) {
                increaseQuantity();
              });
            },
            onLongPressEnd: (details) {
              _isPressed = false;
              timer?.cancel();
            },
            child: Container(
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  color: AppColors.PRIMARY_COLOR,
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: Icon(Icons.add, size: iconSize),
            ),
          ),
        ],
      ),
    );
  }

  void increaseQuantity() {
    setState(() => _quantity++);
    widget.onAddToCart(_quantity);
  }

  void decreaseQuantity() {
    if (_quantity > 1) {
      setState(() => _quantity--);
      widget.onRemoveFromCart(_quantity);
    }
  }

  void removeProduct() {
    _isPressed = true;
    setState(() => _quantity = 0);
    widget.onRemoveFromCart(_quantity);

    _isPressed = false;
  }
}
