import 'package:flutter/material.dart';
import 'package:size_helper/size_helper.dart';

class MainTitleText extends StatelessWidget {
  const MainTitleText(
      {Key? key, required String title, double horizontalPadding = 16.0})
      : _title = title,
        super(key: key);

  final String _title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        _title,
        style: Theme.of(context).textTheme.headline2!.copyWith(
                fontSize: context.sizeHelper(
              tabletLarge: 20.0,
              desktopSmall: 30.0,
            )),
      ),
    );
  }
}
