import 'package:flutter_svg/svg.dart';
import '../../../../shared_widgets/stateless/subtitle_text.dart';

import '/core/utils/navigator_helper.dart';
import '/res/style/app_colors.dart';
import '/shared_widgets/stateless/custom_app_page.dart';
import '/shared_widgets/stateful/default_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ForgetPasswordSuccessPage extends StatelessWidget {
  static const routeName = '/ForgetPasswordSuccessPage';
  const ForgetPasswordSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppPage(
      safeTop: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 60),
                child: SvgPicture.asset('lib/res/assets/congrats.svg'),
              ),
              const SizedBox(height: 16.0),
              _buildCongratsText(context),
              _buildCongratsSubText(context),
              const Spacer(),
              _buildContinueButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCongratsText(BuildContext context) {
    return Text(
      'congrats'.tr(),
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(color: AppColors.PRIMARY_COLOR),
    );
  }

  Widget _buildCongratsSubText(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: SubtitleText(
        text: 'email_sent_reset_password',
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return DefaultButton(
      label: 'continue'.tr(),
      isExpanded: true,
      onPressed: () => _goBackToLoginPage(context),
    );
  }

  void _goBackToLoginPage(BuildContext context) =>
      NavigatorHelper.of(context).pop(true);
}
