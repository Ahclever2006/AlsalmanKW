import 'package:flutter/material.dart';

import '../../res/style/app_colors.dart';
import '../stateless/subtitle_text.dart';
import '../stateless/title_text.dart';

void showWalletTransactionBottomSheet(
  BuildContext context, {
  required String label,
  required String subtitle1,
  required String subtitle2,
}) =>
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        barrierColor: AppColors.BARRIER_COLOR,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return SimpleWalletTransactionBottomSheetWidget(
            label: label,
            subtitle1: subtitle1,
            subtitle2: subtitle2,
          );
        });

class SimpleWalletTransactionBottomSheetWidget extends StatelessWidget {
  const SimpleWalletTransactionBottomSheetWidget(
      {required this.label,
      required this.subtitle1,
      required this.subtitle2,
      super.key});

  final String label;
  final String subtitle1;
  final String subtitle2;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: AppColors.SECONDARY_COLOR,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16.0),
          TitleText(text: label),
          const SizedBox(height: 24.0),
          SubtitleText.medium(text: subtitle1),
          const SizedBox(height: 8.0),
          SubtitleText.medium(text: subtitle2),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
