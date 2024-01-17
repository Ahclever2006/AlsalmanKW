import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../res/style/app_colors.dart';
import 'default_button.dart';

class ScrollUpButton extends StatefulWidget {
  const ScrollUpButton({
    Key? key,
    required ScrollController scrollController,
  })  : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;

  @override
  State<ScrollUpButton> createState() => _ScrollUpButtonState();
}

class _ScrollUpButtonState extends State<ScrollUpButton> {
  var showButton = false;

  @override
  void initState() {
    widget._scrollController.addListener(_onScrollListener);
    super.initState();
  }

  void _onScrollListener() {
    if (widget._scrollController.position.pixels > 250) {
      if (!showButton) {
        setState(() {
          showButton = true;
        });
      }
    } else {
      if (showButton) {
        setState(() {
          showButton = false;
        });
      }
    }
  }

  @override
  void dispose() {
    widget._scrollController.removeListener(_onScrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
        scale: showButton ? 1 : 0,
        duration: const Duration(milliseconds: 500),
        child: DefaultButton(
            margin: const EdgeInsets.all(8.0),
            label: 'back_to_top'.tr(),
            labelStyle: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: Colors.white),
            backgroundColor: AppColors.PRIMARY_COLOR,
            onPressed: _scrollUp));
  }

  void _scrollUp() {
    widget._scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
