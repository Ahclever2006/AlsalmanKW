// import '../../core/utils/media_query_values.dart';

// import '../../features/cart_tab/presentation/cubit/cart_cubit.dart';
// import '../../res/style/app_colors.dart';
// import 'show_snack_bar.dart';
// import '../stateful/message_card_design_chooser.dart';
// import '../text_fields/default_text_form_field.dart';

// import '../../features/auth/presentation/blocs/auth_cubit/auth_cubit.dart';
// import '../../features/product_details/data/model/product_details_model.dart';
// import '../stateful/default_button.dart';
// import 'package:easy_localization/easy_localization.dart' hide TextDirection;
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../core/utils/navigator_helper.dart';
// import '../stateless/title_text.dart';

// void showAddMessageCardBottomSheet(
//         BuildContext context, ProductDetailsModel? messageCard) =>
//     showModalBottomSheet(
//         context: context,
//         barrierColor: AppColors.BARRIER_COLOR,
//         isDismissible: true,
//         backgroundColor: Colors.transparent,
//         builder: (context) {
//           return AddMessageCardBottomSheetWidget(messageCard: messageCard);
//         });

// class AddMessageCardBottomSheetWidget extends StatefulWidget {
//   const AddMessageCardBottomSheetWidget({required this.messageCard, super.key});

//   final ProductDetailsModel? messageCard;

//   @override
//   State<AddMessageCardBottomSheetWidget> createState() =>
//       _AddMessageCardBottomSheetWidgetState();
// }

// class _AddMessageCardBottomSheetWidgetState
//     extends State<AddMessageCardBottomSheetWidget> {
//   late final GlobalKey<FormState> _formKey;

//   bool _isAutoValidating = false;

//   late final TextEditingController _fromTextController;
//   late final FocusNode _fromFocusNode;

//   late final TextEditingController _toTextController;
//   late final FocusNode _toFocusNode;

//   late final TextEditingController _messageTextController;
//   late final FocusNode _messageFocusNode;

//   Map<String, String>? chosenData;

//   @override
//   void initState() {
//     _formKey = GlobalKey<FormState>();
//     _fromTextController = TextEditingController();
//     _toTextController = TextEditingController();
//     _messageTextController = TextEditingController();

//     _toFocusNode = FocusNode();
//     _fromFocusNode = FocusNode();
//     _messageFocusNode = FocusNode();

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _fromTextController.dispose();
//     _toTextController.dispose();
//     _messageTextController.dispose();
//     _toFocusNode.dispose();
//     _fromFocusNode.dispose();
//     _messageFocusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var attributes =
//         widget.messageCard?.productDetailsModel?.productAttributes?.first;

//     final cartCubit = context.read<CartCubit>();
//     return Padding(
//       padding: EdgeInsets.only(bottom: context.bottom),
//       child: Container(
//         padding: const EdgeInsets.all(16.0),
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20.0),
//             topRight: Radius.circular(20.0),
//           ),
//           color: Colors.white,
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const TitleText(text: 'card_design'),
//               const SizedBox(height: 16.0),
//               MessageCardDesignChooser(
//                   productAttributeId: attributes!.id!,
//                   values: attributes.values,
//                   onPress: (data) {
//                     chosenData = data;
//                   }),
//               Form(
//                 key: _formKey,
//                 autovalidateMode: _isAutoValidating
//                     ? AutovalidateMode.onUserInteraction
//                     : AutovalidateMode.disabled,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const TitleText.large(text: 'card_message'),
//                     const SizedBox(height: 16.0),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const TitleText(text: 'from_required'),
//                               const SizedBox(height: 8.0),
//                               DefaultTextFormField(
//                                 isRequired: true,
//                                 currentFocusNode: _fromFocusNode,
//                                 nextFocusNode: _toFocusNode,
//                                 currentController: _fromTextController,
//                                 hint: 'enter_here'.tr(),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(width: 16.0),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const TitleText(text: 'to_required'),
//                               const SizedBox(height: 8.0),
//                               DefaultTextFormField(
//                                 isRequired: true,
//                                 currentFocusNode: _toFocusNode,
//                                 nextFocusNode: _messageFocusNode,
//                                 currentController: _toTextController,
//                                 hint: 'enter_here'.tr(),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16.0),
//                     const TitleText(text: 'message'),
//                     const SizedBox(height: 8.0),
//                     DefaultTextFormField(
//                       isRequired: true,
//                       currentFocusNode: _messageFocusNode,
//                       currentController: _messageTextController,
//                       maxLines: 5,
//                       hint: 'enter_here'.tr(),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 8.0),
//               BlocListener<AuthCubit, AuthState>(
//                 listener: (context, state) {
//                   if (state.isError) {
//                     NavigatorHelper.of(context).pop();
//                     showSnackBar(context, message: state.errorMessage);
//                   }
//                 },
//                 child: DefaultButton(
//                     label: 'add'.tr(),
//                     onPressed: () async {
//                       if (chosenData == null)
//                         return showSnackBar(context,
//                             message: 'please_choose_message_design',
//                             margin:
//                                 EdgeInsets.only(bottom: context.height * 0.45));
//                       if (_isNotValid()) return;
//                       await cartCubit
//                           .addToCart('348', 1, {
//                             ...?chosenData,
//                             "giftcard_348.RecipientName":
//                                 _toTextController.text,
//                             "giftcard_348.SenderName": _fromTextController.text,
//                             "giftcard_348.Message": _messageTextController.text
//                             // "giftcard_348.EnteredQuantity": 1
//                           })
//                           .whenComplete(() => cartCubit.loadCart())
//                           .whenComplete(() {
//                             NavigatorHelper.of(context).pop();
//                             showSnackBar(context,
//                                 message: 'message_card_added');
//                           });
//                     }),
//               ),
//               const SizedBox(height: 16.0),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   bool _isNotValid() {
//     if (_formKey.currentState != null && !_formKey.currentState!.validate()) {
//       setState(() => _isAutoValidating = true);
//       return true;
//     }
//     return false;
//   }
// }
