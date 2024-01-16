// import '../../core/utils/media_query_values.dart';

// import '../../features/address/presentation/blocs/address_cubit/address_cubit.dart';

// import '../../core/enums/otp_for.dart';
// import '../stateful/counter_down_timer.dart';
// import 'show_snack_bar.dart';
// import '../stateless/subtitle_text.dart';
// import 'package:flutter/services.dart';

// import '../../features/auth/presentation/blocs/auth_cubit/auth_cubit.dart';
// import '../../features/layout/presentation/cubit/main_layout_cubit.dart';
// import '../stateful/default_button.dart';
// import 'package:easy_localization/easy_localization.dart' hide TextDirection;
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';

// import '../../core/enums/topic_type.dart';
// import '../../core/utils/navigator_helper.dart';
// import '../../features/account_tab/presentation/pages/topic_page.dart';
// import '../../features/cart_tab/presentation/cubit/cart_cubit.dart';
// import '../../res/style/app_colors.dart';
// import '../stateless/title_text.dart';
// import '../text_fields/phone_number_text_field.dart';

// void showLoginBottomSheet(BuildContext context) => showDialog(
//     context: context,
//     barrierDismissible: true,
//     // isDismissible: true,
//     barrierColor: AppColors.BARRIER_COLOR,
//     // backgroundColor: Colors.transparent,
//     builder: (context) {
//       return const LoginBottomSheetWidget();
//     });

// class LoginBottomSheetWidget extends StatefulWidget {
//   const LoginBottomSheetWidget({super.key});

//   @override
//   State<LoginBottomSheetWidget> createState() => _LoginBottomSheetWidgetState();
// }

// class _LoginBottomSheetWidgetState extends State<LoginBottomSheetWidget> {
//   late final GlobalKey<FormState> _formKey;

//   bool _isAutoValidating = false;

//   late final TextEditingController _phoneTextController;
//   late final FocusNode _phoneFocusNode;

//   // late final TextEditingController _pinCodeController;

//   PhoneNumber? _phoneNumber;

//   @override
//   void initState() {
//     _formKey = GlobalKey<FormState>();
//     _phoneTextController = TextEditingController();
//     // _pinCodeController = TextEditingController();
//     _phoneFocusNode = FocusNode();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _phoneTextController.dispose();
//     // _pinCodeController.dispose();
//     _phoneFocusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authCubit = context.read<AuthCubit>();
//     return Material(
//       type: MaterialType.transparency,
//       child: Container(
//         margin: EdgeInsets.only(
//             left: 16.0,
//             right: 16.0,
//             top: context.height * 0.25,
//             bottom:
//                 context.bottom == 0 ? context.height * 0.25 : context.bottom),
//         padding: const EdgeInsets.all(16.0),
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.all(
//             Radius.circular(20.0),
//           ),
//           color: Colors.white,
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const SizedBox(height: 16.0),
//               TitleText(text: 'welcome'.tr(args: ['...'])),
//               const SizedBox(height: 16.0),
//               const TitleText(text: 'phone_required'),
//               const SizedBox(height: 16.0),
//               Form(
//                 key: _formKey,
//                 autovalidateMode: _isAutoValidating
//                     ? AutovalidateMode.onUserInteraction
//                     : AutovalidateMode.disabled,
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: PhoneTextFormField(
//                         currentFocusNode: _phoneFocusNode,
//                         nextFocusNode: null,
//                         currentController: _phoneTextController,
//                         onInputChanged: (value) => _phoneNumber = value,
//                         initialValue: _phoneNumber,
//                       ),
//                     ),
//                     const SizedBox(width: 12.0),
//                     BlocListener<AuthCubit, AuthState>(
//                       listener: (context, state) {
//                         if (state.isOtpValidated) _goToHomePage(context);
//                         if (state.isError) {
//                           NavigatorHelper.of(context).pop();
//                           showSnackBar(context, message: state.errorMessage);
//                         }
//                       },
//                       child: DefaultButton(
//                           margin: EdgeInsets.zero,
//                           padding: const EdgeInsets.all(4.0),
//                           icon: RotatedBox(
//                             quarterTurns:
//                                 context.locale == const Locale('en') ? 0 : 2,
//                             child: const Icon(
//                               Icons.play_circle_fill_sharp,
//                             ),
//                           ),
//                           onPressed: () async {
//                             if (_isNotValid()) return;
//                             await authCubit.login(_phoneNumber!.phoneNumber!);
//                           }),
//                     )
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 32.0),
//               BlocBuilder<AuthCubit, AuthState>(
//                 builder: (context, state) {
//                   if (state.isOtpSent || state.isOtpInvalid)
//                     return _buildPinTextField(context);
//                   else
//                     return const SizedBox();
//                 },
//               ),
//               _buildLinkText(context),
//               const SizedBox(height: 16.0),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _goToHomePage(BuildContext context) {
//     final cartCubit = context.read<CartCubit>();
//     final addressCubit = context.read<AddressCubit>();

//     final mainLayoutCubit = context.read<MainLayoutCubit>();
//     mainLayoutCubit.onBottomNavPressed(0);

//     cartCubit
//         .loadCart()
//         .then((value) => NavigatorHelper.of(context)
//             .popUntil(ModalRoute.withName("/MainLayOutPage")))
//         .whenComplete(() => addressCubit.refreshAddresses())
//         .whenComplete(() => showSnackBar(context, message: 'welcome_user'));
//   }

//   bool _isNotValid() {
//     if (_formKey.currentState != null && !_formKey.currentState!.validate()) {
//       setState(() => _isAutoValidating = true);
//       return true;
//     }
//     return false;
//   }

//   Widget _buildPinTextField(BuildContext context) {
//     const color = AppColors.AUTH_CONTAINER_COLOR;
//     final authCubit = context.read<AuthCubit>();

//     return Column(
//       children: [
//         const SizedBox(height: 12.0),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const TitleText(text: 'enter_confirmation_code'),
//             BlocBuilder<AuthCubit, AuthState>(
//               builder: (context, state) {
//                 if (!state.isOtpInvalid) return const SizedBox();
//                 return const TitleText(text: 'wrong_code', color: Colors.red);
//               },
//             ),
//           ],
//         ),
//         const SizedBox(height: 16.0),
//         BlocBuilder<AuthCubit, AuthState>(
//           builder: (context, state) {
//             if (state.isOtpSent || state.isOtpInvalid)
//               return Directionality(
//                 textDirection: TextDirection.ltr,
//                 child: PinCodeTextField(
//                   //controller: _pinCodeController,
//                   appContext: context,
//                   length: 6,
//                   obscureText: false,
//                   animationType: AnimationType.fade,
//                   textStyle: Theme.of(context)
//                       .textTheme
//                       .bodyLarge!
//                       .copyWith(color: Colors.black),
//                   pinTheme: PinTheme(
//                     shape: PinCodeFieldShape.box,
//                     fieldHeight: 40,
//                     fieldWidth: 45,
//                     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
//                     disabledColor: color,
//                     inactiveColor: color,
//                     errorBorderColor: Colors.red,
//                     activeFillColor: color,
//                     activeColor: color,
//                     inactiveFillColor: color,
//                     selectedFillColor: color,
//                     selectedColor: AppColors.PRIMARY_COLOR,
//                   ),
//                   boxShadows: AppColors.SHADOW_LIGHT,
//                   animationDuration: const Duration(milliseconds: 300),
//                   enableActiveFill: true,
//                   cursorColor: AppColors.PRIMARY_COLOR,
//                   onChanged: (code) {
//                     if (code.length == 6)
//                       authCubit.validateOTP(
//                         code,
//                         _phoneNumber!.phoneNumber!,
//                         OTPFor.LoginOrRegister,
//                       );
//                   },
//                   beforeTextPaste: (_) => true,
//                   keyboardType: TextInputType.number,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
//                   ],
//                 ),
//               );
//             else
//               return const SizedBox();
//           },
//         ),
//         Row(
//           children: [
//             _buildCounterDownTimer(context),
//             _buildResendButton(context),
//           ],
//         )
//       ],
//     );
//   }

//   Widget _buildCounterDownTimer(BuildContext context) {
//     final authCubit = context.read<AuthCubit>();

//     return BlocSelector<AuthCubit, AuthState, bool>(
//       selector: (state) => state.showCounter,
//       builder: (context, showCounter) {
//         return showCounter
//             ? BlocSelector<AuthCubit, AuthState, DateTime?>(
//                 selector: (state) => state.till,
//                 builder: (context, till) => till == null
//                     ? const SizedBox()
//                     : CounterDownTimer(
//                         alignment: Alignment.center,
//                         till: till,
//                         onTimeUp: authCubit.enableResendButton,
//                       ),
//               )
//             : const SizedBox();
//       },
//     );
//   }

//   Widget _buildResendButton(BuildContext context) {
//     final authCubit = context.read<AuthCubit>();

//     return BlocSelector<AuthCubit, AuthState, bool>(
//       selector: (state) => state.resendIsEnabled,
//       builder: (context, resendIsEnabled) {
//         return resendIsEnabled
//             ? Row(
//                 children: [
//                   const SubtitleText(text: '(00:00)  '),
//                   const SubtitleText(text: 'did_not_receive_code'),
//                   DefaultButton(
//                     label: 'resend'.tr(),
//                     padding: const EdgeInsets.all(4.0),
//                     labelStyle: Theme.of(context)
//                         .textTheme
//                         .displayLarge!
//                         .copyWith(
//                             color: AppColors.PRIMARY_COLOR_DARK, height: 1.0),
//                     backgroundColor: Colors.transparent,
//                     onPressed: () => authCubit.login(
//                       _phoneNumber!.phoneNumber!,
//                     ),
//                   ),
//                 ],
//               )
//             : const SizedBox();
//       },
//     );
//   }

//   Widget _buildLinkText(BuildContext context) {
//     return BlocBuilder<AuthCubit, AuthState>(
//       builder: (context, state) {
//         if (state.isOtpSent || state.isOtpInvalid)
//           return const SizedBox();
//         else
//           return RichText(
//               textAlign: TextAlign.start,
//               text: TextSpan(
//                 children: [
//                   TextSpan(
//                     text: 'by_sign_up'.tr(),
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyText1!
//                         .copyWith(fontSize: 16.0),
//                   ),
//                   TextSpan(
//                     text: 'terms_of_use'.tr(),
//                     style: const TextStyle(
//                         color: AppColors.PRIMARY_COLOR,
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.bold,
//                         decoration: TextDecoration.underline,
//                         decorationColor: AppColors.PRIMARY_COLOR),
//                     recognizer: TapGestureRecognizer()
//                       ..onTap = () => NavigatorHelper.of(context)
//                               .push(MaterialPageRoute(builder: (_) {
//                             return TopicPage(id: TopicType.Terms.value);
//                           })),
//                   ),
//                   TextSpan(
//                     text: 'and'.tr(),
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyText1!
//                         .copyWith(fontSize: 16.0),
//                   ),
//                   TextSpan(
//                     text: 'privacy_policy'.tr(),
//                     style: const TextStyle(
//                         color: AppColors.PRIMARY_COLOR,
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.bold,
//                         decoration: TextDecoration.underline,
//                         decorationColor: AppColors.PRIMARY_COLOR),
//                     recognizer: TapGestureRecognizer()
//                       ..onTap = () => NavigatorHelper.of(context)
//                               .push(MaterialPageRoute(builder: (_) {
//                             return TopicPage(id: TopicType.Privacy.value);
//                           })),
//                   ),
//                 ],
//               ));
//       },
//     );
//   }
// }
