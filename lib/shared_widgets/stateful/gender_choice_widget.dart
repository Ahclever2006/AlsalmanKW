import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../res/style/app_colors.dart';
import '../stateless/subtitle_text.dart';

class GenderChoiceWidget extends StatefulWidget {
  const GenderChoiceWidget(
      {this.initialGender, required this.onChange, Key? key})
      : super(key: key);

  final ValueChanged<int> onChange;
  final int? initialGender;

  @override
  State<GenderChoiceWidget> createState() => _GenderChoiceWidgetState();
}

class _GenderChoiceWidgetState extends State<GenderChoiceWidget> {
  int? _selectedIndex;

  @override
  void initState() {
    _selectedIndex = widget.initialGender;
    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 60.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: _buildItem(
                label: 'male'.tr(),
                isSelected: _selectedIndex == 1,
                onPress: () {
                  setState(() {
                    _selectedIndex = 1;
                  });

                  widget.onChange(_selectedIndex!);
                }),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: _buildItem(
                label: 'female'.tr(),
                isSelected: _selectedIndex == 2,
                onPress: () {
                  setState(() {
                    _selectedIndex = 2;
                  });

                  widget.onChange(_selectedIndex!);
                }),
          ),
        ],
      ),
    );
  }

  InkWell _buildItem({
    required String label,
    required bool isSelected,
    required VoidCallback onPress,
  }) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.PRIMARY_COLOR_DARK),
          color: isSelected ? AppColors.PRIMARY_COLOR : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: SubtitleText(textAlign: TextAlign.center, text: label),
      ),
      onTap: onPress,
    );
  }
}
