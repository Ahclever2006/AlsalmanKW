import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../../../shared_widgets/stateful/default_button.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/other/show_delete_account_bottom_sheet.dart';
import '../../../../shared_widgets/other/show_simple_bottom_sheet.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import '../../../../shared_widgets/stateful/gender_choice_widget.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import '../../../../shared_widgets/stateless/inner_appbar.dart';
import '../../../../shared_widgets/stateless/title_text.dart';
import '../../../../shared_widgets/text_fields/default_text_form_field.dart';
import '../../../../shared_widgets/text_fields/email_text_form_field.dart';
import '../../../../shared_widgets/text_fields/first_name_text_form_field.dart';
import '../../../../shared_widgets/text_fields/phone_number_text_field.dart';
import '../../../address/presentation/blocs/address_cubit/address_cubit.dart';
import '../../../auth/data/models/user_info.dart';
import '../../../auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import '../../../cart_tab/presentation/cubit/cart_cubit.dart';
import '../../../layout/presentation/cubit/main_layout_cubit.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/ProfilePage';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final GlobalKey<FormState> _formKey;

  bool _isAutoValidating = false;

  late final TextEditingController _firstNameTextController;
  late final FocusNode _firstNameFocusNode;

  late final TextEditingController _emailTextController;
  late final FocusNode _emailFocusNode;

  late final TextEditingController _phoneTextController;
  late final FocusNode _phoneFocusNode;
  PhoneNumber? _phoneNumber;

  late final TextEditingController _birthDateTextController;
  late final FocusNode _birthDateFocusNode;

  int? day;
  int? month;
  int? year;

  String? gender;

  @override
  void initState() {
    final authCubit = context.read<AuthCubit>();

    final userInfo = authCubit.state.userInfo;

    _formKey = GlobalKey<FormState>();

    _phoneTextController = TextEditingController();

    if (userInfo?.data?.phone != null)
      PhoneNumber.getRegionInfoFromPhoneNumber(
              userInfo?.data?.phone ?? '', 'KW')
          .then((value) {
        _phoneNumber = value;
      });

    _firstNameTextController =
        TextEditingController(text: userInfo?.data?.firstName);

    _emailTextController = TextEditingController(text: userInfo?.data?.email);

    _birthDateTextController = TextEditingController(
        text: userInfo?.data?.dateOfBirthDay != null
            ? '${userInfo?.data?.dateOfBirthDay ?? ''} - ${userInfo?.data?.dateOfBirthMonth ?? ''} - ${userInfo?.data?.dateOfBirthYear ?? ''}'
            : null);

    gender = userInfo?.data?.gender;
    _birthDateFocusNode = FocusNode();
    _firstNameFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _emailFocusNode = FocusNode();

    var dateOfBirth = userInfo?.data;
    day = dateOfBirth?.dateOfBirthDay;
    month = dateOfBirth?.dateOfBirthMonth;
    year = dateOfBirth?.dateOfBirthYear;

    Future.delayed(const Duration(milliseconds: 10), () {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _firstNameTextController.dispose();
    _birthDateTextController.dispose();
    _birthDateFocusNode.dispose();
    _firstNameFocusNode.dispose();
    _emailTextController.dispose();
    _emailFocusNode.dispose();
    _phoneTextController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppPage(
      safeTop: true,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const InnerPagesAppBar(
                label: 'account_info',
              ),
              ..._buildBody(context),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBody(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    final addressCubit = context.read<AddressCubit>();
    final authCubit = context.read<AuthCubit>();
    return [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: _isAutoValidating
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FirstNameTextFormField(
                currentFocusNode: _firstNameFocusNode,
                nextFocusNode: _emailFocusNode,
                currentController: _firstNameTextController,
                maxLength: 30,
              ),
              const SizedBox(height: 16.0),
              EmailTextFormField(
                currentFocusNode: _emailFocusNode,
                currentController: _emailTextController,
              ),
              const SizedBox(height: 16.0),
              PhoneTextFormField(
                currentFocusNode: _phoneFocusNode,
                nextFocusNode: null,
                currentController: _phoneTextController,
                onInputChanged: (value) => _phoneNumber = value,
                initialValue: _phoneNumber,
              ),
              const SizedBox(height: 16.0),
              _buildBirthDateWidget(context)
            ],
          ),
        ),
      ),
      ..._buildGenderSection(context),
      BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.isError) {
            NavigatorHelper.of(context).pop();
            showSnackBar(context, message: state.errorMessage);
          }
        },
        child: DefaultButton(
            margin: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
            label: 'save'.tr(),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            onPressed: () async {
              if (_isNotValid()) return;
              final isSuccess = await authCubit.editAccountData(UserInfoData(
                  firstName: _firstNameTextController.text.trim(),
                  email: _emailTextController.text.trim(),
                  gender: gender,
                  phone: _phoneNumber?.phoneNumber,
                  dateOfBirthDay: day,
                  dateOfBirthMonth: month,
                  dateOfBirthYear: year));

              if (isSuccess)
                _goToHomePageAfterUpdate(context);
              else {
                NavigatorHelper.of(context).pop();
                showSnackBar(context, message: 'nothing_changed');
              }
            }),
      ),
      DefaultButton(
          label: 'logout'.tr(),
          backgroundColor: Colors.transparent,
          borderColor: AppColors.GREY_NORMAL_COLOR,
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          labelStyle: Theme.of(context).textTheme.displayLarge!,
          margin: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
          onPressed: () => showSimpleBottomSheet(context,
                  label: 'logout',
                  subtitle: 'log_out_subtitle', onPress: () async {
                await authCubit
                    .logOut()
                    .then((value) => authCubit.loginAsGuest())
                    .whenComplete(() => cartCubit.clearCart())
                    .whenComplete(() => addressCubit.refreshAddresses())
                    .whenComplete(() => _goToHomePage(context));
              })),
      DefaultButton(
          label: 'delete_account'.tr(),
          icon: SvgPicture.asset('lib/res/assets/delete_account_icon.svg'),
          backgroundColor: Colors.transparent,
          labelStyle: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(color: AppColors.ERROR_COLOR),
          margin: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
          onPressed: () => showDeleteAccountBottomSheet(context,
              label: 'delete_account_title',
              subtitle: 'delete_account_subtitle',
              checkMessage: 'delete_account_check_message',
              onPress: () => authCubit
                  .deleteAccount()
                  .then((value) => authCubit.loginAsGuest())
                  .whenComplete(() => cartCubit.clearCart())
                  .whenComplete(() => addressCubit.refreshAddresses())
                  .whenComplete(() => _goToHomePage(context)))),
    ];
  }

  void _goToHomePage(BuildContext context) {
    final mainLayoutCubit = context.read<MainLayoutCubit>();

    mainLayoutCubit.onBottomNavPressed(2);

    NavigatorHelper.of(context)
        .popUntil(ModalRoute.withName("/MainLayOutPage"));

    showSnackBar(context, message: 'guest_mode');
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
                headerColor: AppColors.SECONDARY_COLOR,
                backgroundColor: AppColors.SECONDARY_COLOR),
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

  void _goToHomePageAfterUpdate(BuildContext context) {
    final mainLayoutCubit = context.read<MainLayoutCubit>();
    mainLayoutCubit.onBottomNavPressed(2);

    NavigatorHelper.of(context)
        .popUntil(ModalRoute.withName("/MainLayOutPage"));

    showSnackBar(context, message: 'account_updated');
  }

  bool _isNotValid() {
    if (_formKey.currentState != null && !_formKey.currentState!.validate()) {
      setState(() => _isAutoValidating = true);
      return true;
    }
    return false;
  }

  List<Widget> _buildGenderSection(BuildContext context) {
    return [
      GenderChoiceWidget(
          initialGender: gender != null ? int.tryParse(gender!) : null,
          onChange: (value) {
            gender = value.toString();
          })
    ];
  }
}
