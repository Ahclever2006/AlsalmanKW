// import 'package:flutter/material.dart';
// import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

// import '../../res/style/app_colors.dart';
// import 'cart_icon.dart';

// class SliverAppBarWidget extends StatelessWidget {
//   final Function? onStretchTrigger;
//   final Widget title;

//   const SliverAppBarWidget(
//       {Key? key, this.onStretchTrigger, required this.title})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       // iconTheme: const IconThemeData(color: Colors.black),
//       backgroundColor: Colors.transparent,
//       stretch: true,
//       floating: true,
//       elevation: 0.0,
//       onStretchTrigger: () async {
//         if (onStretchTrigger != null) onStretchTrigger!();
//       },
//       flexibleSpace: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [_buildDrawerIcon(context), title, const CartIcon()],
//           )),
//     );
//   }

//   Widget _buildDrawerIcon(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         ZoomDrawer.of(context)!.open();
//       },
//       child: const Icon(
//         Icons.menu,
//         color: AppColors.PRIMARY_COLOR,
//       ),
//     );
//   }
// }
