import '../../../../shared_widgets/stateless/drawer_appbar.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../../../../core/utils/media_query_values.dart';
import '../../../../di/injector.dart';
import 'profile_page.dart';
import '../../../auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/stateful/default_button.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import '../../../../shared_widgets/stateless/subtitle_text.dart';
import '../../../../shared_widgets/stateless/title_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/navigator_helper.dart';

class AccountTab extends StatelessWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final isLoggedIn = authCubit.state.isUserLoggedIn;
    if (isLoggedIn) {
      final authCubit = context.read<AuthCubit>();
      authCubit.getUserData();
    }

    return CustomAppPage(
      child: BlocProvider(
        create: (context) => Injector().accountCubit,
        child: ListView(
          children: [
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (!state.isUserLoggedIn || state.userInfo == null) {
                  return const SizedBox();
                } else {
                  return _buildNormalUserSection(
                      context,
                      state.userInfo?.data?.firstName,
                      state.userInfo?.data?.email);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNormalUserSection(
      BuildContext context, String? username, String? phone) {
    return Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.PRIMARY_COLOR_DARK),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TitleText(
                      text: 'welcome'.tr(args: [username ?? 'user_name'.tr()]),
                      maxLines: 2),
                  const SizedBox(height: 12.0),
                  SubtitleText(text: phone ?? 'Unknown'),
                ],
              ),
            ),
            InkWell(
                onTap: () => _goToProfilePage(context),
                child: Icon(
                  Icons.chevron_right,
                  color: username == null
                      ? Colors.red
                      : AppColors.PRIMARY_COLOR_DARK,
                )),
          ],
        ));
  }

  void _goToProfilePage(BuildContext context) {
    NavigatorHelper.of(context).pushNamed(ProfilePage.routeName);
  }
}
