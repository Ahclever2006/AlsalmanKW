import 'package:alsalman_app/shared_widgets/stateless/subtitle_text.dart';
import 'package:alsalman_app/shared_widgets/stateless/title_text.dart';

import '/core/utils/navigator_helper.dart';
import '/res/style/app_colors.dart';
import '/shared_widgets/stateless/custom_app_page.dart';
import '/shared_widgets/stateful/default_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RegisterSuccessPage extends StatefulWidget {
  static const routeName = '/RegisterSuccessPage';
  const RegisterSuccessPage({Key? key}) : super(key: key);

  @override
  State<RegisterSuccessPage> createState() => _RegisterSuccessPageState();
}

class _RegisterSuccessPageState extends State<RegisterSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => CustomAppPage(
        safeTop: true,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const Spacer(
                  flex: 1,
                ),
                Image.asset('lib/res/assets/register_success.png'),
                const SizedBox(height: 32.0),
                _buildRegisterSuccessText(context),
                const Spacer(flex: 2),
                _buildBeginButton(context),
                const SizedBox(height: 32.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterSuccessText(BuildContext context) {
    return Column(
      children: [
        const TitleText(text: 'hooray', color: AppColors.PRIMARY_COLOR),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitleText.large(text: '${'welcome_to'.tr()} '),
            const TitleText.large(
                text: 'alsalman', color: AppColors.PRIMARY_COLOR),
          ],
        ),
        const SizedBox(height: 8.0),
        const SubtitleText(text: 'account_created'),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SubtitleText(text: 'lif_is'),
            SubtitleText(
                text: ' ${'colorful'.tr()} ', color: AppColors.PRIMARY_COLOR),
            const SubtitleText(text: 'with'),
            SubtitleText(
                text: ' ${'fish'.tr()}', color: AppColors.PRIMARY_COLOR),
          ],
        ),
      ],
    );
  }

  Widget _buildBeginButton(BuildContext context) {
    return DefaultButton(
      label: 'let_begin'.tr(),
      isExpanded: true,
      onPressed: () => NavigatorHelper.of(context).pop(),
    );
  }
}
