import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../blocs/contact_us_cubit/contact_us_cubit.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/stateless/title_text.dart';

import '../../../../di/injector.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import '../../../../shared_widgets/stateless/inner_appbar.dart';

class ContactUsPage extends StatelessWidget {
  static const routeName = '/ContactUsPage';
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injector().contactUsCubit,
      child: CustomAppPage(
        safeTop: true,
        child: Scaffold(
          body: Column(
            children: [
              const InnerPagesAppBar(label: 'contact_us'),
              Expanded(child: _buildBody(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Builder(builder: (context) {
      final cubit = context.read<ContactUsCubit>();

      return ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildRowItem(
              label: 'customer_service',
              icon: 'customer_service_icon',
              onPress: cubit.startCustomerServiceCall),
          _buildRowItem(
              label: 'whats_app',
              icon: 'whatsapp_icon',
              onPress: cubit.startWhatsAppChat),
          _buildRowItem(
              label: 'instagram',
              icon: 'instagram_icon',
              onPress: cubit.openInstagramLink),
        ],
      );
    });
  }

  Widget _buildRowItem(
      {required String label,
      required String icon,
      required VoidCallback onPress}) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        padding: const EdgeInsets.all(24.0),
        decoration: const BoxDecoration(
          color: AppColors.PRIMARY_COLOR,
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        child: Row(
          children: [
            SvgPicture.asset('lib/res/assets/$icon.svg'),
            const SizedBox(width: 16.0),
            Expanded(
              child: TitleText(text: label, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
