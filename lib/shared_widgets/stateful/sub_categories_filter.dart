import 'package:flutter/material.dart';
import 'package:size_helper/size_helper.dart';

import '../../core/data/models/home_categ_model.dart';
import '../../res/style/app_colors.dart';
import '../stateless/title_text.dart';

class SubCategoriesFilter extends StatefulWidget {
  const SubCategoriesFilter(
      {required this.subCategories,
      required this.onPress,
      this.padding = 16.0,
      super.key});

  final List<CategoryModel> subCategories;
  final ValueChanged<int> onPress;
  final double? padding;

  @override
  State<SubCategoriesFilter> createState() => _SubCategoriesFilterState();
}

class _SubCategoriesFilterState extends State<SubCategoriesFilter> {
  int selectedSubCategoryId = -1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sizeHelper(
        mobileLarge: 35,
        desktopSmall: 45,
      ),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: widget.padding!),
        scrollDirection: Axis.horizontal,
        children: widget.subCategories.map((e) {
          var isSelected = selectedSubCategoryId == e.id;
          return InkWell(
            onTap: () {
              widget.onPress(e.id!);
              setState(() {
                selectedSubCategoryId = e.id!;
              });
            },
            child: Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.PRIMARY_COLOR_LIGHT
                      : Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  border: isSelected
                      ? Border.all(color: AppColors.PRIMARY_COLOR_DARK)
                      : null,
                ),
                child: TitleText.medium(text: e.name!)),
          );
        }).toList(),
      ),
    );
  }
}
