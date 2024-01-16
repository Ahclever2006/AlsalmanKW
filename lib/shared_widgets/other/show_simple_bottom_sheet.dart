import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/utils/navigator_helper.dart';
import '../../core/utils/type_defs.dart';
import '../../res/style/app_colors.dart';
import '../stateful/default_button.dart';
import '../stateless/subtitle_text.dart';
import '../stateless/title_text.dart';

void showSimpleBottomSheet(BuildContext context,
        {required String label,
        required String subtitle,
        required FutureCallback onPress}) =>
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        barrierColor: AppColors.BARRIER_COLOR,
        backgroundColor: Colors.transparent,
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
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TitleText(text: label),
          const SizedBox(height: 16.0),
          SubtitleText.medium(text: subTitle),
          const SizedBox(height: 16.0),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DefaultButton(
              label: 'no_action'.tr(),
              labelStyle: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: Colors.black, height: 1.0),
              backgroundColor: Colors.transparent,
              onPressed: () => NavigatorHelper.of(context).pop()),
          const SizedBox(width: 16.0),
          DefaultButton(label: 'yes'.tr(), onPressed: () => onPress()),
        ],
      ),
    );
  }
}
