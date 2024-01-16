import 'dart:io';

import '../../../../shared_widgets/stateless/inner_appbar.dart';
import '../../../../shared_widgets/text_fields/default_text_form_field.dart';
import '../../../../shared_widgets/text_fields/first_name_text_form_field.dart';
import '../../../../shared_widgets/text_fields/last_name_text_form_field.dart';
import '../../../../shared_widgets/text_fields/phone_number_text_field.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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

  int? day;
  int? month;
  int? year;

  late final TextEditingController _firstNameTextController;
  late final TextEditingController _lastNameTextController;
  late final TextEditingController _emailTextController;
  late final TextEditingController _birthDateTextController;
  late final TextEditingController _passwordTextController;
  late final TextEditingController _passwordConfirmTextController;
  late final TextEditingController _phoneTextController;

  late final FocusNode _firstNameFocusNode;
  late final FocusNode _lastNameFocusNode;
  late final FocusNode _emailFocusNode;
  late final FocusNode _birthDateFocusNode;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _passwordConfirmFocusNode;
  late final FocusNode _phoneFocusNode;

  bool _isAutoValidating = false;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();

    _firstNameTextController = TextEditingController();
    _lastNameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _birthDateTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _passwordConfirmTextController = TextEditingController();
    _phoneTextController = TextEditingController();

    _firstNameFocusNode = FocusNode();
    _lastNameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _birthDateFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _passwordConfirmFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _firstNameTextController.dispose();
    _lastNameTextController.dispose();
    _emailTextController.dispose();
    _birthDateTextController.dispose();
    _passwordTextController.dispose();
    _passwordConfirmTextController.dispose();
    _phoneTextController.dispose();

    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _birthDateFocusNode.dispose();
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
                const SizedBox(height: 8.0),
                _buildForm(),
                const SizedBox(height: 16.0),
                _buildSignUpButton(context),
                _buildORText(),
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
            FirstNameTextFormField(
                currentController: _firstNameTextController,
                currentFocusNode: _firstNameFocusNode,
                nextFocusNode: _lastNameFocusNode),
            const SizedBox(height: 16.0),
            LastNameTextFormField(
              currentController: _lastNameTextController,
              currentFocusNode: _lastNameFocusNode,
              nextFocusNode: _emailFocusNode,
            ),
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
              nextFocusNode: _birthDateFocusNode,
              onInputChanged: (PhoneNumber value) {
                _phoneNumber = value;
              },
            ),
            const SizedBox(height: 16.0),
            _buildBirthDateWidget(context),
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

  Widget _buildBirthDateWidget(BuildContext context) {
    final dateTimeStringCallBack = _createDateFormate(context);

    return InkWell(
      onTap: () {
        DatePicker.showDatePicker(context,
            theme: DatePickerTheme(
                doneStyle: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: AppColors.PRIMARY_COLOR_DARK),
                cancelStyle: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: Colors.red),
                headerColor: AppColors.PRIMARY_COLOR,
                backgroundColor: AppColors.PRIMARY_COLOR_LIGHT),
            showTitleActions: true,
            minTime: DateTime(1900, 1, 1),
            maxTime: DateTime.now(),
            onChanged: (date) {}, onConfirm: (date) {
          day = date.day;
          month = date.month;
          year = date.year;
          _birthDateTextController.text = dateTimeStringCallBack(date);
        }, currentTime: DateTime.now());
      },
      child: DefaultTextFormField(
          enabled: false,
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12.0),
            child: SvgPicture.asset('lib/res/assets/calendar_icon.svg'),
          ),
          currentFocusNode: _birthDateFocusNode,
          currentController: _birthDateTextController,
          hint: 'choose_birth_date'.tr()),
    );
  }

  String Function(DateTime e) _createDateFormate(BuildContext context) {
    final dateFormat = DateFormat('dd/MMMM/yyyy', context.locale.languageCode);
    return (e) => dateFormat.format(e);
  }

  Widget _buildSignUpButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return DefaultButton(
      label: 'sign_up'.tr(),
      onPressed: () async {
        if (_isNotValid()) return;

        await authCubit.signUp(
          User(
            email: _emailTextController.text.trim(),
            firstName: _firstNameTextController.text.trim(),
            lastName: _lastNameTextController.text.trim(),
            phone: _phoneNumber?.phoneNumber ?? '',
            password: _passwordTextController.text,
            dateOfBirthDay: day.toString(),
            dateOfBirthMonth: month.toString(),
            dateOfBirthYear: year.toString(),
          ),
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
              text: 'already_have_account_message'.tr(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
            TextSpan(
              text: 'login'.tr(),
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 14.0),
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
