import 'package:flutter/cupertino.dart';

import '../../res/style/app_colors.dart';

import 'package:flutter/material.dart';

import '../stateless/title_text.dart';

void showAdsAndNotificationBottomSheet(
  BuildContext context, {
  required ValueChanged<bool> onPressAds,
  required ValueChanged<bool> onPressNotification,
  required bool isNotificationEnabled,
  required bool isAdsEnabled,
}) =>
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        barrierColor: AppColors.BARRIER_COLOR,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return SimpleBottomSheetWidget(
            onPressAds: onPressAds,
            onPressNotification: onPressNotification,
            isNotificationEnabled: isNotificationEnabled,
            isAdsEnabled: isAdsEnabled,
          );
        });

class SimpleBottomSheetWidget extends StatelessWidget {
  const SimpleBottomSheetWidget({
    required this.onPressAds,
    required this.onPressNotification,
    required this.isNotificationEnabled,
    required this.isAdsEnabled,
    super.key,
  });

  final ValueChanged<bool> onPressAds;
  final ValueChanged<bool> onPressNotification;
  final bool isNotificationEnabled;
  final bool isAdsEnabled;

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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildItem(
              label: 'ads_tracking',
              isEnabled: isAdsEnabled,
              onPress: onPressAds,
            ),
            const SizedBox(height: 16.0),
            _buildItem(
              label: 'notifications',
              isEnabled: isNotificationEnabled,
              onPress: onPressNotification,
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
      {required String label,
      required bool isEnabled,
      required ValueChanged<bool> onPress}) {
    return _RowWithSwitchButton(
      isEnabled: isEnabled,
      label: label,
      onPress: onPress,
    );
  }
}

class _RowWithSwitchButton extends StatefulWidget {
  const _RowWithSwitchButton({
    Key? key,
    required this.isEnabled,
    required this.label,
    required this.onPress,
  }) : super(key: key);

  final String label;
  final bool isEnabled;
  final ValueChanged<bool> onPress;

  @override
  State<_RowWithSwitchButton> createState() => _RowWithSwitchButtonState();
}

class _RowWithSwitchButtonState extends State<_RowWithSwitchButton> {
  bool _isEnabled = false;

  @override
  void initState() {
    _isEnabled = widget.isEnabled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: TitleText(text: widget.label)),
        Theme(
            data: ThemeData(
                switchTheme: SwitchThemeData(
              thumbColor: MaterialStateProperty.all(AppColors.PRIMARY_COLOR),
            )),
            child: CupertinoSwitch(
                activeColor: AppColors.PRIMARY_COLOR,
                thumbColor: AppColors.PRIMARY_COLOR_DARK,
                value: _isEnabled,
                onChanged: (value) {
                  setState(() {
                    _isEnabled = value;
                  });
                  widget.onPress(value);
                })),
      ],
    );
  }
}
