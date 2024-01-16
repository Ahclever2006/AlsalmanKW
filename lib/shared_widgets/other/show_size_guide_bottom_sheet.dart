import 'package:flutter/material.dart';

import '../../res/style/app_colors.dart';
import '../stateless/custom_cached_network_image.dart';
import '../stateless/title_text.dart';

void showSizeGuideBottomSheet(BuildContext context,
        {required String label, required String imageUrl}) =>
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        barrierColor: AppColors.BARRIER_COLOR,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return SizeGuideBottomSheetWidget(label: label, imageUrl: imageUrl);
        });

class SizeGuideBottomSheetWidget extends StatelessWidget {
  const SizeGuideBottomSheetWidget(
      {required this.label, required this.imageUrl, super.key});

  final String label;
  final String imageUrl;

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          TitleText(
            text: label,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          _buildImage(context),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return CustomCachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
    );
  }
}
