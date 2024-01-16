import '../../core/enums/sort_type.dart';
import '../../core/utils/navigator_helper.dart';
import '../../res/style/app_colors.dart';
import '../stateful/default_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../stateless/title_text.dart';

const sortListData = [
  SortType.position,
  SortType.nameAscending,
  SortType.nameDescending,
  SortType.priceAscending,
  SortType.priceDescending,
];

void showSortBottomSheet(BuildContext context,
        {required String label,
        required List<SortType> sortData,
        required ValueChanged<int> onPress}) =>
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        barrierColor: AppColors.BARRIER_COLOR,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return SimpleBottomSheetWidget(
            label: label,
            sortData: sortData,
            onPress: onPress,
          );
        });

class SimpleBottomSheetWidget extends StatefulWidget {
  const SimpleBottomSheetWidget(
      {required this.label,
      required this.sortData,
      required this.onPress,
      super.key});

  final String label;
  final ValueChanged<int> onPress;
  final List<SortType> sortData;

  @override
  State<SimpleBottomSheetWidget> createState() =>
      _SimpleBottomSheetWidgetState();
}

class _SimpleBottomSheetWidgetState extends State<SimpleBottomSheetWidget> {
  int? selectedSortMethod;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TitleText(
            text: widget.label,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          ..._buildSortRadioList(widget.sortData),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultButton(
              label: 'clear_all'.tr(),
              labelStyle: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: AppColors.PRIMARY_COLOR_DARK, height: 1.0),
              backgroundColor: AppColors.PRIMARY_COLOR_LIGHT,
              enabled: selectedSortMethod != null,
              onPressed: () {
                selectedSortMethod = null;
                setState(() {});
              }),
          const SizedBox(width: 16.0),
          DefaultButton(
              enabled: selectedSortMethod != null,
              label: 'show_result'.tr(),
              onPressed: () {
                NavigatorHelper.of(context).pop();
                widget.onPress(selectedSortMethod!);
              }),
        ],
      ),
    );
  }

  List<Widget> _buildSortRadioList(List<SortType> sortData) {
    return sortData
        .map((e) => RadioListTile<int?>(
            value: e.value,
            groupValue: selectedSortMethod,
            title: TitleText(text: e.name),
            onChanged: (sortMethod) {
              selectedSortMethod = sortMethod;
              setState(() {});
            }))
        .toList();
  }
}
