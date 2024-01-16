// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:size_helper/size_helper.dart';
// import '../../features/auth/presentation/blocs/auth_cubit/auth_cubit.dart';
// import '../../features/auth/presentation/pages/login_page.dart';
// import '../../features/cart/presentation/cubit/cart_cubit.dart';
// import '../../features/cart/presentation/pages/cart_page.dart';
// import '../../res/style/app_colors.dart';

// import '../../core/utils/navigator_helper.dart';
// import '../../features/home/presentation/pages/home_page.dart';

// class PurchasesButton extends StatelessWidget {
//   const PurchasesButton({
//     this.showHomeButton = false,
//     Key? key,
//   }) : super(key: key);

//   final bool showHomeButton;

//   @override
//   Widget build(BuildContext context) {
//     final authCubit = context.watch<AuthCubit>();
//     final cartCubit = context.watch<CartCubit>();
//     final isLoggedIn = authCubit.state.completeRegistrationStep;

//     final fontSize = context.sizeHelper(
//       tabletLarge: 16.0,
//       desktopSmall: 24.0,
//     );
//     final style = Theme.of(context).textTheme.bodyLarge!.copyWith(
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//           fontSize: fontSize,
//         );
//     final height = context.sizeHelper(
//       tabletLarge: 60.0,
//       desktopSmall: 80.0,
//     );
//     return Material(
//       type: MaterialType.transparency,
//       child: Row(
//         children: [
//           if (showHomeButton) ...[
//             InkWell(
//               onTap: () => NavigatorHelper.of(context).popUntil(
//                   (route) => route.settings.name == HomePage.routeName),
//               child: Container(
//                 height: height,
//                 padding: const EdgeInsets.all(16.0),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                 ),
//                 child: SvgPicture.asset(
//                   'lib/res/assets/home_icon.svg',
//                   height: context.sizeHelper(
//                     tabletLarge: 26.0,
//                     desktopSmall: 36.0,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8.0),
//           ],
//           Expanded(
//             child: Container(
//               height: height,
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               decoration: const BoxDecoration(
//                 color: AppColors.PRIMARY_COLOR,
//                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16.0, vertical: 8.0),
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                     ),
//                     child: Text(
//                       isLoggedIn
//                           ? (cartCubit.state.cart?.cartPoints.toString() ?? '0')
//                           : '0',
//                       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                             fontWeight: FontWeight.bold,
//                             fontSize: fontSize,
//                           ),
//                     ),
//                   ),
//                   const SizedBox(width: 8.0),
//                   Expanded(
//                     child: Text(
//                       isLoggedIn
//                           ? '${cartCubit.state.cart?.totalPrice ?? 0} ${'currency'.tr()}'
//                           : '0.0 ${'currency'.tr()}',
//                       style: style,
//                     ),
//                   ),
//                   InkWell(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 8.0, vertical: 16.0),
//                       child: Text(
//                         isLoggedIn ? 'details'.tr() : 'login'.tr(),
//                         style: style,
//                       ),
//                     ),
//                     onTap: () {
//                       _goToCartOrLogin(isLoggedIn, context);
//                     },
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _goToCartOrLogin(bool isLoggedIn, BuildContext context) {
//     !isLoggedIn
//         ? NavigatorHelper.of(context).pushNamed(LoginPage.routeName)
//         : NavigatorHelper.of(context).pushNamed(CartPage.routeName);
//   }
// }
