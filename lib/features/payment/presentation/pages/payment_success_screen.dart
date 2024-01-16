import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '/core/service/launcher_service.dart';
import '/res/style/app_colors.dart';
import '/shared_widgets/stateful/default_button.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppPage(
      safeTop: true,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('lib/res/assets/Success.json', fit: BoxFit.fill),
            Text(
              'Thanks For Purchase\nYour Application',
              style: Theme.of(context).textTheme.displayLarge,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'We Will Contact You Soon !',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'For More Information Call Us',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
            DefaultButton(
                label: '+965 555 98118',
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                onPressed: () {
                  LauncherServiceImpl().callPhone("+96555598118");
                }),
            const SizedBox(height: 16.0),
            DefaultButton(
                label: 'go_to_home_page'.tr(),
                labelStyle: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: AppColors.PRIMARY_COLOR, height: 1.0),
                backgroundColor: Colors.white,
                borderColor: AppColors.PRIMARY_COLOR,
                margin: const EdgeInsets.symmetric(horizontal: 24.0),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
                isExpanded: true,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                onPressed: () {
                  // navigate to home page
                }),
          ],
        ),
      ),
    );
  }
}
