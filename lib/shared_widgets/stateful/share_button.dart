import 'package:flutter/material.dart';

import '../../core/utils/type_defs.dart';
import '../../res/style/app_colors.dart';

class ShareButton extends StatefulWidget {
  const ShareButton({
    Key? key,
    required FutureCallback<void> onShareTap,
  })  : _onShareTap = onShareTap,
        super(key: key);

  final FutureCallback<void> _onShareTap;

  @override
  State<ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          padding: const EdgeInsets.all(6.0),
          child: const Icon(
            Icons.share,
            color: AppColors.PRIMARY_COLOR_DARK,
            size: 30.0,
          )),
      onTap: _isLoading
          ? () {}
          : () {
              final futureOf = widget._onShareTap();

              if (futureOf is Future) {
                _startLoading();
                futureOf.whenComplete(_stopLoading);
              }
            },
    );
  }

  void _startLoading() {
    _isLoading = true;
    if (mounted) setState(() {});
  }

  void _stopLoading() {
    _isLoading = false;
    if (mounted) setState(() {});
  }
}
