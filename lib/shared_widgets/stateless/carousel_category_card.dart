import '../../core/data/models/home_carousal_collection_model.dart';

import 'title_text.dart';
import 'package:flutter/material.dart';

import 'custom_cached_network_image.dart';

class CarouselCategoryCard extends StatelessWidget {
  const CarouselCategoryCard({
    required this.onPress,
    required this.category,
    required this.size,
    Key? key,
  }) : super(key: key);

  final SubCategories category;
  final VoidCallback onPress;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: onPress,
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: CustomCachedNetworkImage(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
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
        SizedBox(
            width: size,
            child: TitleText.medium(
              text: category.name!,
              maxLines: 2,
              textAlign: TextAlign.center,
            ))
      ],
    );
  }
}
