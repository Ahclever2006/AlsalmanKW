import 'dart:io';

import 'package:alsalman_app/core/utils/media_query_values.dart';
import 'package:alsalman_app/shared_widgets/text_fields/default_text_form_field.dart';

import '../../../../shared_widgets/stateful/check_box_signup.dart';
import '../../../../shared_widgets/stateless/inner_appbar.dart';

import '../../../../shared_widgets/stateless/subtitle_text.dart';
import '../../../../shared_widgets/text_fields/phone_number_text_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../../address/presentation/blocs/address_cubit/address_cubit.dart';
import '../../../cart_tab/presentation/cubit/cart_cubit.dart';
import '../../../layout/presentation/cubit/main_layout_cubit.dart';
import '../../data/models/user.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import '../../../../shared_widgets/text_fields/confirm_password_text_field.dart';
import '../../../../shared_widgets/text_fields/email_text_form_field.dart';
import '../../../../shared_widgets/text_fields/password_text_form_field.dart';

import '../blocs/auth_cubit/auth_cubit.dart';
import '/shared_widgets/stateless/custom_app_page.dart';
import '/shared_widgets/stateful/default_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_localization/easy_localization.dart';

import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/SignUp';
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final GlobalKey<FormState> _formKey;

  PhoneNumber? _phoneNumber;

  late final TextEditingController _fullNameTextController;
  late final TextEditingController _emailTextController;
  late final TextEditingController _passwordTextController;
  late final TextEditingController _passwordConfirmTextController;
  late final TextEditingController _phoneTextController;

  late final FocusNode _fullNameFocusNode;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _passwordConfirmFocusNode;
  late final FocusNode _phoneFocusNode;

  bool _isAutoValidating = false;
  bool _isChecked = false;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();

    _fullNameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _passwordConfirmTextController = TextEditingController();
    _phoneTextController = TextEditingController();

    _fullNameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _passwordConfirmFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _fullNameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _passwordConfirmTextController.dispose();
    _phoneTextController.dispose();

    _fullNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _passwordConfirmFocusNode.dispose();
    _phoneFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isError)
          showSnackBar(context, message: state.errorMessage);
        else if (state.isAuthSuccess) _goToHomePage(context);
      },
      child: Builder(
        builder: (context) => CustomAppPage(
          safeTop: true,
          child: Scaffold(
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                InnerPagesAppBar(
                  label: 'sign_up'.tr().toUpperCase(),
                ),
                _buildLogo(),
                const SizedBox(height: 32.0),
                _buildForm(),
                const SizedBox(height: 16.0),
                _buildSignUpButton(context),
                const SizedBox(height: 16.0),
                MyCheckboxListTile(
                  callback: (value) {
                    _isChecked = value;
                  },
                ),
                _buildORText(),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: _buildGoogleButton(context)),
                      if (Platform.isIOS) ...[
                        const SizedBox(width: 16.0),
                        Expanded(child: _buildAppleButton(context))
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                _buildAlreadyHaveAccountButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return SvgPicture.asset('lib/res/assets/app_logo.svg');
  }

  Widget _buildORText() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              color: AppColors.PRIMARY_COLOR,
              height: 2.0,
            ),
          ),
          const SubtitleText(
            text: 'or',
            textAlign: TextAlign.center,
            color: AppColors.PRIMARY_COLOR_DARK,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              color: AppColors.PRIMARY_COLOR,
              height: 2.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoogleButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return DefaultButton(
      label: 'continue_with_google'.tr(),
      isExpanded: true,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      contentAlignment: MainAxisAlignment.start,
      labelStyle: Theme.of(context)
          .textTheme
          .bodyText2!
          .copyWith(color: AppColors.PRIMARY_COLOR_DARK),
      backgroundColor: Colors.white,
      borderColor: AppColors.PRIMARY_COLOR,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      icon: SvgPicture.asset('lib/res/assets/google_icon.svg'),
      onPressed: () =>
          authCubit.loginWithGoogle(() => _showEmailDialog(context)),
    );
  }

  Widget _buildAppleButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return DefaultButton(
      label: 'continue_with_apple'.tr(),
      isExpanded: true,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      contentAlignment: MainAxisAlignment.start,
      labelStyle: Theme.of(context)
          .textTheme
          .bodyText2!
          .copyWith(color: AppColors.PRIMARY_COLOR_DARK),
      backgroundColor: Colors.white,
      borderColor: AppColors.PRIMARY_COLOR,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      icon: SvgPicture.asset('lib/res/assets/apple_icon.svg'),
      onPressed: () =>
          authCubit.loginWithApple(() => _showEmailDialog(context)),
    );
  }

  Future<String?> _showEmailDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (context) {
        final formKey = GlobalKey<FormState>();
        final emailController = TextEditingController();
        final emailFocusNode = FocusNode();

        return Dialog(
          insetPadding:
              const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // TitleText.small(
                //   text: 'email_required'.tr(),
                //   margin: const EdgeInsets.all(12.0),
                // ),
                EmailTextFormField(
                  currentController: emailController,
                  currentFocusNode: emailFocusNode,
                  //hint: 'email'.tr(),
                  margin: const EdgeInsets.all(8.0),
                ),
                DefaultButton(
                  label: 'confirm'.tr(),
                  isExpanded: true,
                  borderColor: AppColors.GREY_DARK_COLOR,
                  margin: const EdgeInsets.all(8.0),
                  onPressed: () => formKey.currentState!.validate()
                      ? Navigator.of(context).pop(emailController.text.trim())
                      : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildForm() {
    return Form(
        key: _formKey,
        autovalidateMode: _isAutoValidating
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        child: Column(
          children: [
            DefaultTextFormField(
                currentController: _fullNameTextController,
                isRequired: true,
                currentFocusNode: _fullNameFocusNode,
                nextFocusNode: _emailFocusNode,
                hint: 'full_name'.tr()),
            const SizedBox(height: 16.0),
            EmailTextFormField(
              currentFocusNode: _emailFocusNode,
              nextFocusNode: _phoneFocusNode,
              currentController: _emailTextController,
            ),
            const SizedBox(height: 16.0),
            PhoneTextFormField(
              currentController: _phoneTextController,
              initialValue: _phoneNumber,
              currentFocusNode: _phoneFocusNode,
              nextFocusNode: _passwordFocusNode,
              onInputChanged: (PhoneNumber value) {
                _phoneNumber = value;
              },
            ),
            const SizedBox(height: 16.0),
            PasswordTextFormField(
                currentFocusNode: _passwordFocusNode,
                nextFocusNode: _passwordConfirmFocusNode,
                currentController: _passwordTextController),
            const SizedBox(height: 16.0),
            ConfirmPasswordTextFormField(
              currentFocusNode: _passwordConfirmFocusNode,
              currentController: _passwordConfirmTextController,
              passwordController: _passwordTextController,
              hint: 'confirm_password'.tr(),
            )
          ],
        ));
  }

  Widget _buildSignUpButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return DefaultButton(
      label: 'sign_up'.tr(),
      onPressed: () async {
        if (!_isChecked) {
          showSnackBar(context, message: 'please_accept');
        } else {
          if (_isNotValid()) return;

          await authCubit.signUp(
            User(
              email: _emailTextController.text.trim(),
              firstName: _fullNameTextController.text.trim(),
              phone: _phoneNumber?.phoneNumber ?? '',
              password: _passwordTextController.text,
            ),
          );
        }
      },
    );
  }

  bool _isNotValid() {
    if (!_formKey.currentState!.validate()) {
      setState(() => _isAutoValidating = true);
      return true;
    }
    return false;
  }

  Widget _buildAlreadyHaveAccountButton(BuildContext context) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'already_have_account_message'.tr(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
            TextSpan(
              text: 'login'.tr(),
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 14.0, color: AppColors.PRIMARY_COLOR),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  NavigatorHelper.of(context)
                      .pushReplacementNamed(LoginPage.routeName);
                },
            ),
          ],
        ));
  }

  void _goToHomePage(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    final addressCubit = context.read<AddressCubit>();

    final mainLayoutCubit = context.read<MainLayoutCubit>();
    mainLayoutCubit.onBottomNavPressed(0);

    cartCubit
        .loadCart()
        .then((value) => NavigatorHelper.of(context)
            .popUntil(ModalRoute.withName("/MainLayOutPage")))
        .whenComplete(() => addressCubit.refreshAddresses())
        .whenComplete(() => showSnackBar(context, message: 'welcome_user'));
  }
}
