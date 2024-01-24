import 'package:alsalman_app/core/utils/navigator_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/utils/type_defs.dart';
import '../../res/style/app_colors.dart';
import '../stateful/default_button.dart';
import '../stateless/subtitle_text.dart';
import '../stateless/title_text.dart';

void showRemoveFavDialog(BuildContext context,
        {required String label,
        required String subtitle,
        required FutureCallback onPress}) =>
    showDialog(
        context: context,
        barrierColor: AppColors.BARRIER_COLOR,
        builder: (context) {
          return SimpleDialogWidget(
            label: label,
            subTitle: subtitle,
            onPress: onPress,
          );
        });

class SimpleDialogWidget extends StatelessWidget {
  const SimpleDialogWidget(
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
          width: double.infinity,
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16.0),
              TitleText(
                text: label,
                color: AppColors.PRIMARY_COLOR_DARK,
              ),
              const SizedBox(height: 16.0),
              SvgPicture.asset(
                'lib/res/assets/remove_fav_icon.svg',
              ),
              const SizedBox(height: 16.0),
              SubtitleText.medium(text: subTitle),
              const SizedBox(height: 24.0),
              _buildActionButtons(context),
              const SizedBox(height: 16.0),
              _buildCancelButtons(context)
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return DefaultButton(
      label: 'yes'.tr(),
      isExpanded: true,
      onPressed: () => onPress(),
    );
  }

  Widget _buildCancelButtons(BuildContext context) {
    return DefaultButton(
      label: 'cancel'.tr(),
      isExpanded: true,
      backgroundColor: Colors.transparent,
      labelStyle: Theme.of(context)
          .textTheme
          .displayLarge!
          .copyWith(color: AppColors.PRIMARY_COLOR_DARK),
      onPressed: () {
        NavigatorHelper.of(context).pop();
      },
    );
  }
}
