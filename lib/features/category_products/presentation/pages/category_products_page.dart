import 'package:alsalman_app/core/enums/sort_type.dart';
import 'package:alsalman_app/shared_widgets/other/show_sort_and_filter_bottom_sheet.dart';
import 'package:alsalman_app/shared_widgets/stateless/title_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:size_helper/size_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/data/models/filter_attribute.dart';
import '../../../../core/data/models/id_name_model.dart';
import '../../../../core/data/models/price_range_model.dart';
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
  int? subCategoryId = -1;

  // int sortBy = 0;
  // List<int>? tagsList = [];
  // List<Map>? filterList = [];
  // PriceRangeModel? priceRangeSelectedData;

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
                  ),
                  Expanded(
                    child: LazyLoadScrollView(
                      onEndOfPage: () =>
                          categoryProductsCubit.getMoreCategoryProductsData(
                              categoryId:
                                  (subCategoryId != null && subCategoryId != -1)
                                      ? subCategoryId
                                      : widget.categoryId,
                              filterOption: state.filterList,
                              tags: state.tagsList,
                              sort: state.sortBy,
                              priceRangeData: state.selectedPriceRange),
                      isLoading: categoryProductsCubit.state.isLoadingMore,
                      child: RefreshIndicator(
                        onRefresh: () => categoryProductsCubit.refresh(
                            categoryId:
                                (subCategoryId != null && subCategoryId != -1)
                                    ? subCategoryId
                                    : widget.categoryId,
                            tags: state.tagsList,
                            sort: state.sortBy,
                            filterOption: state.filterList,
                            selectedPriceRange: state.selectedPriceRange),
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                          (state.tagsList?.isNotEmpty == true ||
                                              state.filterList?.isNotEmpty ==
                                                  true))
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const TitleText(
                                                text: 'products',
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 8.0,
                                                    horizontal: 16.0)),
                                            SortAndFilterButton(
                                              onSortPress: () {
                                                showSortAndFilterBottomSheet(
                                                  context,
                                                  label: 'sort_and_filter',
                                                  sortData: sortListData,
                                                  onClear: () async {
                                                    await cubit.getCategoryProductsData(
                                                        categoryId:
                                                            widget.categoryId,
                                                        sort: 0,
                                                        tags: [],
                                                        filterOption: [],
                                                        selectedPriceRange: cubit
                                                            .state
                                                            .priceRange);
                                                  },
                                                  onPress: (tags, attributes,
                                                      price, sort) async {
                                                    // sortBy = sort;
                                                    // filterList = attributes;
                                                    // tagsList = tags;
                                                    // priceRangeSelectedData =
                                                    //     price;
                                                    // cubit.setFilterData(
                                                    //     tags,
                                                    //     attributes,
                                                    //     price,
                                                    //     sort);
                                                    await cubit
                                                        .getCategoryProductsData(
                                                            categoryId: widget
                                                                .categoryId,
                                                            sort: sort,
                                                            tags: tags,
                                                            filterOption:
                                                                attributes,
                                                            selectedPriceRange:
                                                                price);
                                                  },
                                                  selectedSortMethod:
                                                      cubit.state.sortBy,
                                                  tagsData:
                                                      cubit.state.tagsData ??
                                                          [],
                                                  selectedTags:
                                                      cubit.state.tagsList ??
                                                          [],
                                                  selectedAttributes:
                                                      cubit.state.filterList ??
                                                          [],
                                                  filterData:
                                                      cubit.state.filterData ??
                                                          [],
                                                  priceRange:
                                                      cubit.state.priceRange,
                                                  selectedPriceRange: cubit
                                                      .state.selectedPriceRange,
                                                  //     onPress: (sort) async {
                                                  //   sortBy = sort;
                                                  //   await cubit
                                                  //       .getCategoryProductsData(
                                                  //     categoryId:
                                                  //         widget.categoryId,
                                                  //     sort: sort,
                                                  //     tags: tagsList,
                                                  //     filterOption: filterList,
                                                  //   );
                                                  // }
                                                );
                                              },
                                              // onFilterPress: () {
                                              //   showFilterBottomSheet(context,
                                              //       label: 'filter',
                                              //       tagsData:
                                              //           cubit.state.tagsData ??
                                              //               [],
                                              //       selectedTags: tagsList ?? [],
                                              //       selectedAttributes:
                                              //           filterList ?? [],
                                              //       filterData:
                                              //           cubit.state.filterData ??
                                              //               [],
                                              //       onPress: (tags, attributes) {
                                              //     filterList = attributes;
                                              //     return cubit
                                              //         .getCategoryProductsData(
                                              //             categoryId:
                                              //                 widget.categoryId,
                                              //             sort: sortBy,
                                              //             filterOption:
                                              //                 attributes,
                                              //             tags: tags);
                                              //   });
                                              //}
                                            ),
                                          ],
                                        )
                                      : const SizedBox();
                                },
                              ),
                              _buildFilteredItemsList(),
                              BlocConsumer<CategoryProductsCubit,
                                  CategoryProductsState>(
                                listener: (context, state) {
                                  if (state.isError)
                                    showSnackBar(context,
                                        message: state.errorMessage);
                                },
                                builder: (context, state) {
                                  if (state.isInitial || state.isLoading)
                                    return const CustomLoading();

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
          var state = cubit.state;
          cubit.getCategoryProductsData(
              categoryId: widget.categoryId,
              subCategoryId: id,
              sort: state.sortBy ?? 0,
              tags: state.tagsList,
              filterOption: state.filterList,
              selectedPriceRange: state.selectedPriceRange);
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
                tabletNormal: 0.70,
                tabletLarge: 0.75,
                mobileLarge: 0.75,
                desktopSmall: 0.80,
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
              filterOption: categoryProductsCubit.state.filterList,
              tags: categoryProductsCubit.state.tagsList,
            ),
          );
  }

  Widget _buildFilteredItemsList() =>
      BlocBuilder<CategoryProductsCubit, CategoryProductsState>(
          builder: (context, state) {
        final cubit = context.read<CategoryProductsCubit>();
        if (cubit.state.hasFilteredData)
          return SizedBox(
            height: 50,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16.0),
              scrollDirection: Axis.horizontal,
              children: [
                InkWell(
                    onTap: () async {
                      await cubit.getCategoryProductsData(
                          categoryId: widget.categoryId,
                          sort: 0,
                          tags: [],
                          filterOption: [],
                          selectedPriceRange: cubit.state.priceRange);
                    },
                    child: Row(
                      children: [
                        _buildClearData("clear_all"),
                        const SizedBox(
                          width: 6.0,
                        )
                      ],
                    )),
                _buildSelectedSort(sortListData, cubit.state.sortBy),
                _buildSelectedPrice(
                    cubit.state.selectedPriceRange, cubit.state.priceRange),
                _buildSelectedTagsList(
                    cubit.state.tagsList, cubit.state.tagsData),
                _buildSelectedAttributesList(
                    cubit.state.filterList, cubit.state.filterData)
              ],
            ),
          );
        return const SizedBox();
      });

  Widget _buildSelectedSort(List<SortType>? sortListData, int? sortBy) {
    if (sortBy != null && sortBy != 0) {
      final sortItem = sortListData!.cast<SortType?>().firstWhere(
          (element) => element?.value == sortBy,
          orElse: () => null);
      if (sortItem != null) {
        return Row(
          children: [
            _buildFilterContainer(sortItem.name),
            const SizedBox(
              width: 8.0,
            )
          ],
        );
      }
    }

    return const SizedBox();
  }

  Widget _buildSelectedPrice(PriceRangeModel? selectedPriceRangeModel,
      PriceRangeModel? priceRangeModel) {
    if (selectedPriceRangeModel != null &&
            priceRangeModel!.to > selectedPriceRangeModel.to ||
        priceRangeModel!.from < selectedPriceRangeModel!.from)
      return Row(
        children: [
          _buildFilterContainer(
              "${"price".tr()} ${selectedPriceRangeModel.from} - ${selectedPriceRangeModel.to}"),
          const SizedBox(
            width: 8.0,
          )
        ],
      );

    return const SizedBox();
  }

  Widget _buildSelectedTagsList(List<int>? tags, List<IdNameModel>? tagsData) {
    if (tags?.isNotEmpty == true && tagsData != null) {
      List<IdNameModel>? selectedList = [];

      for (var element in tagsData) {
        tags?.forEach((tag) {
          if (tag == element.id) {
            selectedList.add(element);
          }
        });
      }
      if (selectedList.isNotEmpty)
        return SizedBox(
          height: 45,
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) => i == selectedList.length
                  ? const SizedBox()
                  : _buildFilterContainer(selectedList[i].name),
              separatorBuilder: (context, i) => const SizedBox(
                    width: 6.0,
                  ),
              itemCount: selectedList.length + 1),
        );
    }

    return const SizedBox();
  }

  Widget _buildSelectedAttributesList(
      List<Map<dynamic, dynamic>>? selectedAttributes,
      List<FilterAttribute>? filterData) {
    if (selectedAttributes?.isNotEmpty == true && filterData != null) {
      List<FilterAttributeValue>? selectedList = [];

      selectedAttributes?.forEach((attr) {
        final attrItem = filterData.cast<FilterAttribute?>().firstWhere(
            (element) =>
                element?.specificationAttributeId ==
                attr["SpecificationAttributeId"],
            orElse: () => null);
        if (attrItem != null) {
          final specItem = attrItem.specificationAttributeOptions
              .cast<FilterAttributeValue?>()
              .firstWhere(
                  (element) =>
                      element?.id == attr["SpecificationAttributeOptionId"],
                  orElse: () => null);
          if (specItem != null) selectedList.add(specItem);
        }
      });

      if (selectedList.isNotEmpty)
        return SizedBox(
          height: 45,
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) => i == selectedList.length
                  ? const SizedBox()
                  : _buildFilterContainer(selectedList[i].name),
              separatorBuilder: (context, i) => const SizedBox(
                    width: 6.0,
                  ),
              itemCount: selectedList.length + 1),
        );
    }

    return const SizedBox();
  }

  Widget _buildClearData(String name) => Container(
        child: Center(
          child: Row(
            children: [
              TitleText.medium(
                text: name,
                color: AppColors.PRIMARY_COLOR_DARK,
              ),
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              22,
            ),
            color: AppColors.PRIMARY_COLOR_LIGHT,
            border: Border.all(color: AppColors.PRIMARY_COLOR_DARK)),
      );

  Widget _buildFilterContainer(String name) => Container(
        child: Center(
          child: Row(
            children: [
              TitleText.medium(
                text: name,
                color: AppColors.PRIMARY_COLOR_DARK,
              ),
              // const SizedBox(width: 16.0),
              // InkWell(
              //   onTap: () {},
              //   child: SvgPicture.asset(
              //     'lib/res/assets/cancel_options_icon.svg',
              //     color: AppColors.PRIMARY_COLOR_DARK,
              //     width: 18,
              //     height: 18,
              //   ),
            //  )
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              22,
            ),
            color: AppColors.PRIMARY_COLOR_LIGHT,
            border: Border.all(color: AppColors.PRIMARY_COLOR_DARK)),
      );

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
              sort: cubit.state.sortBy ?? 0,
              tags: cubit.state.tagsList,
              filterOption: cubit.state.filterList,
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
                  height: width / 2,
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
      margin: const EdgeInsets.only(left: 16.0, right: 16.0),
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
