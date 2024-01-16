import 'dart:async';

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
      tabletLarge: 24.0,
      desktopSmall: 40.0,
    );
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.PRIMARY_COLOR_DARK),
          borderRadius: const BorderRadius.all(Radius.circular(24.0))),
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      padding: const EdgeInsets.all(16.0),
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
            child: Icon(
              Icons.add,
              size: iconSize,
              color: AppColors.PRIMARY_COLOR,
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
    if (_quantity > 0) {
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
