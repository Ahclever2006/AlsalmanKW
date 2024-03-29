import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../res/style/app_colors.dart';

class SortAndFilterButton extends StatefulWidget {
  const SortAndFilterButton({
    Key? key,
    required this.onSortPress,
  }) : super(key: key);

  final VoidCallback onSortPress;
  // final VoidCallback onFilterPress;

  @override
  State<SortAndFilterButton> createState() => _SortAndFilterButtonState();
}

class _SortAndFilterButtonState extends State<SortAndFilterButton> {
  @override
  Widget build(BuildContext context) {
    return _buildButton(
        icon: 'flitter_and_sort_icon', onPress: widget.onSortPress);
  }

  Widget _buildButton({
    required VoidCallback onPress,
    required String icon,
  }) {
    return IconButton(
        onPressed: onPress,
        icon: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'lib/res/assets/$icon.svg',
              color: AppColors.PRIMARY_COLOR,
            ),
          ],
        ));
  }
}
