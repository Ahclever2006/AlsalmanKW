// import '../../../../../shared_widgets/stateless/title_text.dart';
// import 'package:flutter/material.dart';
// import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

// import '../../../../shared_widgets/stateless/custom_cached_network_image.dart';

// class MyFatoorahPaymentMethodsWidget extends StatefulWidget {
//   const MyFatoorahPaymentMethodsWidget(
//       {Key? key, required this.myFatoorah, required this.onPress})
//       : super(key: key);

//   final List<PaymentMethods>? myFatoorah;
//   final ValueChanged<int> onPress;

//   @override
//   State<MyFatoorahPaymentMethodsWidget> createState() =>
//       _MyFatoorahPaymentMethodsWidgetState();
// }

// class _MyFatoorahPaymentMethodsWidgetState
//     extends State<MyFatoorahPaymentMethodsWidget> {
//   int? selectedMethod = -1;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       padding: EdgeInsets.zero,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: widget.myFatoorah!.length,
//       itemBuilder: (BuildContext context, int index) {
//         var paymentMethod = widget.myFatoorah![index];
//         return InkWell(
//           onTap: () {
//             widget.onPress(paymentMethod.paymentMethodId!);

//             setState(() {
//               selectedMethod = paymentMethod.paymentMethodId!;
//             });
//           },
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Row(
//               children: [
//                 Radio<int>(
//                     value: paymentMethod.paymentMethodId!,
//                     groupValue: selectedMethod,
//                     onChanged: (value) {
//                       widget.onPress(value!);
//                       setState(() {
//                         selectedMethod = value;
//                       });
//                     }),
//                 Expanded(
//                     child:
//                         TitleText.medium(text: paymentMethod.paymentMethodEn!)),
//                 SizedBox(
//                     height: 30.0,
//                     width: 60.0,
//                     child: CustomCachedNetworkImage(
//                         imageUrl: paymentMethod.imageUrl!)),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
