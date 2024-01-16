// import 'package:flutter/material.dart';

// class ProductSpecificationsSection extends StatelessWidget {
//   const ProductSpecificationsSection({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final cubit = AppdataCubit.get(context);
//     if (cubit.productDetails!.productDetailsModel!.productSpecificationModel!
//         .groups!.isEmpty) {
//       return Container();
//     }

//     return ListView.separated(
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: cubit.productDetails!.productDetailsModel!
//           .productSpecificationModel!.groups!.length,
//       separatorBuilder: (BuildContext context, int index) {
//         return const SizedBox(
//           height: 10,
//         );
//       },
//       itemBuilder: (BuildContext context, int index) {
//         if (cubit.productDetails!.productDetailsModel!
//             .productSpecificationModel!.groups![index].attributes!.isNotEmpty) {
//           return ListView.separated(
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: cubit.productDetails!.productDetailsModel!
//                 .productSpecificationModel!.groups![index].attributes!.length,
//             separatorBuilder: (BuildContext context, int index) {
//               return const SizedBox(
//                 height: 10,
//               );
//             },
//             itemBuilder: (BuildContext context, int innerIndex) {
//               String values = '';
//               for (var element in cubit
//                   .productDetails!
//                   .productDetailsModel!
//                   .productSpecificationModel!
//                   .groups![index]
//                   .attributes![innerIndex]
//                   .values!) {
//                 values = values + element.valueRaw! + ', ';
//               }
//               return ProductDetailRowItem(
//                 label: cubit
//                     .productDetails!
//                     .productDetailsModel!
//                     .productSpecificationModel!
//                     .groups![index]
//                     .attributes![innerIndex]
//                     .name,
//                 value: values,
//               );
//             },
//           );
//         } else {
//           return Container();
//         }
//       },
//     );
//   }
// }
