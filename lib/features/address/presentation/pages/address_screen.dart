import 'package:flutter_svg/svg.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/stateful/default_button.dart';

import '../../../../shared_widgets/stateless/empty_page_message.dart';
import '../../../../shared_widgets/stateless/inner_appbar.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../data/models/addresses_model.dart';
import '../blocs/address_cubit/address_cubit.dart';
import '../widgets/address_item_widget.dart';
import '/shared_widgets/other/show_snack_bar.dart';
import '/shared_widgets/stateless/custom_app_page.dart';
import '/shared_widgets/stateless/custom_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_address_screen.dart';

class AddressesScreen extends StatefulWidget {
  static const routeName = '/AddressesScreen';
  const AddressesScreen({Key? key}) : super(key: key);

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomAppPage(
      safeTop: true,
      stackChildren: [
        Positioned(
            bottom: 32.0,
            left: 48.0,
            right: 48.0,
            child: Material(
                type: MaterialType.transparency,
                child: DefaultButton(
                    label: 'add_address'.tr(),
                    icon: const Icon(Icons.add,
                        color: AppColors.PRIMARY_COLOR_DARK),
                    backgroundColor: AppColors.PRIMARY_COLOR_LIGHT,
                    labelStyle: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(color: AppColors.PRIMARY_COLOR_DARK),
                    onPressed: () => _goToAddAddress(context))))
      ],
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InnerPagesAppBar(
              label: 'addresses'.tr().toUpperCase(),
            ),
            BlocConsumer<AddressCubit, AddressState>(
              listener: (context, state) {
                if (state is AddressStateError)
                  showSnackBar(context, message: state.message);
              },
              builder: (context, state) {
                if (state is AddressInitial ||
                    (state is AddressStateLoading &&
                        state.addressModel == null))
                  return const Expanded(
                    child: CustomLoading(),
                  );

                return _buildAddresses(context,
                    addressModel: state.addressModel);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _goToAddAddress(BuildContext context) async {
    final result =
        await NavigatorHelper.of(context).pushNamed(AddAddressPage.routeName);

    if (result == true) {
      Future.delayed(const Duration(milliseconds: 200), () {
        final addressCubit = context.read<AddressCubit>();
        addressCubit.refreshAddresses();
      });
    }
  }

  Widget _buildAddresses(
    BuildContext context, {
    required AddressesModel? addressModel,
  }) {
    final addressCubit = context.read<AddressCubit>();

    return Expanded(
      child: RefreshIndicator(
        onRefresh: () => addressCubit.refreshAddresses(),
        child: addressModel!.addresses!.isNotEmpty
            ? ListView.separated(
                itemCount: addressModel.addresses!.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 16);
                },
                itemBuilder: (BuildContext context, int index) {
                  return AddressItemWidget(
                    address: addressModel.addresses![index],
                    backgroundColor: AppColors.PRIMARY_COLOR_LIGHT,
                    onPress: () async {
                      final result = await NavigatorHelper.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        var address = addressModel.addresses![index];
                        return AddAddressPage(
                          isEdit: true,
                          addressId: address.id,
                        );
                      }));

                      if (result == true) addressCubit.refreshAddresses();
                    },
                  );
                },
              )
            : SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child:
                    EmptyPageMessage(title: '${'no'.tr()} ${'addresses'.tr()}'),
              ),
      ),
    );
  }
}
