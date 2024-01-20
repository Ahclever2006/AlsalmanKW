import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:size_helper/size_helper.dart';
import '../../../../core/utils/media_query_values.dart';

import '../../../../core/data/models/home_carousal_collection_model.dart';

import '../../../../shared_widgets/stateful/scroll_up_button.dart';
import '../../../../shared_widgets/stateless/empty_page_message.dart';
import '../../../../shared_widgets/stateless/inner_appbar.dart';
import '../../../../shared_widgets/stateless/product_card.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../../cart_tab/presentation/cubit/cart_cubit.dart';
import '../../../product_details/presentation/pages/product_details_page.dart';
import '../blocs/cubit/j_carousal_products_cubit.dart';
import '/di/injector.dart';
import '/shared_widgets/other/show_snack_bar.dart';
import '/shared_widgets/stateless/custom_app_page.dart';
import '/shared_widgets/stateless/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JCarousalProductsPage extends StatefulWidget {
  static const routeName = '/JCarousalProductsPage';
  const JCarousalProductsPage({
    Key? key,
    required this.carousalId,
    required this.carousalName,
  }) : super(key: key);

  final int carousalId;
  final String carousalName;

  @override
  State<JCarousalProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<JCarousalProductsPage> {
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
              label: widget.carousalName.toUpperCase(),
              viewSearchIcon: true),
          Expanded(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                BlocConsumer<JCarousalProductsCubit, JCarousalProductsState>(
                  listener: (context, state) {
                    if (state.isError)
                      showSnackBar(context, message: state.errorMessage);
                  },
                  builder: (context, state) {
                    if (state.isInitial || state.isLoading)
                      return const CustomLoading(
                          loadingStyle: LoadingStyle.ShimmerList);

                    return _buildProductsList(context,
                        products: state.carousalSection?.data?.first.products!);
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
      create: (_) =>
          Injector().jCarousalProductsCubit..getProductsData(widget.carousalId),
      child: CustomAppPage(
        safeTop: true,
        child: child,
      ),
    );
  }

  Widget _buildProductsList(
    BuildContext context, {
    required List<Products>? products,
  }) {
    final jCarouselProductsCubit = context.read<JCarousalProductsCubit>();
    final cartCubit = context.read<CartCubit>();
    var size = context.sizeHelper(
      tabletNormal: context.width * 0.40,
      tabletLarge: context.width * 0.40,
      desktopSmall: context.width * 0.48,
      mobileLarge: context.width * 0.40,
    );

    return LazyLoadScrollView(
      onEndOfPage: () =>
          jCarouselProductsCubit.getMoreProductsData(widget.carousalId),
      isLoading: jCarouselProductsCubit.state.isLoadingMore,
      child: RefreshIndicator(
        onRefresh: () => jCarouselProductsCubit.refresh(widget.carousalId),
        child: products!.isNotEmpty
            ? SingleChildScrollView(
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
                        return BlocListener<CartCubit, CartState>(
                          listener: (context, state) async {
                            if (state.isError)
                              showSnackBar(context,
                                  message: state.errorMessage);
                            if (state.isNotifiedSuccess) {
                              showSnackBar(context,
                                  message: 'success_subscribe');
                              await jCarouselProductsCubit
                                  .refresh(widget.carousalId);
                            }
                          },
                          child: ProductCard(
                              heroTag: '${product.id}',
                              name: product.name ?? '',
                              price: product.productPrice?.price ?? '0',
                              oldPrice: product.productPrice?.oldPrice,
                              imageUrl:
                                  product.defaultPictureModel?.imageUrl ?? '',
                              discount: product.discountPercentage ?? 0.0,
                              isOutOfStock: product.isOutOfStock ?? false,
                              isSubscribedBackInStock:
                                  product.isSubscribedToBackInStock ?? false,
                              notifyMePress: () async {
                                await cartCubit.notifyMe(product.id!);
                              },
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
                                      _goToProductDetailsPage(
                                          context,
                                          product.id,
                                          product
                                              .defaultPictureModel?.imageUrl);
                                    }
                                  }),
                              size: size),
                        );
                      },
                    ),
                    _buildPaginationLoading(),
                  ],
                ),
              )
            : const SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: EmptyPageMessage(title: 'no_products_available'),
              ),
      ),
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

  Widget _buildPaginationLoading() {
    return Builder(
      builder: (context) {
        var state = context.watch<JCarousalProductsCubit>().state;
        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: (state.isLoadingMore)
              ? const CustomLoading(loadingStyle: LoadingStyle.Pagination)
              : const SizedBox(),
        );
      },
    );
  }
}
