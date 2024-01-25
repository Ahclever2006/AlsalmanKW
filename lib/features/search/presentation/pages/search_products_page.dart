import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:size_helper/size_helper.dart';
import '../../../cart_tab/presentation/cubit/cart_cubit.dart';
import '../../../../shared_widgets/stateless/inner_appbar.dart';
import '/di/injector.dart';
import '/shared_widgets/other/show_snack_bar.dart';
import '/shared_widgets/stateless/custom_app_page.dart';
import '/shared_widgets/stateless/custom_loading.dart';
import '../../../../core/utils/media_query_values.dart';
import '../../../../core/utils/navigator_helper.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../res/style/theme.dart';
import '../../../../shared_widgets/stateless/empty_page_message.dart';
import '../../../../shared_widgets/stateless/product_card.dart';
import '../../../../shared_widgets/text_fields/search_text_form_field.dart';
import '../../../product_details/presentation/pages/product_details_page.dart';
import '../blocs/home_search_bloc/search_bloc.dart';

class SearchProductsPage extends StatefulWidget {
  static const routeName = '/SearchProductsPage';
  final bool fromDrawer;
  const SearchProductsPage({
    Key? key,
    this.fromDrawer = false,
  }) : super(key: key);

  @override
  State<SearchProductsPage> createState() => _SearchProductsPageState();
}

class _SearchProductsPageState extends State<SearchProductsPage> {
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
    Future.delayed(const Duration(milliseconds: 200), () {
      FocusScope.of(context).requestFocus(_searchFocusNode);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => Injector().searchBloc
          ..add(const SearchEvent(
            status: SearchEventStatus.initial,
          )),
        child: widget.fromDrawer
            ? _buildBody()
            : Scaffold(
                body: _buildBody(),
              ));
  }

  Widget _buildBody() => CustomAppPage(
        safeTop: true,
        child: Column(
          children: [
            InnerPagesAppBar(label: 'search'.tr().toUpperCase()),
            Builder(builder: (context) {
              return _buildSearchTextFormField(context);
            }),
            Expanded(child: _buildProductsList(context)),
          ],
        ),
      );

  Widget _buildProductsList(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state.isError) showSnackBar(context, message: state.errorMessage);
      },
      builder: (context, state) {
        final bloc = context.read<SearchBloc>();
        final cartCubit = context.read<CartCubit>();
        var size = context.sizeHelper(
          tabletNormal: context.width * 0.40,
          tabletLarge: context.width * 0.40,
          desktopSmall: context.width * 0.48,
          mobileLarge: context.width * 0.40,
        );

        if (state.isInitial) return const SizedBox();

        if (state.isLoading)
          return const CustomLoading(loadingStyle: LoadingStyle.ShimmerGrid);

        if (state.products?.data?.products?.isNotEmpty != true)
          return const EmptyPageMessage(
            title: 'no_search_results_found',
            subTitle: "no_search_results_found_subtitle",
            svgImage: 'water_glass_icon',
            isSVG: false,
            textColor: AppColors.PRIMARY_COLOR_DARK,
          );

        var products = state.products!.data!.products;
        return LazyLoadScrollView(
          onEndOfPage: () => bloc.add(SearchEvent(
            status: SearchEventStatus.loadMore,
            searchText: _searchController.text,
          )),
          isLoading: state.isLoadingMore,
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  physics: const AlwaysScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: context.sizeHelper(
                      tabletNormal: 0.70,
                      tabletLarge: 0.75,
                      mobileLarge: 0.75,
                      desktopSmall: 0.80,
                    ),
                  ),
                  itemCount: products!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = products[index];
                    return ProductCard(
                        heroTag: 'search${product.id}',
                        key: ValueKey(product.id),
                        name: product.name ?? '',
                        price: product.productPrice?.price ?? '0',
                        oldPrice: product.productPrice?.oldPrice,
                        discount: product.discountPercentage ?? 0.0,
                        isOutOfStock: false,
                        isSubscribedBackInStock: false,
                        imageUrl: product.defaultPictureModel?.imageUrl ?? '',
                        onPress: () => _goToProductDetailsPage(context,
                            product.id, product.defaultPictureModel?.imageUrl),
                        onAddPress: () => cartCubit
                                .addToCartFromCatalog(product.id.toString(), 1)
                                .then((value) {
                              if (value)
                                showSnackBar(context,
                                    message: 'item_added_to_cart_successfully');
                              else {
                                _goToProductDetailsPage(context, product.id,
                                    product.defaultPictureModel?.imageUrl);
                              }
                            }),
                        size: size);
                  },
                ),
              ),
              _buildPaginationLoading(),
              const SizedBox(height: navbarHeight * 0.6)
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchTextFormField(BuildContext context) {
    final fontSize = context.sizeHelper(tabletLarge: 16.0, desktopSmall: 24.0);
    final bloc = context.read<SearchBloc>();
    return SearchTextFormField(
      currentFocusNode: _searchFocusNode,
      currentController: _searchController,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      borderColor: AppColors.PRIMARY_COLOR_DARK,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(fontSize: fontSize, color: AppColors.PRIMARY_COLOR_DARK),
      onChanged: (text) {
        bloc.add(SearchEvent(
          status: SearchEventStatus.search,
          searchText: text,
        ));
      },
    );
  }

  Widget _buildPaginationLoading() {
    return Builder(
      builder: (context) => AnimatedSize(
        duration: const Duration(milliseconds: 300),
        child: context.watch<SearchBloc>().state.isLoadingMore
            ? const CustomLoading(
                loadingStyle: LoadingStyle.Pagination,
                color: AppColors.PRIMARY_COLOR_DARK,
              )
            : const SizedBox(),
      ),
    );
  }

  void _goToProductDetailsPage(
      BuildContext context, int? productId, String? image) {
    NavigatorHelper.of(context).push(MaterialPageRoute(builder: (_) {
      return ProductDetailsPage(
        productId: productId!,
        heroTag: 'fav$productId',
        image: image,
      );
    }));
  }
}
