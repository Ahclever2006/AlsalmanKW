import 'package:alsalman_app/core/utils/navigator_helper.dart';
import 'package:alsalman_app/features/orders/presentation/pages/order_details_page.dart';
import 'package:alsalman_app/shared_widgets/stateless/subtitle_text.dart';
import 'package:alsalman_app/shared_widgets/stateless/title_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '/res/style/app_colors.dart';
import '/shared_widgets/stateful/default_button.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen(
      {Key? key, required this.isSuccess, required this.orderId})
      : super(key: key);

  final bool isSuccess;
  final int orderId;

  @override
  Widget build(BuildContext context) {
    return CustomAppPage(
      safeTop: true,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 32.0),
              child: Image.asset(isSuccess
                  ? 'lib/res/assets/goldfish_icon.png'
                  : 'lib/res/assets/fish_icon.png'),
            ),
            TitleText.large(
              text: isSuccess ? "order_success" : "order_failed",
              color: isSuccess
                  ? AppColors.PRIMARY_COLOR_DARK
                  : AppColors.ERROR_COLOR,
              margin: const EdgeInsets.all(16.0),
            ),
            SubtitleText(
              text: isSuccess
                  ? "order_success_subtitle".tr(args: [orderId.toString()])
                  : "order_failed_subtitle",
              color: isSuccess
                  ? AppColors.PRIMARY_COLOR_DARK
                  : AppColors.ERROR_COLOR,
              margin: const EdgeInsets.all(16.0),
            ),
            const SizedBox(height: 48.0),
            DefaultButton(
                label: 'order_details'.tr(),
                labelStyle: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: Colors.white, height: 1.0),
                backgroundColor: AppColors.PRIMARY_COLOR,
                margin: const EdgeInsets.symmetric(horizontal: 48.0),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
                isExpanded: true,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                onPressed: () {
                  NavigatorHelper.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (_) {
                    return OrderDetailsPage(orderId: orderId);
                  }));
                }),
            const SizedBox(height: 16.0),
            DefaultButton(
                label: 'home'.tr(),
                labelStyle: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: Colors.white, height: 1.0),
                backgroundColor: AppColors.PRIMARY_COLOR_DARK,
                margin: const EdgeInsets.symmetric(horizontal: 48.0),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
                isExpanded: true,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                onPressed: () {
                  //TODO: check this button
                  NavigatorHelper.of(context).pop();
                }),
          ],
        ),
      ),
    );
  }
}
