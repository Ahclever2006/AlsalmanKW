import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/utils/media_query_values.dart';

import '../../res/style/app_colors.dart';
import '../stateless/title_text.dart';

class WalletSwitchButton extends StatefulWidget {
  const WalletSwitchButton({
    Key? key,
    required this.isEnabled,
    required this.onPress,
  }) : super(key: key);

  final bool isEnabled;
  final ValueChanged<bool> onPress;

  @override
  State<WalletSwitchButton> createState() => WalletSwitchButtonState();
}

class WalletSwitchButtonState extends State<WalletSwitchButton> {
  bool _isEnabled = false;

  @override
  void initState() {
    _isEnabled = widget.isEnabled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.width * 0.15),
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: AppColors.WALLET_SWITCH_CONTAINER_COLOR,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Row(
        children: [
          SvgPicture.asset(_isEnabled
              ? 'lib/res/assets/wallet_active_icon.svg'
              : 'lib/res/assets/wallet_deactive_icon.svg'),
          const SizedBox(width: 12.0),
          Expanded(
              child: TitleText(
                  text:
                      !_isEnabled ? 'de_activate_wallet' : 'activate_wallet')),
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
      ),
    );
  }
}
