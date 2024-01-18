// import 'dart:developer';

// import '../../../auth/presentation/blocs/auth_cubit/auth_cubit.dart';

// import '../../../../core/data/models/payment_summary.dart';
// import '../../../../core/utils/navigator_helper.dart';

// import '../../../../features/payment/presentation/pages/payment_success_screen.dart';
// import '../../../../res/style/app_colors.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
// // import 'package:myfatoorah_flutter/utils/MFCountry.dart';
// // import 'package:myfatoorah_flutter/utils/MFEnvironment.dart';

// import '../../../../shared_widgets/other/show_snack_bar.dart';
// import 'package:flutter/material.dart';

// import '../../../../di/injector.dart';
// import '../../../../shared_widgets/stateful/default_button.dart';
// import '../../../../shared_widgets/stateless/back_button.dart';
// import '../../../../shared_widgets/stateless/custom_app_page.dart';
// import '../../../../shared_widgets/stateless/custom_loading.dart';
// import '../../../../shared_widgets/stateless/main_title_text.dart';
// import '../blocs/payment_cubit/payment_cubit.dart';
// import '../widgets/my_fatoorah_payment_methods_widget.dart';

// class PaymentScreen extends StatefulWidget {
//   static const routeName = '/PaymentScreen';

//   const PaymentScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => Injector().paymentCubit
//         ..getPaymentSummary()
//         ..getUserData()
//         ..getAndSetPaymentMethods(),
//       child: CustomAppPage(
//         safeTop: true,
//         child: Scaffold(
//           body: Column(
//             children: [
//               const CustomBackButton(),
//               _buildMainTitle(),
//               Expanded(
//                 child: BlocConsumer<PaymentCubit, PaymentState>(
//                   listener: (context, state) {
//                     if (state is PaymentStateError)
//                       showSnackBar(context, message: state.message);

//                     if (state is PaymentStateSuccess)
//                       NavigatorHelper.of(context).pushAndRemoveUntil(
//                           MaterialPageRoute(builder: (_) {
//                         return const PaymentSuccessScreen();
//                       }), (route) => false);
//                   },
//                   builder: (context, state) {
//                     //Here we collect payment methods available in myFatoorah plugin
//                     final cubit = context.read<PaymentCubit>();
//                     if (cubit.myfatoorahPaymentMethods == null &&
//                         state.paymentMethodsModel != null &&
//                         state.paymentSummaryModel != null)
//                       _initializeMyfatoorah(context);

//                     if (state is PaymentStateLoading ||
//                         cubit.myfatoorahPaymentMethods == null)
//                       return const CustomLoading(
//                         loadingStyle: LoadingStyle.ShimmerList,
//                       );
//                     if (state.paymentMethodsModel != null &&
//                         state.paymentSummaryModel != null) {
//                       return _buildBody(
//                         context,
//                         paymentMethods: state.paymentMethodsModel,
//                         payment: state.paymentSummaryModel!,
//                         myFatoorah: cubit.myfatoorahPaymentMethods,
//                       );
//                     }

//                     return const SizedBox();
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMainTitle() {
//     return MainTitleText(title: 'check_out'.tr().toUpperCase());
//   }

//   Widget _buildCheckOutSection(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       decoration: const BoxDecoration(
//         color: AppColors.PRIMARY_COLOR,
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(
//                 left: 16.0, right: 16.0, top: 24.0, bottom: 16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(
//                   width: 16.0,
//                 ),
//                 Expanded(
//                   child: DefaultButton(
//                       label: 'check_out'.tr(),
//                       labelStyle: Theme.of(context)
//                           .textTheme
//                           .bodyText1!
//                           .copyWith(
//                               color: AppColors.PRIMARY_COLOR, height: 1.0),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 24.0, vertical: 12.0),
//                       borderRadius:
//                           const BorderRadius.all(Radius.circular(12.0)),
//                       backgroundColor: Colors.white,
//                       onPressed: () async {
//                         final cubit = context.read<PaymentCubit>();

//                         if (cubit.selectedPaymentMethodId == null)
//                           showSnackBar(context,
//                               message: 'please_choose_payment');
//                         else {
//                           await cubit.confirmOrder();

//                           String price = cubit.state.paymentSummaryModel!
//                               .totalsModel!.orderTotal
//                               .toString()
//                               .replaceAll(RegExp(r'[^0-9.]'), '');

//                           double totalPrice = _getTotalPrice(price);
//                           log('Total price is $totalPrice');

//                           log('Total price is $totalPrice');

//                           late MFExecutePaymentRequest? req;

//                           if (cubit.confirmModel!.id != null)
//                             req = MFExecutePaymentRequest.fromJson({
//                               "PaymentMethodId": cubit.selectedPaymentMethodId,
//                               "CustomerReference":
//                                   cubit.confirmModel!.id.toString(),
//                               "InvoiceValue": totalPrice
//                             });

//                           if (req != null)
//                             MFSDK.executePayment(
//                                 context,
//                                 req,
//                                 context.locale == const Locale('ar')
//                                     ? MFAPILanguage.AR
//                                     : MFAPILanguage.EN,
//                                 onPaymentResponse: (String invoiceId,
//                                     MFResult<MFPaymentStatusResponse> result) {
//                               if (result.isSuccess()) {
//                                 log(invoiceId);
//                                 log(result.response!.invoiceId.toString());
//                                 cubit.confirmPayment(
//                                     invoiceId:
//                                         result.response!.invoiceId.toString());
//                               } else {
//                                 showSnackBar(context,
//                                     message: result.error!.message.toString());
//                                 // Future.delayed(
//                                 //     const Duration(seconds: 2), () {
//                                 //   NavigatorHelper.of(context)
//                                 //       .pushAndRemoveUntil(
//                                 //           MaterialPageRoute(
//                                 //               builder: (_) {
//                                 //     return const HomePage(
//                                 //         isLoggedIn: true);
//                                 //   }), (route) => false);
//                                 // }),
//                               }
//                             });
//                         }
//                       }),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   double _getTotalPrice(String totalPriceWithManyDote) {
//     final String numberBeforeDot =
//         totalPriceWithManyDote.toString().split('.').first;

//     final String numberAfterDot =
//         totalPriceWithManyDote.toString().split('.')[1];

//     final String total = '$numberBeforeDot.$numberAfterDot';
//     final double totalPrice = double.parse(total);
//     return totalPrice;
//   }

//   Widget _buildPaymentSummarySection(
//       BuildContext context, PaymentSummaryModel? payment) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Text(
//           'payment_summary'.tr(),
//           style: Theme.of(context).textTheme.displayLarge,
//         ),
//         const SizedBox(
//           height: 12.0,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'sub_total'.tr(),
//               style: Theme.of(context).textTheme.bodyText2,
//             ),
//             Text(
//               payment!.totalsModel!.subTotal!,
//               style: Theme.of(context).textTheme.bodyText2,
//             ),
//           ],
//         ),
//         const SizedBox(
//           height: 12.0,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'taxes'.tr(),
//               style: Theme.of(context).textTheme.bodyText2,
//             ),
//             Text(
//               payment.totalsModel!.tax!,
//               style: Theme.of(context).textTheme.bodyText2,
//             ),
//           ],
//         ),
//         const SizedBox(
//           height: 12.0,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'total'.tr(),
//               style: Theme.of(context).textTheme.bodyText2,
//             ),
//             Text(
//               payment.totalsModel!.orderTotal!,
//               style: Theme.of(context).textTheme.bodyText2,
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildBody(
//     BuildContext context, {
//     PaymentMethodsModel? paymentMethods,
//     PaymentSummaryModel? payment,
//     List<PaymentMethods>? myFatoorah,
//   }) {
//     final cubit = context.read<PaymentCubit>();
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         _buildUserInfoSection(),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//           child: Text(
//             'pay_with'.tr(),
//             style: Theme.of(context).textTheme.displayLarge,
//           ),
//         ),
//         Expanded(
//           child: SingleChildScrollView(
//             child: MyFatoorahPaymentMethodsWidget(
//                 myFatoorah: myFatoorah,
//                 onPress: (value) {
//                   cubit.changeSelectedPaymentMethodId(value);
//                 }),
//           ),
//         ),
//         _buildBottomSection(context, payment),
//       ],
//     );
//   }

//   Container _buildUserInfoSection() {
//     final authCubit = context.read<AuthCubit>();
//     final userInfo = authCubit.state.userInfo!.data;
//     return Container(
//       margin: const EdgeInsets.all(8.0),
//       padding: const EdgeInsets.all(8.0),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(userInfo!.firstName! + ' ' + userInfo.lastName!),
//             const Divider(
//               color: AppColors.GREY_NORMAL_COLOR,
//             ),
//             if (userInfo.phone != null) Text(userInfo.phone),
//             if (userInfo.phone != null)
//               const Divider(
//                 color: AppColors.GREY_NORMAL_COLOR,
//               ),
//             Text(userInfo.email!),
//             const Divider(
//               color: AppColors.GREY_NORMAL_COLOR,
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Column _buildBottomSection(
//       BuildContext context, PaymentSummaryModel? payment) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: _buildPaymentSummarySection(context, payment),
//         ),
//         _buildCheckOutSection(context),
//       ],
//     );
//   }

//   void _initializeMyfatoorah(BuildContext context) {
//     MFSDK.init(
//         //"rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL",
//         "RFnMMLRF31j0gIJUnJzzxd_RSU_iwiBKtRYydZU-zyaDXv_QoNNW5oOSUc6g1yQG_YCeJlD-D89tqXjgJ3t4RzjrDIehiayGBVQ8XsNFZB_i5g80o8qpXbRU_mMxGxm1LnIKfvvkrN8hZbIEB7vWUt1W2_AcaBQKaF3fhvGc2Zn4dxHaSrlNVosmcuHQLAC0h62WPhJf2uI_BFnkVuF6Fa48hMbiUBmzZvXbp_uk79OGJvcfvA71hPZ-Iik0q8pp9UKyUloGcFqB93H2Ki9mfNz-ZVqUOYHoEtP6gcbKd9m3vVkvJsHQq8XLHLSSxSK7A6mc6MXy-Ewg-gn_ubBgZwGVy48I9Mat010F2QVcecPth-KzQ0z1yuTlCH5EHGIzq9mTGfh59dh9XHgA5Ww3v3fbS4mmcZs78lXsIlrPvCcsYl7BPnWyMA85MGRtyFIk-trGBauksNxpghStYA9OpNOEzqrHvwFEHxNS0Xy0opFdcS0hskCAr9y_0H8OCLgY0JhVv1MLJ0iladDYFiX0gScUYPHLKRmdhM1luOSF_v3ptm5ra793ihd3H1oVdHMPFHAb6cYwCM_zu6p3v4lZNf78VQ6S3kNZDgYqkikM6vsUBTQADJdSlEVSdrVZstXj4klorva_WmBodUWcErktoB-kOmt9CQbOWVVtB2Oe_kmC1gEiQVqN9dCGRrroJ1OyCEYPJw",
//         MFCountry.KUWAIT,
//         MFEnvironment.LIVE);

//     MFSDK.setUpAppBar(
//         title: "MyFatoorah Payment",
//         titleColor: Colors.white,
//         backgroundColor: Colors.black,
//         isShowAppBar: true);

//     var request = MFInitiatePaymentRequest(0.100, MFCurrencyISO.KUWAIT_KWD);

//     MFSDK.initiatePayment(request, MFAPILanguage.EN,
//         (MFResult<MFInitiatePaymentResponse> result) {
//       return {
//         if (result.isSuccess())
//           {
//             context
//                 .read<PaymentCubit>()
//                 .changeFatoorahPaymentMethods(result.response!.paymentMethods)
//           }
//         else
//           {log(result.error!.message.toString())}
//       };
//     });
//   }
// }
