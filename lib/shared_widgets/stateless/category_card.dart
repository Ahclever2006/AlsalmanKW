import 'package:flutter/material.dart';

import '../../core/data/models/home_categ_model.dart';
import 'custom_cached_network_image.dart';
import 'title_text.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    required this.onPress,
    required this.category,
    required this.size,
    Key? key,
  }) : super(key: key);

  final CategoryModel category;
  final VoidCallback onPress;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //TODO: check responsive
      width: 100.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: onPress,
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: CustomCachedNetworkImage(
                imageUrl: category.pictureModel?.imageUrl ?? '',
                urlHeight: 200,
                urlWidth: 200,
                imageMode: ImageMode.Pad,
                scaleMode: ScaleMode.Both,
                fit: BoxFit.cover,
                width: size,
                height: size,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Flexible(
            child: TitleText.medium(
              text: category.name!,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
