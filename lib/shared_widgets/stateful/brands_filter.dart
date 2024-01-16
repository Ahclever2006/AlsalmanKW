import 'package:flutter/material.dart';
import 'package:size_helper/size_helper.dart';

import '../../core/data/models/brand_model.dart';
import '../../res/style/app_colors.dart';
import '../stateless/title_text.dart';

class BrandsFilter extends StatefulWidget {
  const BrandsFilter({required this.brands, required this.onPress, super.key});

  final List<CategoryBrandModel> brands;
  final ValueChanged<int> onPress;

  @override
  State<BrandsFilter> createState() => _BrandsFilterState();
}

class _BrandsFilterState extends State<BrandsFilter> {
  int selectedBrandId = -1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sizeHelper(
        mobileLarge: 45,
        desktopSmall: 55,
      ),
      child: Column(
        children: [
          _buildDivider(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              scrollDirection: Axis.horizontal,
              children: widget.brands.map((e) {
                var isSelected = selectedBrandId == e.id;
                return InkWell(
                  onTap: () {
                    widget.onPress(e.id);
                    setState(() {
                      selectedBrandId = e.id;
                    });
                  },
                  child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.PRIMARY_COLOR
                            : Colors.grey.shade200,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: TitleText.medium(
                        text: e.name,
                        color: isSelected ? Colors.white : null,
                      )),
                );
              }).toList(),
            ),
          ),
          _buildDivider(),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      thickness: 2,
      height: 8.0,
    );
  }
}
