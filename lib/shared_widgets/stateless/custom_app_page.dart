import 'package:alsalman_app/res/style/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppPage extends StatelessWidget {
  const CustomAppPage({
    Key? key,
    bool withBackground = false,
    Widget? child,
    bool clearSnackBarOnLaunch = false,
    bool safeTop = false,
    bool safeBottom = true,
    bool safeLeft = false,
    bool safeRight = false,
    WillPopCallback? onWillPop,
    List<Widget>? stackChildren,
  })  : _withBackground = withBackground,
        _child = child,
        _clearSnackBarOnLaunch = clearSnackBarOnLaunch,
        _safeTop = safeTop,
        _safeBottom = safeBottom,
        _safeLeft = safeLeft,
        _safeRight = safeRight,
        _onWillPop = onWillPop,
        _stackChildren = stackChildren,
        super(key: key);
  final bool _withBackground;
  final Widget? _child;
  final bool _clearSnackBarOnLaunch;
  final bool _safeTop;
  final bool _safeBottom;
  final bool _safeLeft;
  final bool _safeRight;
  final List<Widget>? _stackChildren;
  final WillPopCallback? _onWillPop;

  @override
  Widget build(BuildContext context) {
    Widget? newChild = _child;

    if (_clearSnackBarOnLaunch) _clearAnySnackBarFromPreviousPage(context);

    if (_onWillPop != null)
      newChild = WillPopScope(
        child: _child!,
        onWillPop: () => _onWillPop!(),
      );
    return Container(
      decoration: const BoxDecoration(color: AppColors.CUSTOM_APP_PAGE_COLOR),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (_withBackground)
            Image.asset(
              'lib/res/assets/background.png',
              fit: BoxFit.cover,
            ),
          if (newChild != null)
            SafeArea(
              top: _safeTop,
              left: _safeLeft,
              right: _safeRight,
              bottom: _safeBottom,
              child: newChild,
            ),
          ...?_stackChildren,
        ],
      ),
    );
  }

  void _clearAnySnackBarFromPreviousPage(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
  }
}
