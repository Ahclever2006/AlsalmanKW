import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:size_helper/size_helper.dart';
import '../../../cart_tab/presentation/cubit/cart_cubit.dart';

import '/di/injector.dart';
import '/shared_widgets/other/show_snack_bar.dart';
import '/shared_widgets/stateless/custom_app_page.dart';
import '/shared_widgets/stateless/custom_loading.dart';
import '../../../../core/data/models/home_section_product_model.dart';
import '../../../../core/utils/media_query_values.dart';
import '../../../../core/utils/navigator_helper.dart';
import '../../../../res/style/theme.dart';
import '../../../../shared_widgets/stateful/scroll_up_button.dart';
import '../../../../shared_widgets/stateless/empty_page_message.dart';
import '../../../../shared_widgets/stateless/inner_appbar.dart';
import '../../../../shared_widgets/stateless/product_card.dart';
import '../../../product_details/presentation/pages/product_details_page.dart';
import '../blocs/cubit/brand_products_cubit.dart';

class BrandProductsPage extends StatefulWidget {
  static const routeName = '/BrandProductsPage';
  const BrandProductsPage({
    Key? key,
    required this.brandId,
    required this.brandName,
  }) : super(key: key);

  final int brandId;
  final String brandName;

  @override
  State<BrandProductsPage> createState() => _BrandProductsPageState();
}

class _BrandProductsPageState extends State<BrandProductsPage> {
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
            label: widget.brandName.toUpperCase(),
            viewCartIcon: true,
            viewSearchIcon: true,
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                BlocConsumer<BrandProductsCubit, BrandProductsState>(
                  listener: (context, state) {
                    if (state.isError)
                      showSnackBar(context, message: state.errorMessage);
                  },
                  builder: (context, state) {
                    if (state.isInitial || state.isLoading)
                      return const CustomLoading(
                          loadingStyle: LoadingStyle.ShimmerList);

                    if (state.categoryProductsData != null)
                      return _buildCategoryProductsList(context,
                          categoryProducts: state.categoryProductsData!);
                    else
                      return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: ScrollUpButton(scrollController: _scrollController),
    );

    return BlocProvider(
      create: (_) => Injector().brandProductsCubit
        ..getBrandProductsData(brandId: widget.brandId),
      child: CustomAppPage(
        safeTop: true,
        child: child,
      ),
    );
  }

  Widget _buildCategoryProductsList(
    BuildContext context, {
    required HomeSectionProductModel categoryProducts,
  }) {
    final brandProductsCubit = context.read<BrandProductsCubit>();
    final cartCubit = context.read<CartCubit>();
    var size = context.sizeHelper(
      tabletNormal: context.width * 0.40,
      tabletLarge: context.width * 0.40,
      desktopSmall: context.width * 0.48,
      mobileLarge: context.width * 0.40,
    );

    var products = categoryProducts.data!.products;
    return products!.isNotEmpty
        ? LazyLoadScrollView(
            onEndOfPage: () => brandProductsCubit.getMoreCategoryProductsData(
                brandId: widget.brandId),
            isLoading: brandProductsCubit.state.isLoadingMore,
            child: RefreshIndicator(
              onRefresh: () => brandProductsCubit.refresh(
                brandId: widget.brandId,
              ),
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    GridView.builder(
                      padding: const EdgeInsets.all(16.0),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: context.sizeHelper(
                          tabletNormal: 0.65,
                          tabletLarge: 0.70,
                          mobileLarge: 0.70,
                          desktopSmall: 0.85,
                        ),
                      ),
                      shrinkWrap: true,
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        final product = products[index];
                        return ProductCard(
                            heroTag: '${product.id}',
                            name: product.name ?? '',
                            price: product.productPrice?.price ?? '0',
                            oldPrice: product.productPrice?.oldPrice,
                            discount: product.discountPercentage ?? 0,
                            isOutOfStock: product.isOutOfStock ?? false,
                            isSubscribedBackInStock:
                                product.isSubscribedToBackInStock ?? false,
                            imageUrl:
                                product.defaultPictureModel?.imageUrl ?? '',
                            onPress: () => _goToProductDetailsPage(
                                context,
                                product.id,
                                product.defaultPictureModel?.imageUrl),
                            onAddPress: () => cartCubit
                                    .addToCartFromCatalog(
                                        product.id.toString(), 1)
                                    .then((value) {
                                  if (value)
                                    showSnackBar(context,
                                        message:
                                            'item_added_to_cart_successfully');
                                  else {
                                    _goToProductDetailsPage(context, product.id,
                                        product.defaultPictureModel?.imageUrl);
                                  }
                                }),
                            size: size);
                      },
                    ),
                    _buildPaginationLoading(),
                    const SizedBox(height: navbarHeight)
                  ],
                ),
              ),
            ),
          )
        : EmptyPageMessage(
            message: 'no_products_available',
            onRefresh: () =>
                brandProductsCubit.refresh(brandId: widget.brandId),
          );
  }

  Widget _buildPaginationLoading() {
    return Builder(
      builder: (context) {
        var state = context.watch<BrandProductsCubit>().state;
        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: (state.isLoadingMore)
              ? const CustomLoading(loadingStyle: LoadingStyle.Pagination)
              : const SizedBox(),
        );
      },
    );
  }

  void _goToProductDetailsPage(
      BuildContext context, int? productId, String? image) {
    NavigatorHelper.of(context).push(MaterialPageRoute(builder: (_) {
      return ProductDetailsPage(
        productId: productId!,
        heroTag: '$productId',
        image: image,
      );
    }));
  }
}
