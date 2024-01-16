import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../core/utils/media_query_values.dart';
import '../../core/utils/navigator_helper.dart';

import '../../res/style/app_colors.dart';
import '../stateful/default_button.dart';
import '../stateless/subtitle_text.dart';
import '../stateless/title_text.dart';

void showWalletStatusDialog(BuildContext context,
        {required String label, required String subtitle}) =>
    showDialog(
        context: context,
        barrierColor: AppColors.BARRIER_COLOR,
        builder: (context) {
          return SimpleBottomSheetWidget(
            label: label,
            subTitle: subtitle,
          );
        });

class SimpleBottomSheetWidget extends StatelessWidget {
  const SimpleBottomSheetWidget(
      {required this.label, required this.subTitle, super.key});

  final String label;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: context.width,
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            boxShadow: AppColors.SHADOW,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TitleText(
                text: label,
                textAlign: TextAlign.center,
                margin: const EdgeInsets.all(16.0),
              ),
              SubtitleText.medium(
                text: subTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24.0),
              _buildActionButtons(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return DefaultButton(
        label: 'got_it'.tr(),
        onPressed: () {
          NavigatorHelper.of(context).pop();
        });
  }
}
