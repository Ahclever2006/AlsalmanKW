import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:size_helper/size_helper.dart';

// import 'package:stock_client/core/utils/validator.dart';

import '../../res/style/app_colors.dart';

class PhoneTextFormField extends StatelessWidget {
  const PhoneTextFormField({
    Key? key,
    required this.currentFocusNode,
    required this.nextFocusNode,
    required this.currentController,
    this.margin,
    this.initialValue,
    required this.onInputChanged,
    this.isEnabled = true,
    this.hint,
  }) : super(key: key);

  final FocusNode currentFocusNode;
  final FocusNode? nextFocusNode;
  final TextEditingController currentController;
  final EdgeInsetsGeometry? margin;
  final PhoneNumber? initialValue;
  final ValueChanged<PhoneNumber> onInputChanged;
  final bool isEnabled;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final textStyle = context
        .sizeHelper(
            mobileLarge:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14.0),
            tabletSmall: Theme.of(context).textTheme.bodyText2!,
            tabletNormal: Theme.of(context).textTheme.bodyText2!,
            desktopSmall:
                Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 21.0))
        .copyWith(color: Colors.black);
    return Container(
      margin: margin,
      child: InternationalPhoneNumberInput(
        locale: context.locale.languageCode,
        countries: const ['KW'],
        isEnabled: isEnabled,
        focusNode: currentFocusNode,
        textFieldController: currentController,
        cursorColor: AppColors.PRIMARY_COLOR,
        textStyle: textStyle,
        selectorTextStyle: textStyle,
        inputDecoration: InputDecoration(
          fillColor: isEnabled ? Colors.white : AppColors.GREY_NORMAL_COLOR,
          filled: true,
          contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          hintText: hint ?? 'phone_number'.tr(),
          hintStyle: context
              .sizeHelper(
                mobileLarge: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 10.0),
                tabletSmall: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 12.0),
                tabletNormal: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 12.0),
                desktopSmall: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 20.0),
              )
              .copyWith(color: AppColors.GREY_DARK_COLOR),
          counterText: '',
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: AppColors.GREY_LIGHT_COLOR),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: AppColors.GREY_LIGHT_COLOR),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: AppColors.GREY_LIGHT_COLOR),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        autoValidateMode: AutovalidateMode.disabled,
        ignoreBlank: false,
        initialValue: initialValue ?? PhoneNumber(isoCode: 'KW'),
        selectorConfig: const SelectorConfig(
          trailingSpace: false,
          leadingPadding: 0.0,
          selectorType: PhoneInputSelectorType.DIALOG,
        ),
        searchBoxDecoration: InputDecoration(
          hintText: 'search_by_country_name_or_code'.tr(),
        ),
        spaceBetweenSelectorAndTextField: 8.0,
        errorMessage: 'invalid_phone_number'.tr(),
        hintText: '6655.......',
        onInputChanged: onInputChanged,
        onFieldSubmitted: (_) =>
            FocusScope.of(context).requestFocus(nextFocusNode),
        //TODO: this work with kuwait phone numbers
        maxLength: 8,
        formatInput: false,
      ),
    );
  }
}
