import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../res/style/app_colors.dart';

class EnableNotificationButton extends StatefulWidget {
  const EnableNotificationButton({
    required this.isEnabled,
    required this.onChange,
    Key? key,
  }) : super(key: key);

  final bool isEnabled;
  final ValueChanged<bool> onChange;

  @override
  State<EnableNotificationButton> createState() =>
      _EnableNotificationButtonState();
}

@override
class _EnableNotificationButtonState extends State<EnableNotificationButton> {
  late bool isEnabled;

  @override
  void initState() {
    super.initState();
    isEnabled = widget.isEnabled;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(bottom: 12.0, left: 12.0, right: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'enable_notifications'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: 14.0),
                ),
                CupertinoSwitch(
                  activeColor: Colors.white,
                  thumbColor: isEnabled
                      ? AppColors.PRIMARY_COLOR
                      : AppColors.GREY_NORMAL_COLOR,
                  value: isEnabled,
                  onChanged: (value) =>
                      setState(() => widget.onChange(isEnabled = value)),
                )
              ],
            ),
          ),
          const Divider(
            color: AppColors.GREY_NORMAL_COLOR,
          )
        ],
      ),
    );
  }
}
