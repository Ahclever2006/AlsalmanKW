import 'package:flutter_svg/svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import '../../core/enums/sort_type.dart';
import '../../core/utils/media_query_values.dart';
import '../../core/data/models/price_range_model.dart';
import '../../core/data/models/filter_attribute.dart';
import '../../core/data/models/id_name_model.dart';
import '../../core/utils/type_defs.dart';
import '../../res/style/theme.dart';
import '../stateless/subtitle_text.dart';
import '../../core/utils/navigator_helper.dart';
import '../../res/style/app_colors.dart';
import '../stateful/default_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../stateless/title_text.dart';

const sortListData2 = [
  SortType.position,
  SortType.nameAscending,
  SortType.nameDescending,
  SortType.priceAscending,
  SortType.priceDescending,
];

void showSortAndFilterBottomSheet(
  BuildContext context, {
  required String label,
  required List<SortType> sortData,
  required List<IdNameModel> tagsData,
  required List<FilterAttribute> filterData,
  required ValueChangedFilterAndSort onPress,
  required List<int> selectedTags,
  required List<Map> selectedAttributes,
  required PriceRangeModel? priceRange,
  required PriceRangeModel? selectedPriceRange,
}) =>
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
            tagsData: tagsData,
            filterData: filterData,
            selectedAttributes: selectedAttributes,
            selectedTags: selectedTags,
            priceRange: priceRange,
            selectedPriceRange: selectedPriceRange,
          );
        });

class SimpleBottomSheetWidget extends StatefulWidget {
  const SimpleBottomSheetWidget(
      {required this.label,
      required this.sortData,
      required this.onPress,
      required this.tagsData,
      required this.filterData,
      required this.selectedTags,
      required this.selectedAttributes,
      required this.priceRange,
      required this.selectedPriceRange,
      super.key});

  final String label;
  final ValueChangedFilterAndSort onPress;
  final List<SortType> sortData;
  final List<IdNameModel> tagsData;
  final List<FilterAttribute> filterData;
  final List<int> selectedTags;
  final List<Map> selectedAttributes;
  final PriceRangeModel? priceRange;
  final PriceRangeModel? selectedPriceRange;

  @override
  State<SimpleBottomSheetWidget> createState() =>
      _SimpleBottomSheetWidgetState();
}

class _SimpleBottomSheetWidgetState extends State<SimpleBottomSheetWidget> {
  int? selectedSortMethod;
  double? _lowerValue;
  double? _upperValue;
  int selectedMainFilterIndex = -1;
  List<int> _selectedTags = [];
  List<Map> _selectedAttributes = [];
  bool isPricePressed = false;

  @override
  void initState() {
    _lowerValue =
        (widget.selectedPriceRange?.from ?? widget.priceRange!.from) as double;
    _upperValue =
        (widget.selectedPriceRange?.to ?? widget.priceRange!.to) as double;
    _selectedTags = widget.selectedTags;
    _selectedAttributes = widget.selectedAttributes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * .80,
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ListView(
              shrinkWrap: true,
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     TitleText(text: widget.label),
                //     const Row(
                //       children: [
                //         TitleText(text: 'A-Z'),
                //         Icon(Icons.arrow_upward_outlined)
                //       ],
                //     ),
                //   ],
                // ),
                _buildHeader(context),
                const SizedBox(height: 16.0),
                _buildSortTile(widget.sortData),
                const Divider(
                    color: AppColors.GREY_NORMAL_COLOR, thickness: 2.0),
                _buildFilterData(
                    widget.tagsData, widget.filterData, widget.priceRange),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: DefaultButton(
                isExpanded: false,
                padding: const EdgeInsets.symmetric(
                    horizontal: 64.0, vertical: 20.0),
                margin: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 20.0),
                enabled: selectedSortMethod != null ||
                    _selectedTags.isNotEmpty ||
                    _selectedAttributes.isNotEmpty ||
                    _lowerValue != null ||
                    _upperValue != null,
                label: 'show_products'.tr(),
                onPressed: () {
                  NavigatorHelper.of(context).pop();
                  widget.onPress(
                      _selectedTags,
                      _selectedAttributes,
                      PriceRangeModel(from: _lowerValue!, to: _upperValue!),
                      selectedSortMethod ?? 0);
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: InkWell(
              onTap: () {
                NavigatorHelper.of(context).pop(true);
              },
              child: SvgPicture.asset('lib/res/assets/cancel_icon.svg')),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: TitleText(
            text: widget.label,
            textAlign: TextAlign.center,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: DefaultButton(
              label: 'clear_all'.tr().toLowerCase(),
              labelStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: AppColors.PRIMARY_COLOR_DARK,
                  height: 1.0,
                  fontWeight: FontWeight.normal),
              backgroundColor: AppColors.PRIMARY_COLOR_LIGHT,
              borderColor: AppColors.BARRIER_COLOR,
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              padding: const EdgeInsets.all(8.0),
              enabled: selectedSortMethod != null ||
                  _selectedTags.isNotEmpty ||
                  _selectedAttributes.isNotEmpty,
              onPressed: () {
                selectedSortMethod = null;
                _selectedTags.clear();
                _selectedAttributes.clear();
                setState(() {});
              }),
        ),
      ],
    );
  }

  Widget _buildSortTile(List<SortType> sortData) => ExpansionTile(
        iconColor: AppColors.PRIMARY_COLOR,
        collapsedIconColor: AppColors.PRIMARY_COLOR,
        title: TitleText(
          text: "sort".tr(),
        ),
        children: _buildSortRadioList(sortData),
      );
  List<Widget> _buildSortRadioList(List<SortType> sortData) {
    return sortData
        .map((e) => Row(
              children: [
                Expanded(child: SubtitleText(text: e.name)),
                Radio(
                    value: e.value,
                    groupValue: selectedSortMethod,
                    onChanged: (sortMethod) {
                      selectedSortMethod = sortMethod;
                      setState(() {});
                    })
              ],
            ))
        .toList();
  }

  Widget _buildFilterItem(
      {required String label,
      required VoidCallback onPress,
      required bool isPressed,
      required bool isTags,
      required List<IdNameModel> data,
      required ValueChanged<int> onPressItem}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpansionTile(
          iconColor: AppColors.PRIMARY_COLOR,
          collapsedIconColor: AppColors.PRIMARY_COLOR,
          title: TitleText(
            text: label,
          ),
          onExpansionChanged: (value) {
            onPress();
          },
          children: [
            Wrap(
              alignment: WrapAlignment.start,
              children: data
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: ChoiceChip(
                          backgroundColor: Colors.grey[400],
                          label:
                              SubtitleText(text: e.name, color: Colors.white),
                          selectedColor: AppColors.PRIMARY_COLOR_DARK,
                          selected: isTags
                              ? _selectedTags.contains(e.id)
                              : _selectedAttributes.any((m) =>
                                  m['SpecificationAttributeOptionId'] == e.id),
                          onSelected: (value) {
                            onPressItem(e.id);
                            setState(() {});
                          },
                        ),
                      ))
                  .toList(),
            )
          ],
        ),
        const Divider(color: AppColors.GREY_NORMAL_COLOR, thickness: 2.0),
      ],
    );
  }

  Widget _buildPriceRange(
      {required String label,
      required VoidCallback onPress,
      required bool isPressed,
      required PriceRangeModel priceRange}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpansionTile(
            iconColor: AppColors.PRIMARY_COLOR,
            collapsedIconColor: AppColors.PRIMARY_COLOR,
            onExpansionChanged: (value) {
              onPress();
            },
            title: TitleText(
              text: label,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const TitleText(text: 'currency'),
                        const SizedBox(width: 8.0),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 4.0),
                          color: AppColors.GREY_LIGHT_COLOR,
                          child: TitleText(text: _lowerValue.toString()),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const TitleText(text: 'currency'),
                        const SizedBox(width: 8.0),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 4.0),
                          color: AppColors.GREY_LIGHT_COLOR,
                          child: TitleText(text: _upperValue.toString()),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              FlutterSlider(
                values: [
                  _lowerValue ?? (widget.priceRange!.from as double),
                  _upperValue ?? (widget.priceRange!.to as double)
                ],
                rightHandler: FlutterSliderHandler(
                    child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.PRIMARY_COLOR_DARK),
                )),
                handler: FlutterSliderHandler(
                    child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.PRIMARY_COLOR_DARK),
                )),
                trackBar: const FlutterSliderTrackBar(
                    activeTrackBar:
                        BoxDecoration(color: AppColors.PRIMARY_COLOR)),
                rangeSlider: true,
                max: widget.priceRange!.to as double,
                min: widget.priceRange!.from as double,
                onDragging: (handlerIndex, lowerValue, upperValue) {
                  _lowerValue = lowerValue;
                  _upperValue = upperValue;
                  setState(() {});
                },
              )
            ]),
        const Divider(color: AppColors.GREY_NORMAL_COLOR, thickness: 2.0),
      ],
    );
  }

  Widget _buildFilterData(
    List<IdNameModel> tagsData,
    List<FilterAttribute> filterData,
    PriceRangeModel? priceRange,
  ) {
    final validPriceRange =
        ((priceRange?.to as double) > 0 || (priceRange?.from as double) > 0);
    return Column(
      children: [
        if (priceRange != null && validPriceRange)
          _buildPriceRange(
            label: 'price',
            priceRange: priceRange,
            onPress: () {
              isPricePressed = !isPricePressed;
              selectedMainFilterIndex = -1;
              setState(() {});
            },
            isPressed: isPricePressed,
          ),
        if (tagsData.isNotEmpty)
          _buildFilterItem(
              label: 'tags',
              isPressed: selectedMainFilterIndex == 0,
              isTags: true,
              data: widget.tagsData,
              onPressItem: (value) {
                if (_selectedTags.contains(value))
                  _selectedTags.remove(value);
                else
                  _selectedTags.add(value);

                setState(() {});
              },
              onPress: () {
                if (selectedMainFilterIndex != 0)
                  selectedMainFilterIndex = 0;
                else
                  selectedMainFilterIndex = -1;
                setState(() {});
              }),
        ...filterData
            .mapIndexed((i, e) => _buildFilterItem(
                label: e.name,
                isPressed: selectedMainFilterIndex == i + 1,
                isTags: false,
                data: e.specificationAttributeOptions
                    .map((e) => IdNameModel(e.id!, e.name))
                    .toList(),
                onPressItem: (value) {
                  if (_selectedAttributes
                      .any((e) => e['SpecificationAttributeOptionId'] == value))
                    _selectedAttributes.removeWhere(
                        (e) => e['SpecificationAttributeOptionId'] == value);
                  else
                    _selectedAttributes.add({
                      "SpecificationAttributeOptionId": value,
                      "SpecificationAttributeId": e.specificationAttributeId,
                    });

                  setState(() {});
                },
                onPress: () {
                  isPricePressed = false;
                  if (selectedMainFilterIndex != i + 1)
                    selectedMainFilterIndex = i + 1;
                  else
                    selectedMainFilterIndex = -1;
                  setState(() {});
                }))
            .toList()
      ],
    );
  }
}
