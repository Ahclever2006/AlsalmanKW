// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:size_helper/size_helper.dart';

// import '../../core/data/models/wallet_model.dart';
// import '../../res/style/app_colors.dart';

// class TransactionItemCard extends StatelessWidget {
//   const TransactionItemCard({
//     Key? key,
//     required this.transaction,
//     this.isWallet = false,
//   }) : super(key: key);

//   final Transaction transaction;
//   final bool isWallet;

//   @override
//   Widget build(BuildContext context) {
//     final dateTimeStringCallBack = _createDateFormate(context);

//     final fontSize = context.sizeHelper(
//       tabletLarge: 14.0,
//       desktopSmall: 24.0,
//     );

//     var exchanged = transaction.exchanged! ? '-' : '+';
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                   isWallet
//                       ? '$exchanged ${transaction.amount.toString()} ${'currency'.tr()}'
//                       : '$exchanged ${'points'.plural(transaction.amount ?? 0)}',
//                   style: Theme.of(context).textTheme.displayLarge!.copyWith(
//                         color: transaction.exchanged!
//                             ? AppColors.PRIMARY_COLOR
//                             : AppColors.WHATS_APP_COLOR,
//                         fontSize: fontSize,
//                       )),
//               Text(
//                 dateTimeStringCallBack(transaction.date!),
//                 style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                       fontSize: fontSize,
//                     ),
//               )
//             ],
//           ),
//           const SizedBox(height: 16.0),
//           Text(
//             transaction.description!,
//             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                   fontSize: fontSize,
//                 ),
//           ),
//         ],
//       ),
//     );
//   }

//   String Function(DateTime e) _createDateFormate(BuildContext context) {
//     final dateFormat =
//         DateFormat('dd MMM yyyy     hh:mm a', context.locale.languageCode);
//     return (e) => dateFormat.format(e);
//   }
// }
