// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../core/data/models/product_model.dart';
// import '../../features/auth/presentation/blocs/auth_cubit/auth_cubit.dart';
// import '../../features/cart/presentation/cubit/cart_cubit.dart';
// import '../stateful/quantity_button.dart';

// import '../../res/style/app_colors.dart';
// import 'custom_cached_network_image.dart';

// class OrderItemCard extends StatelessWidget {
//   const OrderItemCard({
//     Key? key,
//     required this.height,
//     required this.product,
//     required this.fontSize,
//     required this.padding,
//     this.showQuantity = true,
//     this.showQuantityButton = false,
//   }) : super(key: key);

//   final double height;
//   final Product product;
//   final bool showQuantity;
//   final bool showQuantityButton;
//   final double fontSize;
//   final double padding;

//   @override
//   Widget build(BuildContext context) {
//     final cartCubit = context.read<CartCubit>();
//     final authCubit = context.read<AuthCubit>();
//     var image = DecoratedBox(
//       decoration: BoxDecoration(
//         border: Border.all(color: AppColors.GREY_BORDER_COLOR),
//         borderRadius: const BorderRadius.all(Radius.circular(10.0)),
//       ),
//       child: CustomCachedNetworkImage(
//         imageUrl: product.picture!,
//         fit: BoxFit.fitHeight,
//         urlHeight: height.toInt(),
//         urlWidth: height.toInt(),
//         scaleMode: ScaleMode.Both,
//         imageMode: ImageMode.Pad,
//         borderRadius: const BorderRadius.all(Radius.circular(10.0)),
//       ),
//     );

//     return Container(
//       height: height,
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       margin: const EdgeInsets.symmetric(vertical: 8.0),
//       decoration: BoxDecoration(
//           color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.name!,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyLarge!
//                         .copyWith(fontSize: fontSize),
//                   ),
//                   SizedBox(height: padding),
//                   if (product.units?.isNotEmpty == true)
//                     Text(
//                       product.units!.first.name ?? '',
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyLarge!
//                           .copyWith(fontSize: fontSize),
//                     ),
//                   SizedBox(height: padding),
//                   Text(
//                     '${product.price} ${'currency'.tr()}',
//                     style: Theme.of(context)
//                         .textTheme
//                         .displayLarge!
//                         .copyWith(fontSize: fontSize),
//                   ),
//                   SizedBox(height: padding),
//                   if (showQuantity)
//                     Text(
//                       '${'quantity'.tr()}: ${product.quantity}',
//                       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                           color: AppColors.PRIMARY_COLOR, fontSize: fontSize),
//                     )
//                   else
//                     Text(
//                       '${'profitability'.tr()} ${product.profitabilityPrice} ${'currency'.tr()}',
//                       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                           color: AppColors.WHATS_APP_COLOR, fontSize: fontSize),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: (showQuantityButton &&
//                     authCubit.state.completeRegistrationStep &&
//                     product.units?.isNotEmpty == true)
//                 ? Stack(
//                     fit: StackFit.expand,
//                     children: [
//                       image,
//                       QuantityButton(
//                         quantity: product.quantity,
//                         onAddToCart: (quantity) async {
//                           return cartCubit.addToCart(
//                             productId: product.stockProductId!,
//                             quantity: quantity,
//                             unitType: product.units!.first.id!,
//                           );
//                         },
//                         onRemoveFromCart: (quantity) async {
//                           return cartCubit.addToCart(
//                             productId: product.stockProductId!,
//                             quantity: quantity,
//                             unitType: product.units!.first.id!,
//                           );
//                         },
//                       )
//                     ],
//                   )
//                 : image,
//           ),
//         ],
//       ),
//     );
//   }
// }
