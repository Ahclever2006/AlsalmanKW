import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/di/injector.dart';
import '/shared_widgets/other/show_snack_bar.dart';
import '/shared_widgets/stateless/custom_app_page.dart';
import '/shared_widgets/stateless/custom_loading.dart';
import '../../../../core/utils/navigator_helper.dart';
import '../../../../shared_widgets/stateless/empty_page_message.dart';
import '../../../../shared_widgets/stateless/inner_appbar.dart';
import '../../../brand_products/presentation/pages/brand_products_page.dart';
import '../../data/models/brand_model/brand_model.dart';
import '../blocs/cubit/brands_cubit.dart';
import 'alphabet_scroll_widget.dart';

class BrandsPage extends StatefulWidget {
  static const routeName = '/BrandsPage';
  const BrandsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<BrandsPage> createState() => _BrandsPageState();
}

class _BrandsPageState extends State<BrandsPage> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Scaffold(
      body: Column(
        children: [
          InnerPagesAppBar(
            label: 'brands'.tr().toUpperCase(),
            viewSearchIcon: true,
          ),
          Expanded(
            child: BlocConsumer<BrandsCubit, BrandsState>(
              listener: (context, state) {
                if (state.isError)
                  showSnackBar(context, message: state.errorMessage);
              },
              builder: (context, state) {
                if (state.isInitial || state.isLoading)
                  return const CustomLoading();

                if (state.brands != null)
                  return _buildBrandsList(context, brands: state.brands ?? []);
                else
                  return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );

    return BlocProvider(
      create: (_) => Injector().brandsCubit..getBrandsData(),
      child: CustomAppPage(
        safeTop: true,
        child: child,
      ),
    );
  }

  Widget _buildBrandsList(
    BuildContext context, {
    required List<BrandModel> brands,
  }) {
    final brandsCubit = context.read<BrandsCubit>();

    return brands.isNotEmpty
        ? AlphabetScrollPage(
            items: brands,
            onPress: (brand) {
              _goToBrandProductsPage(context, brand.id ?? 0, brand.name ?? '');
            })
        : EmptyPageMessage(
            title: 'no_brands_available',
            onRefresh: () => brandsCubit.refresh(),
          );
  }

  void _goToBrandProductsPage(
      BuildContext context, int brandId, String brandName) {
    NavigatorHelper.of(context).push(MaterialPageRoute(builder: (_) {
      return BrandProductsPage(
        brandId: brandId,
        brandName: brandName,
      );
    }));
  }
}
