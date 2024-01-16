import 'dart:io';

import '../../../../shared_widgets/stateless/subtitle_text.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../../../shared_widgets/stateless/inner_appbar.dart';
import '../../../address/presentation/blocs/address_cubit/address_cubit.dart';
import '../../../cart_tab/presentation/cubit/cart_cubit.dart';
import '../../../layout/presentation/cubit/main_layout_cubit.dart';
import '../blocs/auth_cubit/auth_cubit.dart';
import 'sign_up_page.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import '../../../../shared_widgets/text_fields/email_text_form_field.dart';
import '../../../../shared_widgets/text_fields/password_text_form_field.dart';
import '/shared_widgets/stateless/custom_app_page.dart';
import '/shared_widgets/stateful/default_button.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'forget_password_page.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/LoginPage';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController _emailTextController;
  late final TextEditingController _passwordTextController;

  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  bool _isAutoValidating = false;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();

    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();

    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

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
                  label: 'login'.tr().toUpperCase(),
                ),
                _buildLogo(),
                const SizedBox(height: 40.0),
                _buildForm(),
                _buildForgetPasswordButton(context),
                _buildLoginButton(context),
                const SizedBox(height: 16.0),
                _buildORText(),
                // _buildFacebookButton(context),
                _buildGoogleButton(context),
                if (Platform.isIOS) _buildAppleButton(context),
                const SizedBox(height: 16.0),
                _buildAlreadyHaveAccountButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildORText() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            color: AppColors.PRIMARY_COLOR,
            height: 2.0,
            width: 40.0,
          ),
          Text(
            'or'.tr(),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            color: AppColors.PRIMARY_COLOR,
            height: 2.0,
            width: 40.0,
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return SvgPicture.asset('lib/res/assets/app_logo.svg', height: 80.0);
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      autovalidateMode: _isAutoValidating
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: Column(
        children: [
          EmailTextFormField(
            currentFocusNode: _emailFocusNode,
            currentController: _emailTextController,
            nextFocusNode: _passwordFocusNode,
          ),
          const SizedBox(height: 16.0),
          PasswordTextFormField(
            currentFocusNode: _passwordFocusNode,
            currentController: _passwordTextController,
          )
        ],
      ),
    );
  }

  Widget _buildForgetPasswordButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: InkWell(
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: SubtitleText(text: 'forget_password'),
          ),
          onTap: () => _goToForgetPasswordPage(context),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return DefaultButton(
      label: 'login'.tr(),
      onPressed: () async {
        if (_isNotValid()) return;
        await authCubit.login(
          _emailTextController.text.trim(),
          _passwordTextController.text,
        );
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
              text: 'no_account'.tr(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
            TextSpan(
              text: ' ',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            TextSpan(
              text: 'sign_up'.tr(),
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 14.0),
              recognizer: TapGestureRecognizer()
                ..onTap = () => _goToSignUpPage(context),
            ),
          ],
        ));
  }

  Widget _buildGoogleButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return DefaultButton(
      label: 'continue_with_google'.tr(),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      contentAlignment: MainAxisAlignment.start,
      labelStyle: Theme.of(context)
          .textTheme
          .bodyText2!
          .copyWith(color: AppColors.GREY_DARK_COLOR),
      backgroundColor: Colors.white,
      borderColor: AppColors.GREY_DARK_COLOR,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      icon: SvgPicture.asset('lib/res/assets/google.svg'),
      onPressed: () =>
          authCubit.loginWithGoogle(() => _showEmailDialog(context)),
    );
  }

  Widget _buildAppleButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return DefaultButton(
      label: 'continue_with_apple'.tr(),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      contentAlignment: MainAxisAlignment.start,
      labelStyle:
          Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white),
      backgroundColor: Colors.black,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      icon: const Icon(FontAwesomeIcons.apple),
      onPressed: () =>
          authCubit.loginWithApple(() => _showEmailDialog(context)),
    );
  }

  void _goToSignUpPage(BuildContext context) =>
      NavigatorHelper.of(context).pushReplacementNamed(SignUpPage.routeName);

  void _goToForgetPasswordPage(BuildContext context) {
    NavigatorHelper.of(context).pushNamed(ForgetPasswordPage.routeName);
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
                EmailTextFormField(
                  currentController: emailController,
                  currentFocusNode: emailFocusNode,
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
}
