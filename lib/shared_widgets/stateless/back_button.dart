import 'package:flutter/material.dart';

import '../../core/utils/navigator_helper.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key? key,
    this.color = Colors.black,
    this.onPress,
    this.label,
  }) : super(key: key);
  final Color color;
  final VoidCallback? onPress;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Navigator.of(context).canPop()
        ? Row(children: [
            InkWell(
              onTap: onPress ?? NavigatorHelper.of(context).pop,
              child: Icon(
                Icons.arrow_back_rounded,
                size: 28.0,
                color: color,
              ),
            ),
            if (label != null)
              Expanded(
                child: Text(
                  label!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
              )
          ])
        : const SizedBox();
  }
}
