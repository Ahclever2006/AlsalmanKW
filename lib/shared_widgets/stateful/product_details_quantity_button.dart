// import 'dart:async';

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:rxdart/rxdart.dart';

// import '../../core/utils/type_defs.dart';
// import '../../res/style/app_colors.dart';
// import '../other/show_snack_bar.dart';

// class ProductDetailsQuantityButton extends StatefulWidget {
//   const ProductDetailsQuantityButton({
//     required this.quantity,
//     required this.onAddToCart,
//     required this.onRemoveFromCart,
//     Key? key,
//   }) : super(key: key);
//   final int? quantity;
//   final ValueChangedCustom<int, AllowValueModel?> onAddToCart;
//   final ValueChangedCustom<int, AllowValueModel?> onRemoveFromCart;

//   @override
//   State<ProductDetailsQuantityButton> createState() =>
//       _ProductDetailsQuantityButtonState();
// }

// class _ProductDetailsQuantityButtonState
//     extends State<ProductDetailsQuantityButton> {
//   StreamController<int>? streamController;

//   @override
//   void initState() {
//     _quantity = widget.quantity ?? 0;

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _closeStream();
//     super.dispose();
//   }

//   late int _quantity;
//   Timer? timer;
//   bool _isPressed = false;

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSize(
//         duration: const Duration(milliseconds: 300),
//         child: _quantity == 0
//             ? Container(
//                 padding: const EdgeInsets.all(16.0),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                 ),
//                 child: InkWell(
//                   onTap: increaseQuantity,
//                   child: const Icon(
//                     Icons.add_circle_outline_sharp,
//                     color: AppColors.PRIMARY_COLOR,
//                   ),
//                 ),
//               )
//             : Container(
//                 alignment: AlignmentDirectional.center,
//                 padding: const EdgeInsets.all(16.0),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     InkWell(
//                       onTap: decreaseQuantity,
//                       onLongPress: removeProduct,
//                       child: const Icon(
//                         Icons.delete,
//                         color: AppColors.PRIMARY_COLOR,
//                       ),
//                     ),
//                     Text(
//                       _quantity.toString().padLeft(2, '0'),
//                       style: Theme.of(context).textTheme.displayLarge!.copyWith(
//                             color: AppColors.PRIMARY_COLOR,
//                           ),
//                     ),
//                     GestureDetector(
//                       onTap: increaseQuantity,
//                       onLongPressStart: (value) {
//                         _isPressed = true;
//                         timer = Timer.periodic(
//                             const Duration(milliseconds: 100), (timer) {
//                           increaseQuantity();
//                         });
//                       },
//                       onLongPressEnd: (details) {
//                         _isPressed = false;
//                         timer?.cancel();
//                       },
//                       child: const Icon(
//                         Icons.add_circle_outline_sharp,
//                         color: AppColors.PRIMARY_COLOR,
//                       ),
//                     ),
//                   ],
//                 ),
//               ));
//   }

//   void increaseQuantity() {
//     _createStreamIfNeeded();
//     setState(() {
//       _quantity++;
//     });
//     streamController?.add(_quantity);
//   }

//   void decreaseQuantity() {
//     _createStreamIfNeeded();
//     setState(() {
//       _quantity--;
//     });
//     streamController?.add(_quantity);
//   }

//   void removeProduct() {
//     _isPressed = true;
//     _createStreamIfNeeded();
//     setState(() {
//       _quantity = 0;
//     });
//     streamController?.add(_quantity);
//     _isPressed = false;
//   }

//   void _createStreamIfNeeded() {
//     if (streamController == null) {
//       streamController = StreamController<int>();
//       _buildStreamListener();
//     }
//   }

//   void _closeStream() {
//     streamController?.close();
//     streamController = null;
//   }

//   void onTimeOut(Stream<int>? stream) {
//     if (stream == null) return;
//     if (!_isPressed)
//       _closeStream();
//     else
//       stream.timeout(const Duration(seconds: 5),
//           onTimeout: (_) => onTimeOut(stream));
//   }

//   void _buildStreamListener() {
//     streamController?.stream
//         .debounceTime(const Duration(milliseconds: 600))
//         .distinct()
//         .timeout(
//           const Duration(seconds: 5),
//           onTimeout: (_) => onTimeOut(streamController?.stream),
//         )
//         .listen((value) async {
//       final allowModel = await widget.onAddToCart(value);
//       if (allowModel?.allowed == false) {
//         showSnackBar(
//           context,
//           margin: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 80.0),
//           message: 'cart_not_available',
//         );
//         setState(() => _quantity = 0);
//       } else {
//         if (allowModel?.value != _quantity) {
//           if (allowModel?.value != 0)
//             showSnackBar(
//               context,
//               margin: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 80.0),
//               message: 'update_cart_quantity'
//                   .tr(args: [(allowModel?.value ?? 0).toString()]),
//             );
//           setState(() => _quantity = allowModel?.value ?? 0);
//         }
//       }
//     });
//   }
// }
