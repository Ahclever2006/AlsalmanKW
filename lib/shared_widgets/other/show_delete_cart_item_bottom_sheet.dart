import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/utils/navigator_helper.dart';
import '../../core/utils/type_defs.dart';
import '../../res/style/app_colors.dart';
import '../stateful/default_button.dart';
import '../stateless/custom_cached_network_image.dart';
import '../stateless/title_text.dart';

void showDeleteCartItemBottomSheet(BuildContext context,
        {required String label,
        required String name,
        required String image,
        required String deliveryText,
        required FutureCallback onPress}) =>
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        barrierColor: AppColors.BARRIER_COLOR,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return SimpleBottomSheetWidget(
            label: label,
            name: name,
            image: image,
            deliveryText: deliveryText,
            onPress: onPress,
          );
        });

class SimpleBottomSheetWidget extends StatelessWidget {
  const SimpleBottomSheetWidget(
      {required this.label,
      required this.name,
      required this.image,
      required this.deliveryText,
      required this.onPress,
      super.key});

  final String label;
  final String name;
  final String image;
  final String deliveryText;
  final FutureCallback onPress;

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
            color: AppColors.PRIMARY_COLOR_DARK,
          ),
          const SizedBox(height: 16.0),
          _buildDivider(),
          const SizedBox(height: 8.0),
          Container(
            height: 156.0,
            decoration: const BoxDecoration(
              color: AppColors.SECONDARY_COLOR,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildImage(image),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16.0),
                                  TitleText.medium(
                                    text: name,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 16.0),
                                  TitleText.medium(
                                    text: deliveryText,
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          _buildDivider(),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.PRIMARY_COLOR,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: CustomCachedNetworkImage(
        width: 140.0,
        height: 140.0,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        imageUrl: imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  Divider _buildDivider() =>
      const Divider(thickness: 1.0, color: AppColors.GREY_DARK_COLOR);

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: DefaultButton(
                borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                label: 'cancel'.tr(),
                backgroundColor: AppColors.ACCENT_COLOR,
                onPressed: () => NavigatorHelper.of(context).pop()),
          ),
          const SizedBox(width: 16.0),
          Expanded(
              child: DefaultButton(
                  label: 'yes'.tr(),
                  borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                  onPressed: () => onPress())),
        ],
      ),
    );
  }
}
