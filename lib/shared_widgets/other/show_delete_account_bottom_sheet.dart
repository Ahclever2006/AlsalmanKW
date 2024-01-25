import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/utils/navigator_helper.dart';
import '../../core/utils/type_defs.dart';
import '../../res/style/app_colors.dart';
import '../stateful/default_button.dart';
import '../stateless/subtitle_text.dart';
import '../stateless/title_text.dart';

void showDeleteAccountBottomSheet(BuildContext context,
        {required String label,
        required String subtitle,
        required String checkMessage,
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
            checkMessage: checkMessage,
            onPress: onPress,
          );
        });

class SimpleBottomSheetWidget extends StatefulWidget {
  const SimpleBottomSheetWidget(
      {required this.label,
      required this.subTitle,
      required this.checkMessage,
      required this.onPress,
      super.key});

  final String label;
  final String subTitle;
  final String checkMessage;
  final FutureCallback onPress;

  @override
  State<SimpleBottomSheetWidget> createState() =>
      _SimpleBottomSheetWidgetState();
}

class _SimpleBottomSheetWidgetState extends State<SimpleBottomSheetWidget> {
  bool isChecked = false;
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
          TitleText(text: widget.label),
          const SizedBox(height: 16.0),
          SubtitleText(text: widget.subTitle, maxLines: 2),
          _buildCheckBox(widget.checkMessage),
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
                  .copyWith(color: AppColors.PRIMARY_COLOR_DARK, height: 1.0),
              backgroundColor: Colors.transparent,
              onPressed: () => NavigatorHelper.of(context).pop()),
          const SizedBox(width: 16.0),
          DefaultButton(
              label: 'yes'.tr(),
              enabled: isChecked,
              onPressed: () => widget.onPress()),
        ],
      ),
    );
  }

  Widget _buildCheckBox(String checkMessage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              isChecked = !isChecked;
              setState(() {});
            },
            child: Container(
              width: 24.0,
              height: 24.0,
              decoration: BoxDecoration(
                border:
                    Border.all(color: AppColors.PRIMARY_COLOR_DARK, width: 2.0),
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              ),
              child: isChecked
                  ? const Icon(
                      Icons.check,
                      size: 20.0,
                      color: AppColors.PRIMARY_COLOR_DARK,
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
              child: SubtitleText(
            text: checkMessage,
            color: AppColors.PRIMARY_COLOR_DARK,
          )),
        ],
      ),
    );
  }
}
