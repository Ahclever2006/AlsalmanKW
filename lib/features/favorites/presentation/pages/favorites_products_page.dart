import 'package:alsalman_app/shared_widgets/other/show_remove_fav_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:size_helper/size_helper.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/stateful/default_button.dart';
import '../../../../shared_widgets/stateless/title_text.dart';
import '../../../cart_tab/presentation/cubit/cart_cubit.dart';

import '/di/injector.dart';
import '/shared_widgets/other/show_snack_bar.dart';
import '/shared_widgets/stateless/custom_app_page.dart';
import '/shared_widgets/stateless/custom_loading.dart';
import '../../../../core/utils/media_query_values.dart';
import '../../../../core/utils/navigator_helper.dart';
import '../../../../shared_widgets/stateless/empty_page_message.dart';
import '../../../../shared_widgets/stateless/inner_appbar.dart';
import '../../../../shared_widgets/stateless/product_card.dart';
import '../../../product_details/presentation/pages/product_details_page.dart';
import '../../data/models/favorite_product_model.dart';
import '../blocs/cubit/favorites_cubit.dart';

class FavoritesProductsPage extends StatefulWidget {
  static const routeName = '/FavoritesProductsPage';
  const FavoritesProductsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoritesProductsPage> createState() => _FavoritesProductsPageState();
}

class _FavoritesProductsPageState extends State<FavoritesProductsPage> {
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Injector().favoritesCubit..loadFavorites(),
      child: CustomAppPage(
        safeTop: true,
        child: Scaffold(
          body: Column(
            children: [
              InnerPagesAppBar(label: 'favorites'.tr().toUpperCase()),
              BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, state) {
                  if (state.isInitial || state.isLoading)
                    return const SizedBox();

                  return _buildRemoveAll(context,
                      count: state.favoritesList!.length);
                },
              ),
              BlocConsumer<FavoritesCubit, FavoritesState>(
                listener: (context, state) {
                  if (state.isError)
                    showSnackBar(context, message: state.errorMessage);
                },
                builder: (context, state) {
                  if (state.isInitial || state.isLoading)
                    return const Expanded(
                      child: CustomLoading(),
                    );

                  return _buildProductsList(context,
                      products: state.favoritesList!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductsList(
    BuildContext context, {
    required List<FavoriteProductModel>? products,
  }) {
    final cubit = context.read<FavoritesCubit>();
    final cartCubit = context.read<CartCubit>();
    var size = context.sizeHelper(
      tabletNormal: context.width * 0.40,
      tabletLarge: context.width * 0.40,
      desktopSmall: context.width * 0.48,
      mobileLarge: context.width * 0.40,
    );

    return products!.isNotEmpty
        ? LazyLoadScrollView(
            onEndOfPage: () => cubit.getMoreFavoritesProductsData(),
            isLoading: cubit.state.isLoadingMore,
            child: Expanded(
              child: RefreshIndicator(
                onRefresh: () => cubit.refresh(),
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  physics: const AlwaysScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: context.sizeHelper(
                      tabletNormal: 0.65,
                      tabletLarge: 0.70,
                      mobileLarge: 0.70,
                      desktopSmall: 0.85,
                    ),
                  ),
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = products[index];
                    return Stack(
                      children: [
                        ProductCard(
                            heroTag: 'fav${product.Id}',
                            key: ValueKey(product.Id),
                            name: product.Name ?? '',
                            price: product.productPrice?.price ?? '0',
                            oldPrice: product.productPrice?.oldPrice,
                            discount: product.DiscountPercentage ?? 0.0,
                            isOutOfStock: false,
                            isSubscribedBackInStock: false,
                            imageUrl:
                                product.DefaultPictureModel?.imageUrl ?? '',
                            onAddPress: () => cartCubit
                                    .addToCartFromCatalog(
                                        product.Id.toString(), 1)
                                    .then((value) {
                                  if (value)
                                    showSnackBar(context,
                                        message:
                                            'item_added_to_cart_successfully');
                                  else {
                                    _goToProductDetailsPage(context, product.Id,
                                        product.DefaultPictureModel?.imageUrl);
                                  }
                                }),
                            onPress: () => _goToProductDetailsPage(
                                context,
                                product.Id,
                                product.DefaultPictureModel?.imageUrl),
                            size: size),
                        PositionedDirectional(
                            top: 8.0,
                            end: 16.0,
                            child: InkWell(
                              onTap: () {
                                showRemoveFavDialog(context,
                                    label: 'are_you_sure',
                                    subtitle: 'fav_remove_subtitle',
                                    onPress: () async {
                                  await cubit
                                      .removeProductFromFav(
                                          product.Id.toString())
                                      .whenComplete(() =>
                                          NavigatorHelper.of(context).pop());
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(8.0),
                                padding: const EdgeInsets.all(6.0),
                                decoration: const BoxDecoration(
                                  color: AppColors.PRIMARY_COLOR_LIGHT,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
                                ),
                                child: SvgPicture.asset(
                                    'lib/res/assets/fav_icon.svg'),
                              ),
                            ))
                      ],
                    );
                  },
                ),
              ),
            ),
          )
        : EmptyPageMessage(
            heightRatio: 0.6,
            isSVG: false,
            title: 'no_fav_items_found',
            subTitle: "check_our_best",
            svgImage: 'fish_icon',
            onRefresh: cubit.refresh,
          );
  }

  Widget _buildRemoveAll(
    BuildContext context, {
    required int? count,
  }) {
    if (count == 0) return const SizedBox();
    final cubit = context.read<FavoritesCubit>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TitleText(text: 'remove_all_fav'),
          DefaultButton(
              padding: const EdgeInsets.all(12.0),
              backgroundColor: AppColors.SECONDARY_COLOR,
              labelStyle: Theme.of(context).textTheme.displayLarge!,
              icon: SvgPicture.asset('lib/res/assets/delete_icon.svg'),
              onPressed: () {
                showRemoveFavDialog(context,
                    label: 'are_you_sure',
                    subtitle: 'fav_remove_subtitle', onPress: () async {
                  await cubit
                      .removeAllFav()
                      .whenComplete(() => NavigatorHelper.of(context).pop());
                });
              })
        ],
      ),
    );
  }

  void _goToProductDetailsPage(
      BuildContext context, int? productId, String? image) async {
    final cubit = context.read<FavoritesCubit>();

    final result =
        await NavigatorHelper.of(context).push(MaterialPageRoute(builder: (_) {
      return ProductDetailsPage(
        productId: productId!,
        isFromFavPage: true,
        heroTag: 'fav$productId',
        image: image,
      );
    }));

    if (result == false) cubit.refresh();
  }
}
