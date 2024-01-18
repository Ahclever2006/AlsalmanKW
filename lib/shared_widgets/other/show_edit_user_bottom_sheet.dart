import '../../core/utils/media_query_values.dart';

import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import '../../features/auth/data/models/user_info.dart';
import '../text_fields/last_name_text_form_field.dart';
import 'show_snack_bar.dart';
import '../stateful/gender_choice_widget.dart';
import '../text_fields/default_text_form_field.dart';
import '../text_fields/first_name_text_form_field.dart';

import '../../features/auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import '../../features/layout/presentation/cubit/main_layout_cubit.dart';
import '../stateful/default_button.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/utils/navigator_helper.dart';
import '../../res/style/app_colors.dart';
import '../stateless/title_text.dart';

void showEditUserBottomSheet(BuildContext context, UserInfoModel? userInfo) =>
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        barrierColor: AppColors.BARRIER_COLOR,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return EditUserInfoBottomSheetWidget(userInfo: userInfo);
        });

class EditUserInfoBottomSheetWidget extends StatefulWidget {
  const EditUserInfoBottomSheetWidget({required this.userInfo, super.key});

  final UserInfoModel? userInfo;

  @override
  State<EditUserInfoBottomSheetWidget> createState() =>
      _EditUserInfoBottomSheetWidgetState();
}

class _EditUserInfoBottomSheetWidgetState
    extends State<EditUserInfoBottomSheetWidget> {
  late final GlobalKey<FormState> _formKey;

  bool _isAutoValidating = false;

  late final TextEditingController _firstNameTextController;
  late final FocusNode _firstNameFocusNode;
  late final TextEditingController _lastNameTextController;
  late final FocusNode _lastNameFocusNode;

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
    _firstNameTextController =
        TextEditingController(text: userInfo?.data?.firstName);
    _lastNameTextController =
        TextEditingController(text: userInfo?.data?.lastName);
    _birthDateTextController = TextEditingController(
        text: userInfo?.data?.dateOfBirthDay != null
            ? '${userInfo?.data?.dateOfBirthDay ?? ''} - ${userInfo?.data?.dateOfBirthMonth ?? ''} - ${userInfo?.data?.dateOfBirthYear ?? ''}'
            : null);

    gender = userInfo?.data?.gender;
    _birthDateFocusNode = FocusNode();
    _firstNameFocusNode = FocusNode();
    _lastNameFocusNode = FocusNode();

    var dateOfBirth = userInfo?.data;
    day = dateOfBirth?.dateOfBirthDay;
    month = dateOfBirth?.dateOfBirthMonth;
    year = dateOfBirth?.dateOfBirthYear;

    super.initState();
  }

  @override
  void dispose() {
    _firstNameTextController.dispose();
    _lastNameTextController.dispose();
    _birthDateTextController.dispose();
    _birthDateFocusNode.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return Padding(
      padding: EdgeInsets.only(bottom: context.bottom),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const TitleText(
                text: 'account_info',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              Form(
                key: _formKey,
                autovalidateMode: _isAutoValidating
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleText(
                      text: "${'first_name'.tr()} *",
                      color: _firstNameTextController.text.isEmpty
                          ? Colors.red
                          : null,
                    ),
                    const SizedBox(height: 8.0),
                    FirstNameTextFormField(
                      currentFocusNode: _firstNameFocusNode,
                      nextFocusNode: _lastNameFocusNode,
                      currentController: _firstNameTextController,
                      maxLength: 30,
                    ),
                    const SizedBox(height: 8.0),
                    TitleText(
                      text: "${'first_name'.tr()} *",
                      color: _firstNameTextController.text.isEmpty
                          ? Colors.red
                          : null,
                    ),
                    const SizedBox(height: 8.0),
                    LastNameTextFormField(
                      currentFocusNode: _lastNameFocusNode,
                      nextFocusNode: _birthDateFocusNode,
                      currentController: _lastNameTextController,
                      maxLength: 30,
                    ),
                    const SizedBox(height: 8.0),
                    const TitleText(text: 'birth_date_optional'),
                    const SizedBox(height: 8.0),
                    _buildBirthDateWidget(context),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              ..._buildGenderSection(context),
              const SizedBox(height: 8.0),
              BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state.isError) {
                    NavigatorHelper.of(context).pop();
                    showSnackBar(context, message: state.errorMessage);
                  }
                },
                child: DefaultButton(
                    margin: (_isAutoValidating && _isNotValid())
                        ? const EdgeInsets.only(bottom: 20.0)
                        : EdgeInsets.zero,
                    label: 'save'.tr(),
                    onPressed: () async {
                      if (_isNotValid()) return;
                      final isSuccess = await authCubit.editAccountData(
                          UserInfoData(
                              firstName: _firstNameTextController.text.trim(),
                              lastName: _lastNameTextController.text.trim(),
                              gender: gender,
                              dateOfBirthDay: day,
                              phone: widget.userInfo?.data?.phone ?? '',
                              dateOfBirthMonth: month,
                              dateOfBirthYear: year));

                      if (isSuccess)
                        _goToHomePage(context);
                      else {
                        NavigatorHelper.of(context).pop();
                        showSnackBar(context, message: 'nothing_changed');
                      }
                    }),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
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

  void _goToHomePage(BuildContext context) {
    final mainLayoutCubit = context.read<MainLayoutCubit>();
    mainLayoutCubit.onBottomNavPressed(0);

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
      const SizedBox(height: 8.0),
      const TitleText(text: 'gender_optional'),
      const SizedBox(height: 8.0),
      GenderChoiceWidget(
          initialGender: gender != null ? int.tryParse(gender!) : null,
          onChange: (value) {
            gender = value.toString();
          })
    ];
  }
}
