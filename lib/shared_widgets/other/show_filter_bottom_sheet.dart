import '../../core/data/models/filter_attribute.dart';
import '../../core/data/models/id_name_model.dart';
import '../../core/utils/type_defs.dart';
import '../stateless/subtitle_text.dart';

import '../../core/utils/navigator_helper.dart';
import '../../res/style/app_colors.dart';
import '../stateful/default_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:collection/collection.dart';

import '../stateless/title_text.dart';

void showFilterBottomSheet(
  BuildContext context, {
  required String label,
  required List<IdNameModel> tagsData,
  required List<FilterAttribute> filterData,
  required ValueChangedFilter onPress,
  required List<int> selectedTags,
  required List<Map> selectedAttributes,
}) =>
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        barrierColor: AppColors.BARRIER_COLOR,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return SimpleBottomSheetWidget(
            label: label,
            tagsData: tagsData,
            filterData: filterData,
            onPress: onPress,
            selectedAttributes: selectedAttributes,
            selectedTags: selectedTags,
          );
        });

class SimpleBottomSheetWidget extends StatefulWidget {
  const SimpleBottomSheetWidget(
      {required this.label,
      required this.tagsData,
      required this.filterData,
      required this.onPress,
      required this.selectedTags,
      required this.selectedAttributes,
      super.key});

  final String label;
  final ValueChangedFilter onPress;
  final List<IdNameModel> tagsData;
  final List<FilterAttribute> filterData;
  final List<int> selectedTags;
  final List<Map> selectedAttributes;

  @override
  State<SimpleBottomSheetWidget> createState() =>
      _SimpleBottomSheetWidgetState();
}

class _SimpleBottomSheetWidgetState extends State<SimpleBottomSheetWidget> {
  int selectedMainFilterIndex = 0;
  List<int> _selectedTags = [];
  List<Map> _selectedAttributes = [];
  PageController? _controller;

  @override
  void initState() {
    _selectedTags = widget.selectedTags;
    _selectedAttributes = widget.selectedAttributes;
    _controller = PageController(initialPage: 0, viewportFraction: 0.9999);
    super.initState();
  }

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
          _buildFilterPageView(widget.tagsData, widget.filterData),
          _buildActionButtons(context, widget.tagsData, widget.filterData),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    List<IdNameModel> tagsData,
    List<FilterAttribute> filterData,
  ) {
    if (tagsData.isEmpty && filterData.isEmpty)
      return const SizedBox();
    else
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultButton(
                label: 'clear_all'.tr(),
                labelStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: AppColors.PRIMARY_COLOR_DARK,
                    height: 1.0,
                    fontWeight: FontWeight.normal),
                backgroundColor: AppColors.PRIMARY_COLOR_LIGHT,
                enabled: (_selectedTags.isNotEmpty ||
                    _selectedAttributes.isNotEmpty),
                onPressed: () {
                  _selectedTags.clear();
                  _selectedAttributes.clear();
                  setState(() {});
                }),
            const SizedBox(width: 16.0),
            DefaultButton(
                label: 'apply'.tr(),
                onPressed: () {
                  NavigatorHelper.of(context).pop();
                  widget.onPress(_selectedTags, _selectedAttributes);
                }),
          ],
        ),
      );
  }

  Widget _buildFilterPageView(
    List<IdNameModel> tagsData,
    List<FilterAttribute> filterData,
  ) {
    if (tagsData.isEmpty && filterData.isEmpty)
      return const SizedBox(
          height: 300, child: Center(child: TitleText(text: "no_data")));
    else
      return Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (tagsData.isNotEmpty)
                      _buildFilterMainItem(
                          label: 'tags',
                          isPressed: selectedMainFilterIndex == 0,
                          onPress: () {
                            selectedMainFilterIndex = 0;
                            _controller!.jumpToPage(0);
                            setState(() {});
                          }),
                    ...filterData
                        .mapIndexed((i, e) => _buildFilterMainItem(
                            label: e.name,
                            //TODO: check 1 + 1 issue later
                            isPressed: selectedMainFilterIndex == i + 1,
                            onPress: () {
                              selectedMainFilterIndex = i + 1;
                              _controller!.jumpToPage(i + 1);
                              setState(() {});
                            }))
                        .toList()
                  ],
                ),
              ),
            ),
            Expanded(
              child: PageView(controller: _controller, children: [
                _buildRightSide(
                  true,
                  widget.tagsData,
                  (value) {
                    if (_selectedTags.contains(value))
                      _selectedTags.remove(value);
                    else
                      _selectedTags.add(value);

                    setState(() {});
                  },
                ),
                ...filterData
                    .mapIndexed((i, e) => _buildRightSide(
                          false,
                          e.specificationAttributeOptions
                              .map((e) => IdNameModel(e.id!, e.name))
                              .toList(),
                          (value) {
                            if (_selectedAttributes.any((e) =>
                                e['SpecificationAttributeOptionId'] == value))
                              _selectedAttributes.removeWhere((e) =>
                                  e['SpecificationAttributeOptionId'] == value);
                            else
                              _selectedAttributes.add({
                                "SpecificationAttributeOptionId": value,
                                "SpecificationAttributeId":
                                    e.specificationAttributeId,
                              });

                            setState(() {});
                          },
                        ))
                    .toList()
              ]),
            )
          ],
        ),
      );
  }

  Widget _buildFilterMainItem(
      {required String label,
      required VoidCallback onPress,
      required bool isPressed}) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.all(12.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: isPressed
              ? AppColors.PRIMARY_COLOR_DARK
              : AppColors.PRIMARY_COLOR_LIGHT,
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: TitleText(
          textAlign: TextAlign.center,
          text: label,
          color: isPressed ? Colors.white : AppColors.PRIMARY_COLOR,
        ),
      ),
    );
  }

  Widget _buildRightSide(
      bool isTags, List<IdNameModel> data, ValueChanged<int> onPress) {
    return ListView(
      children: data
          .map((e) => Theme(
                data: ThemeData.light().copyWith(
                    checkboxTheme: CheckboxThemeData(
                  fillColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return AppColors.PRIMARY_COLOR_LIGHT;
                    } else
                      return AppColors.PRIMARY_COLOR_DARK;
                  }),
                  checkColor:
                      MaterialStateProperty.all(AppColors.GREY_BORDER_COLOR),
                )),
                child: Row(
                  children: [
                    Checkbox(
                        value: isTags
                            ? _selectedTags.contains(e.id)
                            : _selectedAttributes.any((m) =>
                                m['SpecificationAttributeOptionId'] == e.id),
                        onChanged: (value) {
                          onPress(e.id);
                        }),
                    Expanded(
                      child: InkWell(
                          onTap: () async {
                            setState(() {});
                          },
                          child: SubtitleText.large(text: e.name, maxLines: 2)),
                    )
                  ],
                ),
              ))
          .toList(),
    );
  }
}
