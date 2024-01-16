import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/utils/type_defs.dart';
import '../../res/style/app_colors.dart';

class DeleteButton extends StatefulWidget {
  const DeleteButton({
    Key? key,
    required FutureCallback<bool> onDeleteTap,
  })  : _onDeleteTap = onDeleteTap,
        super(key: key);

  final FutureCallback<bool> _onDeleteTap;

  @override
  State<DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          width: 40.0,
          height: 40.0,
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            boxShadow: AppColors.SHADOW,
            color: AppColors.ACCENT_COLOR,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: SvgPicture.asset(
            'lib/res/assets/trash.svg',
          )),
      onTap: _isLoading
          ? () {}
          : () {
              final futureOf = widget._onDeleteTap();

              if (futureOf is Future) {
                _startLoading();
                (futureOf as Future).whenComplete(_stopLoading);
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
