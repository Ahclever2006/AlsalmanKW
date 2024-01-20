import 'package:alsalman_app/shared_widgets/stateless/title_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:size_helper/size_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '/di/injector.dart';
import '/shared_widgets/other/show_snack_bar.dart';
import '/shared_widgets/stateless/custom_app_page.dart';
import '/shared_widgets/stateless/custom_loading.dart';
import '../../../../api_end_point.dart';
import '../../../../core/data/models/brand_model.dart';
import '../../../../core/data/models/home_categ_model.dart';
import '../../../../core/data/models/home_section_product_model.dart';
import '../../../../core/utils/media_query_values.dart';
import '../../../../core/utils/navigator_helper.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/other/show_filter_bottom_sheet.dart';
import '../../../../shared_widgets/other/show_sort_bottom_sheet.dart';
import '../../../../shared_widgets/stateful/brands_filter.dart';
import '../../../../shared_widgets/stateful/scroll_up_button.dart';
import '../../../../shared_widgets/stateful/sub_categories_filter.dart';
import '../../../../shared_widgets/stateless/custom_cached_network_image.dart';
import '../../../../shared_widgets/stateless/empty_page_message.dart';
import '../../../../shared_widgets/stateless/inner_appbar.dart';
import '../../../../shared_widgets/stateless/product_card.dart';
import '../../../../shared_widgets/stateless/sort_and_filter_button.dart';
import '../../../cart_tab/presentation/cubit/cart_cubit.dart';
import '../../../product_details/presentation/pages/product_details_page.dart';
import '../blocs/cubit/category_products_cubit.dart';

class CategoryProductsPage extends StatefulWidget {
  static const routeName = '/CategoryProductsPage';
  const CategoryProductsPage({
    Key? key,
    this.categoryId,
    required this.categoryName,
  }) : super(key: key);

  final int? categoryId;
  final String categoryName;

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  late final ScrollController _scrollController;
  int sortBy = 0;
  int? subCategoryId = -1;
  List<int>? tagsList = [];
  List<Map>? filterList = [];

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
    Widget child = BlocProvider(
      create: (_) => Injector().categoryProductsCubit
        ..getCategoryProductsData(categoryId: widget.categoryId),
      child: BlocBuilder<CategoryProductsCubit, CategoryProductsState>(
        builder: (context, state) {
          final categoryProductsCubit = context.read<CategoryProductsCubit>();
          return Stack(
            children: [
              Column(
                children: [
                  InnerPagesAppBar(
                    label: widget.categoryName.toUpperCase(),
                    viewSearchIcon: true,
                  ),
                  Expanded(
                    child: LazyLoadScrollView(
                      onEndOfPage: () =>
                          categoryProductsCubit.getMoreCategoryProductsData(
                        categoryId:
                            (subCategoryId != null && subCategoryId != -1)
                                ? subCategoryId
                                : widget.categoryId,
                        filterOption: filterList,
                        tags: tagsList,
                        sort: sortBy,
                      ),
                      isLoading: categoryProductsCubit.state.isLoadingMore,
                      child: RefreshIndicator(
                        onRefresh: () => categoryProductsCubit.refresh(
                          categoryId:
                              (subCategoryId != null && subCategoryId != -1)
                                  ? subCategoryId
                                  : widget.categoryId,
                          tags: tagsList,
                          filterOption: filterList,
                        ),
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              _buildCategoryBanners(context),
                              const SizedBox(height: 8.0),
                              _buildSubCategoriesFilterSection(),
                              BlocBuilder<CategoryProductsCubit,
                                  CategoryProductsState>(
                                builder: (context, state) {
                                  if (state.brandsData != null &&
                                      state.brandsData!.isNotEmpty)
                                    return _buildBrands(
                                        context, state.brandsData!);
                                  else
                                    return const SizedBox();
                                },
                              ),
                              const SizedBox(height: 8.0),
                              BlocBuilder<CategoryProductsCubit,
                                  CategoryProductsState>(
                                builder: (context, state) {
                                  final cubit =
                                      context.read<CategoryProductsCubit>();

                                  return (state.categoryProductsData?.data
                                                  ?.products?.isNotEmpty ==
                                              true ||
                                          (tagsList?.isNotEmpty == true ||
                                              filterList?.isNotEmpty == true))
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const TitleText(
                                                text: 'products',
                                                color: AppColors
                                                    .PRIMARY_COLOR_DARK,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 8.0,
                                                    horizontal: 16.0)),
                                            SortAndFilterButton(
                                                onSortPress: () {
                                              showSortBottomSheet(context,
                                                  label: 'sort',
                                                  sortData: sortListData,
                                                  onPress: (sort) async {
                                                sortBy = sort;
                                                await cubit
                                                    .getCategoryProductsData(
                                                  categoryId: widget.categoryId,
                                                  sort: sort,
                                                  tags: tagsList,
                                                  filterOption: filterList,
                                                );
                                              });
                                            }, onFilterPress: () {
                                              showFilterBottomSheet(context,
                                                  label: 'filter',
                                                  tagsData:
                                                      cubit.state.tagsData ??
                                                          [],
                                                  selectedTags: tagsList ?? [],
                                                  selectedAttributes:
                                                      filterList ?? [],
                                                  filterData:
                                                      cubit.state.filterData ??
                                                          [],
                                                  onPress: (tags, attributes) {
                                                filterList = attributes;
                                                return cubit
                                                    .getCategoryProductsData(
                                                        categoryId:
                                                            widget.categoryId,
                                                        sort: sortBy,
                                                        filterOption:
                                                            attributes,
                                                        tags: tags);
                                              });
                                            }),
                                          ],
                                        )
                                      : const SizedBox();
                                },
                              ),
                              BlocConsumer<CategoryProductsCubit,
                                  CategoryProductsState>(
                                listener: (context, state) {
                                  if (state.isError)
                                    showSnackBar(context,
                                        message: state.errorMessage);
                                },
                                builder: (context, state) {
                                  if (state.isInitial || state.isLoading)
                                    return const CustomLoading(
                                        loadingStyle: LoadingStyle.ShimmerList);

                                  if (state.categoryProductsData != null)
                                    return _buildBody(
                                      context,
                                      categoryProducts:
                                          state.categoryProductsData!,
                                    );
                                  else
                                    return const SizedBox();
                                },
                              ),
                              _buildPaginationLoading(),
                              const SizedBox(height: 16.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                  top: context.height * 0.1,
                  left: context.width * 0.2,
                  right: context.width * 0.2,
                  child: ScrollUpButton(scrollController: _scrollController))
            ],
          );
        },
      ),
    );

    child = Scaffold(
      body: child,
    );

    return CustomAppPage(
      safeTop: true,
      child: child,
    );
  }

  Widget _buildSubCategoriesFilterSection() {
    return BlocBuilder<CategoryProductsCubit, CategoryProductsState>(
      builder: (context, state) {
        if (state.subCategories?.data != null &&
            state.subCategories!.data!.isNotEmpty)
          return _buildSubCategories(context, state.subCategories!.data!);
        else
          return const SizedBox();
      },
    );
  }

  Widget _buildSubCategories(
      BuildContext context, List<CategoryModel> categoryBrands) {
    final cubit = context.read<CategoryProductsCubit>();

    List<CategoryModel> subCategories = [
      CategoryModel(id: -1, name: 'all'.tr())
    ];

    subCategories.addAll(categoryBrands);

    return SubCategoriesFilter(
        padding: 16.0,
        subCategories: subCategories,
        onPress: (id) {
          subCategoryId = id;
          cubit.getCategoryProductsData(
            categoryId: widget.categoryId,
            subCategoryId: id,
            sort: sortBy,
            tags: tagsList,
            filterOption: filterList,
          );
        });
  }

  Widget _buildBody(BuildContext context,
      {required HomeSectionProductModel categoryProducts}) {
    final categoryProductsCubit = context.read<CategoryProductsCubit>();
    final cartCubit = context.read<CartCubit>();
    var size = context.sizeHelper(
      tabletNormal: context.width * 0.40,
      tabletLarge: context.width * 0.40,
      desktopSmall: context.width * 0.48,
      mobileLarge: context.width * 0.40,
    );

    var products = categoryProducts.data!.products;

    return products!.isNotEmpty
        ? GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                listener: (context, state) {
                  if (state.isNotifiedSuccess) {
                    showSnackBar(context, message: 'success_subscribe');
                    categoryProductsCubit.updateProductNotifyStatus();
                  }

                  if (state.isError)
                    showSnackBar(context, message: state.errorMessage);
                },
                child: ProductCard(
                    key: ValueKey(product.isSubscribedToBackInStock.toString()),
                    heroTag: '${product.id}',
                    name: product.name ?? '',
                    brand: product.productManufacturers?.isNotEmpty == true
                        ? product.productManufacturers?.first.name
                        : null,
                    price: product.productPrice?.price ?? '0',
                    oldPrice: product.productPrice?.oldPrice,
                    discount: product.discountPercentage ?? 0,
                    isOutOfStock: product.isOutOfStock ?? false,
                    isSubscribedBackInStock:
                        product.isSubscribedToBackInStock ?? false,
                    imageUrl: product.defaultPictureModel?.imageUrl ?? '',
                    notifyMePress: () async {
                      categoryProductsCubit.notifyProductIndex(index);
                      await cartCubit.notifyMe(product.id!);
                    },
                    onPress: () => _goToProductDetailsPage(context, product.id,
                        product.defaultPictureModel?.imageUrl),
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
                    size: size),
              );
            },
          )
        : EmptyPageMessage(
            title: 'no_products_available',
            heightRatio: 0.6,
            onRefresh: () => categoryProductsCubit.refresh(
              categoryId: (subCategoryId != null && subCategoryId != -1)
                  ? subCategoryId
                  : widget.categoryId,
              filterOption: filterList,
              tags: tagsList,
            ),
          );
  }

  Widget _buildBrands(
      BuildContext context, List<CategoryBrandModel> categoryBrands) {
    final cubit = context.read<CategoryProductsCubit>();

    List<CategoryBrandModel> brands = [
      CategoryBrandModel(
          id: -1, name: 'all'.tr(), description: '', displayOrder: 0)
    ];

    brands.addAll(categoryBrands);

    return BrandsFilter(
        brands: brands,
        onPress: (id) => cubit.getCategoryProductsData(
              categoryId: widget.categoryId,
              brandId: id,
              sort: sortBy,
              tags: tagsList,
              filterOption: filterList,
            ));
  }

  Widget _buildPaginationLoading() {
    return Builder(
      builder: (context) {
        var state = context.watch<CategoryProductsCubit>().state;
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

  Widget _buildCategoryBanners(BuildContext context) {
    return BlocBuilder<CategoryProductsCubit, CategoryProductsState>(
      buildWhen: (previous, current) =>
          previous.categoryBanners != current.categoryBanners,
      builder: (context, state) {
        final cubit = context.read<CategoryProductsCubit>();
        var width = context.width;
        final banners = cubit.state.categoryBanners;
        if (state.categoryBanners?.data?.isNotEmpty == true)
          return Column(
            children: [
              CarouselSlider.builder(
                options: CarouselOptions(
                  height: width * 0.6,
                  autoPlay: true,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    cubit.autoChangedCarouselIndex(index);
                  },
                  autoPlayInterval: const Duration(
                    seconds: 5,
                  ),
                ),
                itemCount: banners?.data?.length ?? 0,
                itemBuilder: (context, index, realIndex) {
                  final String? image =
                      banners!.data![cubit.state.categoryBannerIndex!].fileUrl;
                  return _buildImage(width, image);
                },
              ),
              _buildDots(
                  cubit.state.categoryBannerIndex!, banners?.data?.length ?? 0),
            ],
          );
        else
          return const SizedBox();
      },
    );
  }

  Widget _buildDots(int index, int length) {
    return AnimatedSmoothIndicator(
        activeIndex: index,
        count: length,
        effect: const JumpingDotEffect(
          verticalOffset: 16,
          dotWidth: 16,
          dotHeight: 16,
          activeDotColor: AppColors.PRIMARY_COLOR_DARK,
          spacing: 12.0,
          dotColor: AppColors.PRIMARY_COLOR_LIGHT,
        ));
  }

  Widget _buildImage(double width, String? image) {
    return Container(
      margin: const EdgeInsets.only(top: 32.0, left: 16.0, right: 16.0),
      width: width,
      decoration: BoxDecoration(
        color: AppColors.GREY_LIGHT_COLOR,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CustomCachedNetworkImage(
          imageUrl: '${ApiEndPoint.domainUrl}/$image',
          urlHeight: 200,
          urlWidth: 200,
          imageMode: ImageMode.Pad,
          scaleMode: ScaleMode.Both,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
