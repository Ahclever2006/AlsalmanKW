import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CartButton extends StatefulWidget {
  const CartButton({
    Key? key,
    required this.onPress,
  }) : super(key: key);

  final VoidCallback onPress;

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          padding: const EdgeInsets.all(6.0),
          child: SvgPicture.asset(
            'lib/res/assets/basket_icon.svg',
          )),
      onTap: widget.onPress,
    );
  }
}
