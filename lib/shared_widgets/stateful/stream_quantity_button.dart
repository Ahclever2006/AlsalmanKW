import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:size_helper/size_helper.dart';

import '../../core/utils/type_defs.dart';
import '../../res/style/app_colors.dart';
import '../stateless/title_text.dart';

class StreamQuantityButton extends StatefulWidget {
  const StreamQuantityButton(
      {required this.quantity,
      required this.onAddToCart,
      required this.onRemoveFromCart,
      Key? key})
      : super(key: key);

  final int? quantity;
  final FutureValueChanged<int> onAddToCart;
  final FutureValueChanged<int> onRemoveFromCart;

  @override
  State<StreamQuantityButton> createState() => _StreamQuantityButtonState();
}

class _StreamQuantityButtonState extends State<StreamQuantityButton> {
  StreamController<int>? streamController;

  @override
  void initState() {
    _quantity = widget.quantity ?? 0;
    super.initState();
  }

  @override
  void dispose() {
    _closeStream();
    super.dispose();
  }

  late int _quantity;
  Timer? timer;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final double iconSize = context.sizeHelper(
      tabletLarge: 30.0,
      desktopSmall: 40.0,
    );
    return AnimatedSize(
        duration: const Duration(milliseconds: 900),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.GREY_BORDER_COLOR),
            borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: decreaseQuantity,
                // onLongPress: removeProduct,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.GREY_BORDER_COLOR),
                    borderRadius: const BorderRadiusDirectional.only(
                      bottomStart: Radius.circular(6.0),
                      topStart: Radius.circular(6.0),
                    ),
                  ),
                  child: Icon(
                    Icons.remove,
                    size: iconSize,
                    color: AppColors.PRIMARY_COLOR,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TitleText(
                  text: _quantity.toString().padLeft(2, '0'),
                  color: AppColors.PRIMARY_COLOR_DARK,
                ),
              ),
              GestureDetector(
                onTap: increaseQuantity,
                onLongPressStart: (value) {
                  _isPressed = true;
                  timer = Timer.periodic(const Duration(milliseconds: 100),
                      (timer) {
                    increaseQuantity();
                  });
                },
                onLongPressEnd: (details) {
                  _isPressed = false;
                  timer?.cancel();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.GREY_BORDER_COLOR),
                    borderRadius: const BorderRadiusDirectional.only(
                      topEnd: Radius.circular(6.0),
                      bottomEnd: Radius.circular(6.0),
                    ),
                  ),
                  child: Icon(
                    Icons.add,
                    size: iconSize,
                    color: AppColors.PRIMARY_COLOR,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void increaseQuantity() {
    _createStreamIfNeeded();

    setState(() => _quantity++);
    streamController?.add(_quantity);
  }

  void decreaseQuantity() {
    _createStreamIfNeeded();
    if (_quantity > 1) setState(() => _quantity--);
    streamController?.add(_quantity);
  }

  // void removeProduct() {
  //   _isPressed = true;
  //   _createStreamIfNeeded();
  //   setState(() => _quantity = 0);
  //   streamController?.add(_quantity);
  //   _isPressed = false;
  // }

  void _createStreamIfNeeded() {
    if (streamController == null) {
      streamController = StreamController<int>();
      _buildStreamListener();
    }
  }

  void _closeStream() {
    streamController?.close();
    streamController = null;
  }

  void onTimeOut(Stream<int>? stream) {
    if (stream == null) return;
    if (!_isPressed)
      _closeStream();
    else
      stream.timeout(const Duration(seconds: 5),
          onTimeout: (_) => onTimeOut(stream));
  }

  void _buildStreamListener() {
    streamController?.stream
        .debounceTime(const Duration(milliseconds: 600))
        .distinct()
        .timeout(
          const Duration(seconds: 5),
          onTimeout: (_) => onTimeOut(streamController?.stream),
        )
        .listen((value) async {
      await widget.onAddToCart(value);
    });
  }
}
