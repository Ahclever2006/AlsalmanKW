import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import '../../../auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import '../../../cart_tab/presentation/cubit/cart_cubit.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import '../../../../shared_widgets/stateless/inner_appbar.dart';
import '../../../../shared_widgets/stateless/title_text.dart';

import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/stateful/default_button.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';

class LanguageChooserPage extends StatelessWidget {
  static const routeName = '/LanguageChooserPage';

  const LanguageChooserPage({Key? key, this.fromAccountPage = false})
      : super(key: key);

  final bool fromAccountPage;

  @override
  Widget build(BuildContext context) {
    return CustomAppPage(
      safeTop: true,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const InnerPagesAppBar(label: 'language_title'),
            _buildLogo(),
            const TitleText(
              text: 'choose_language',
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            _buildLanguageButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: const [
        SizedBox(
          height: 80,
        ),
        Icon(
          Icons.language,
          color: AppColors.PRIMARY_COLOR_DARK,
          size: 60.0,
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }

  Widget _buildLanguageButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 50,
          height: 60,
          child: DefaultButton(
              label: 'ع',
              labelStyle: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: AppColors.PRIMARY_COLOR, height: 1.0),
              backgroundColor: Colors.white,
              borderColor: AppColors.PRIMARY_COLOR,
              borderRadius: const BorderRadius.all(Radius.circular(9.0)),
              padding: const EdgeInsets.symmetric(vertical: 16),
              onPressed: () {
                _chooseLanguage(context, 'ar');
              }),
        ),
        const SizedBox(
          width: 16,
        ),
        SizedBox(
          width: 50,
          height: 60,
          child: DefaultButton(
              label: 'EN',
              labelStyle: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Colors.white, height: 1.0),
              backgroundColor: AppColors.PRIMARY_COLOR,
              borderRadius: const BorderRadius.all(Radius.circular(9.0)),
              padding: const EdgeInsets.symmetric(vertical: 16),
              onPressed: () {
                _chooseLanguage(context, 'en');
              }),
        ),
      ],
    );
  }

  void _chooseLanguage(BuildContext context, String language) {
    final authCubit = context.read<AuthCubit>();
    final cartCubit = context.read<CartCubit>();
    var languageIsSame =
        (context.locale == const Locale('en') && language == 'en') ||
            ((context.locale == const Locale('ar') && language == 'ar'));
    if (languageIsSame)
      return showSnackBar(context, message: 'already_selected_lang');

    EasyLocalization.of(context)!
        .setLocale(Locale(language))
        .then((value) async {
      await authCubit.changeUserLanguage().then((value) => cartCubit.refresh());
    });
  }
}
