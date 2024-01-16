// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';

// import '../../res/style/app_colors.dart';
// import '../stateless/title_text.dart';

// class AddGiftCardWidget extends StatefulWidget {
//   const AddGiftCardWidget(
//       {super.key,
//       required this.isFirstCard,
//       required this.price,
//       required this.onPress});

//   final num price;
//   final bool isFirstCard;
//   final VoidCallback onPress;

//   @override
//   State<AddGiftCardWidget> createState() => _AddGiftCardWidgetState();
// }

// class _AddGiftCardWidgetState extends State<AddGiftCardWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 32.0),
//       padding: const EdgeInsets.all(16.0),
//       decoration: const BoxDecoration(
//         color: AppColors.PRIMARY_COLOR_LIGHT,
//         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TitleText(
//                   text: widget.isFirstCard ? 'message_card' : 'extra_card'),
//               const SizedBox(height: 16.0),
//               TitleText(text: '${widget.price} ${'currency'.tr()}'),
//             ],
//           ),
//           InkWell(
//             child: Container(
//               width: 24.0,
//               height: 24.0,
//               decoration: BoxDecoration(
//                 border:
//                     Border.all(color: AppColors.PRIMARY_COLOR_DARK, width: 2.0),
//                 borderRadius: const BorderRadius.all(Radius.circular(4.0)),
//               ),
//             ),
//             onTap: widget.onPress,
//           )
//         ],
//       ),
//     );
//   }
// }
