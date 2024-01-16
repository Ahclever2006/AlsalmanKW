import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../res/style/app_colors.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    required this.children,
    required int currentPage,
  })  : _currentPage = currentPage,
        super(key: key);

  final List children;
  final int _currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children
          .mapIndexed(
            (index, banner) => Container(
              margin: const EdgeInsets.all(4.0),
              height: 8.0,
              width: _currentPage == index ? 30.0 : 10,
              decoration: BoxDecoration(
                shape: _currentPage != index
                    ? BoxShape.circle
                    : BoxShape.rectangle,
                borderRadius: _currentPage == index
                    ? const BorderRadius.all(Radius.circular(10.0))
                    : null,
                color: _currentPage == index
                    ? AppColors.PRIMARY_COLOR
                    : AppColors.PRIMARY_COLOR.withOpacity(0.2),
              ),
            ),
          )
          .toList(),
    );
  }
}
