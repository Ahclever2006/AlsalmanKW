import 'package:flutter/material.dart';

import '../../res/style/app_colors.dart';
import '../stateless/subtitle_text.dart';
import '../stateless/title_text.dart';

class CartGiftCardWidget extends StatefulWidget {
  const CartGiftCardWidget({
    super.key,
    required this.price,
    this.onPress,
    required this.from,
    required this.to,
    required this.message,
    this.margin = const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 32.0),
    this.color = AppColors.PRIMARY_COLOR_LIGHT,
    required this.cardType,
  });

  final String from;
  final String to;
  final String message;
  final String cardType;
  final String price;
  final Color color;
  final EdgeInsetsGeometry margin;
  final VoidCallback? onPress;

  @override
  State<CartGiftCardWidget> createState() => _CartGiftCardWidgetState();
}

class _CartGiftCardWidgetState extends State<CartGiftCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.onPress != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleText(text: 'message_card'),
                    const SizedBox(height: 16.0),
                    TitleText(text: widget.price),
                  ],
                ),
                InkWell(
                  child: Container(
                    width: 24.0,
                    height: 24.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.PRIMARY_COLOR_DARK, width: 2.0),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 20.0,
                      color: AppColors.PRIMARY_COLOR_DARK,
                    ),
                  ),
                  onTap: widget.onPress,
                )
              ],
            ),
          if (widget.onPress != null)
            const Divider(
              color: AppColors.PRIMARY_COLOR_DARK,
              thickness: 1.0,
            ),
          if (widget.onPress != null) const SizedBox(height: 8.0),
          const TitleText(text: 'card_design'),
          Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: AppColors.PRIMARY_COLOR,
              border: Border.all(color: AppColors.PRIMARY_COLOR),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: SubtitleText(
              text: widget.cardType,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8.0),
          const TitleText(text: 'from'),
          const SizedBox(height: 8.0),
          SubtitleText(text: widget.from),
          const SizedBox(height: 16.0),
          const TitleText(text: 'to'),
          const SizedBox(height: 8.0),
          SubtitleText(text: widget.to),
          const SizedBox(height: 16.0),
          const TitleText(text: 'card_message'),
          const SizedBox(height: 8.0),
          SubtitleText(text: widget.message),
        ],
      ),
    );
  }
}
