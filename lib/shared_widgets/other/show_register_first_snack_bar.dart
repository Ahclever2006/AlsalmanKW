import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/utils/navigator_helper.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../res/style/app_colors.dart';
import 'show_snack_bar.dart';

void showRegisterFirstSnackbar(BuildContext context,
        {EdgeInsetsGeometry? margin}) =>
    showSnackBar(
      context,
      margin: margin,
      message: 'register_first',
      action: _buildRegisterButton(context),
    );

Widget _buildRegisterButton(BuildContext context) {
  return InkWell(
    child: Text(
      'login'.tr(),
      style: Theme.of(context).textTheme.bodyText2!.copyWith(
          fontWeight: FontWeight.bold, color: AppColors.PRIMARY_COLOR),
    ),
    onTap: () => _goToSignUpPage(context),
  );
}

Future<void> _goToSignUpPage(BuildContext context) =>
    NavigatorHelper.of(context).pushNamed(LoginPage.routeName);
