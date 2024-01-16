import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/utils/type_defs.dart';
import '../../res/style/app_colors.dart';
import '../stateful/default_button.dart';
import '../stateless/subtitle_text.dart';
import '../stateless/title_text.dart';

void showCartRefreshDialog(BuildContext context,
        {required String label,
        required String subtitle,
        required FutureCallback onPress}) =>
    showDialog(
        context: context,
        barrierColor: AppColors.BARRIER_COLOR,
        builder: (context) {
          return SimpleBottomSheetWidget(
            label: label,
            subTitle: subtitle,
            onPress: onPress,
          );
        });

class SimpleBottomSheetWidget extends StatelessWidget {
  const SimpleBottomSheetWidget(
      {required this.label,
      required this.subTitle,
      required this.onPress,
      super.key});

  final String label;
  final String subTitle;
  final FutureCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: AppColors.PRIMARY_COLOR,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(child: TitleText(text: label)),
                  _buildActionButtons(context)
                ],
              ),
              const SizedBox(height: 16.0),
              SubtitleText.medium(text: subTitle),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return DefaultButton(
        label: ''.tr(),
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        icon: const Icon(Icons.refresh),
        onPressed: () => onPress());
  }
}
