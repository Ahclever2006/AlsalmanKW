import 'package:flutter_svg/svg.dart';
import 'package:collection/collection.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import '../../../../shared_widgets/stateless/drawer_appbar.dart';
import '../../../../core/utils/media_query_values.dart';
import 'package:upgrader/upgrader.dart';
import '../../../../shared_widgets/stateful/gif_widget.dart';
import '../../../cart_tab/presentation/cubit/cart_cubit.dart';
import '../../../categories/presentation/pages/categories_page.dart';
import '../../../j_carousal_products/presentation/pages/j_carousal_products_page.dart';
import '../../../../shared_widgets/stateful/default_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:size_helper/size_helper.dart';
import '../../../../api_end_point.dart';
import '../../../../core/data/models/banner_model.dart';
import '../../../../core/data/models/home_categ_model.dart';
import '../../../../di/injector.dart';
import '../../../category_products/presentation/pages/category_products_page.dart';
import '../../../product_details/presentation/pages/product_details_page.dart';
import '../../../../shared_widgets/stateless/category_card.dart';
import '../../../../shared_widgets/stateless/custom_cached_network_image.dart';
import '../../../../shared_widgets/stateless/product_card.dart';
import '../../../../shared_widgets/stateless/title_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../core/data/models/home_carousal_collection_model.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import '../cubit/home_cubit.dart';
import '/core/utils/navigator_helper.dart';
import '/shared_widgets/other/show_snack_bar.dart';
import '/shared_widgets/stateless/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late final ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      upgrader: Upgrader(
          showIgnore: false,
          dialogStyle: UpgradeDialogStyle.cupertino,
          messages: UpgraderMessages(
              code: context.locale == const Locale('en') ? 'en' : 'ar'),
          showLater: false,
          durationUntilAlertAgain: const Duration(seconds: 1)),
      child: CustomAppPage(
        safeTop: true,
        child: BlocProvider(
          create: (context) => Injector().homeCubit..loadHomeData(),
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state.isError)
                showSnackBar(context, message: state.errorMessage);
            },
            builder: (context, state) {
              final cubit = context.read<HomeCubit>();

              if (state.isInitial || state.isLoading)
                return const CustomLoading(
                    loadingStyle: LoadingStyle.ShimmerList);

              return Column(
                children: [
                  DrawerAppBarWidget(
                      title: SvgPicture.asset('lib/res/assets/app_logo.svg',
                          width: 50.0)),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => cubit.refresh(),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        controller: _controller,
                        child: _buildHomeTabBody(
                          context,
                          categories: state.categories,
                          banners: state.banners,
                          categoriesBanners: state.categoriesBanners,
                          carousalSections: state.carousalSections,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHomeTabBody(
    BuildContext context, {
    HomePageCategoriesModel? categories,
    HomeBannerModel? banners,
    HomeBannerModel? categoriesBanners,
    JCarouselsModel? carousalSections,
  }) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: [
        _buildHomeBanners(context, banners),
        _buildHomeCategories(context, categories),
        _buildShadowDivider(),
        _buildHomeBanners(context, categoriesBanners, autoPlay: false),
        ..._buildHomeCarousalProductSections(context, carousalSections),
      ],
    );
  }

  Widget _buildShadowDivider() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: const BoxDecoration(
          color: Colors.white12, boxShadow: AppColors.SHADOW),
      height: 1.0,
    );
  }

  Widget _buildHomeCategories(
      BuildContext context, HomePageCategoriesModel? categories) {
    if (categories == null) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0, left: 8.0, right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCustomTitle(label: "explore_categories"),
              DefaultButton(
                  label: 'view_all'.tr(),
                  labelStyle: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: AppColors.PRIMARY_COLOR, height: 1.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  backgroundColor: AppColors.PRIMARY_COLOR_LIGHT,
                  borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                  borderColor: AppColors.PRIMARY_COLOR,
                  onPressed: () {
                    _goToCategoriesPage(context);
                  })
            ],
          ),
        ),
        SizedBox(
          //TODO: check responsive
          height: 145.0,
          child: ListView.builder(
            padding: const EdgeInsets.all(0.0),
            scrollDirection: Axis.horizontal,
            // shrinkWrap: true,
            itemCount: categories.data!.length,
            itemBuilder: (BuildContext context, int index) {
              final category = categories.data![index];
              return CategoryCard(
                  onPress: () {
                    _goToCategoryProductsPage(
                        context, category.id ?? 0, category.name ?? '');
                  },
                  category: category,
                  size: context.width / 5);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCustomTitle({required String label}) => Row(
        children: [
          Container(
            height: 20.0,
            width: 4.0,
            decoration: const BoxDecoration(
              color: AppColors.PRIMARY_COLOR,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.0), bottom: Radius.circular(20.0)),
            ),
          ),
          const SizedBox(width: 12.0),
          TitleText(text: label, color: AppColors.PRIMARY_COLOR_DARK),
        ],
      );

  void _goToCategoryProductsPage(
      BuildContext context, int categoryId, String categoryName) {
    NavigatorHelper.of(context).push(MaterialPageRoute(builder: (_) {
      return CategoryProductsPage(
        categoryId: categoryId,
        categoryName: categoryName,
      );
    }));
  }

  Widget _buildHomeBanners(BuildContext context, HomeBannerModel? banners,
      {bool? autoPlay}) {
    final cubit = context.read<HomeCubit>();
    var width = context.width;
    if (banners == null || banners.data!.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: CarouselSlider.builder(
        options: CarouselOptions(
          height: width / 2,
          autoPlay: autoPlay ?? !ZoomDrawer.of(context)!.isOpen(),
          viewportFraction: 1.0,
          onPageChanged: (index, reason) =>
              cubit.autoChangedCarouselIndex(index),
          autoPlayInterval: const Duration(
            seconds: 10,
          ),
        ),
        itemCount: banners.data?.length ?? 0,
        itemBuilder: (context, index, realIndex) {
          var banner = banners.data![index];
          final String? image = banner.fileUrl;
          final String? bannerType = banner.bannerType;
          final isGif = bannerType == "Gif";

          return _buildImage(context, width, image, banner.link, isGif);
        },
      ),
    );
  }

  Widget _buildImage(BuildContext context, double width, String? image,
      String? link, bool isGif) {
    final cubit = context.read<HomeCubit>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: () async {
          if (link != null) {
            if (link.contains('WebView'))
              await cubit.openLink(link.replaceAll('WebView:', ''));
            else if (link.contains('Category')) {
              _goToCategoryProductsPage(context,
                  int.parse(link.replaceAll('Category:', '')), 'category');
            }
          }
        },
        child: isGif
            ? GIFWidget(
                gifUrl: '${ApiEndPoint.domainUrl}/$image',
              )
            : CustomCachedNetworkImage(
                imageUrl: '${ApiEndPoint.domainUrl}/$image',
                width: double.infinity,
                urlHeight: 300,
                urlWidth: 600,
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                imageMode: ImageMode.Pad,
                scaleMode: ScaleMode.Both,
                fit: BoxFit.fill,
              ),
      ),
    );
  }

  List<Widget> _buildHomeCarousalProductSections(
      BuildContext context, JCarouselsModel? sections) {
    final cartCubit = context.read<CartCubit>();
    final homeCubit = context.read<HomeCubit>();
    if (sections == null) return const [SizedBox()];
    final length =
        sections.data!.where((e) => e.products?.isNotEmpty == true).length;
    final indexFactor = (length / 3).floor();

    return sections.data!
        .where((e) => e.products?.isNotEmpty == true)
        .mapIndexed((i, e) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 8.0),
                child: _buildCustomTitle(label: e.title ?? ''),
              )),
              DefaultButton(
                  label: 'view_all'.tr(),
                  labelStyle: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: AppColors.PRIMARY_COLOR, height: 1.0),
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  backgroundColor: AppColors.PRIMARY_COLOR_LIGHT,
                  borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                  borderColor: AppColors.PRIMARY_COLOR,
                  onPressed: () {
                    _goToJCarousalProductsPage(context, e.id, e.name ?? '');
                  })
            ],
          ),
          SizedBox(
            height: context.sizeHelper(
              tabletNormal: 240,
              desktopSmall: 350,
              mobileLarge: 260,
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: e.products!
                  .map((product) => ProductCard(
                        size: context.sizeHelper(
                          tabletNormal: 150,
                          desktopSmall: 200,
                          mobileLarge: 150,
                        ),
                        heroTag: '${product.id}${e.id}',
                        name: product.name ?? '',
                        price: product.productPrice?.price ?? '0',
                        oldPrice: product.productPrice?.oldPrice,
                        imageUrl: product.defaultPictureModel?.imageUrl ?? '',
                        discount: product.discountPercentage ?? 0.0,
                        isOutOfStock: product.isOutOfStock ?? false,
                        isSubscribedBackInStock:
                            product.isSubscribedToBackInStock ?? false,
                        onPress: () => _goToProductDetailsPage(
                            context,
                            product.id,
                            product.defaultPictureModel?.imageUrl,
                            e.id!),
                        notifyMePress: () async {
                          await cartCubit
                              .notifyMe(product.id!)
                              .whenComplete(() => homeCubit.refresh())
                              .whenComplete(() {
                            showSnackBar(context, message: 'success_subscribe');
                          });
                        },
                        onAddPress: () => cartCubit
                            .addToCartFromCatalog(product.id.toString(), 1)
                            .then((value) {
                          if (value)
                            showSnackBar(context,
                                message: 'item_added_to_cart_successfully');
                          else {
                            _goToProductDetailsPage(context, product.id,
                                product.defaultPictureModel?.imageUrl, e.id!);
                          }
                        }),
                      ))
                  .toList(),
            ),
          ),
          if ((i + 1) % indexFactor == 0)
            _buildHomeBanners(
                context,
                ((i + 1) / indexFactor == 1)
                    ? homeCubit.state.carouselFirstBanners
                    : ((i + 1) / indexFactor == 2)
                        ? homeCubit.state.carouselSecondBanners
                        : homeCubit.state.carouselThirdBanners,
                autoPlay: false)
        ],
      );
    }).toList();
  }

  void _goToProductDetailsPage(
      BuildContext context, int? productId, String? image, int sectionId) {
    NavigatorHelper.of(context).push(MaterialPageRoute(builder: (_) {
      return ProductDetailsPage(
        productId: productId!,
        heroTag: '$productId$sectionId',
        image: image,
      );
    }));
  }

  void _goToJCarousalProductsPage(
      BuildContext context, int? carousalId, String label) {
    NavigatorHelper.of(context).push(MaterialPageRoute(builder: (_) {
      return JCarousalProductsPage(
        carousalId: carousalId!,
        carousalName: label,
      );
    }));
  }

  void _goToCategoriesPage(BuildContext context) {
    NavigatorHelper.of(context).push(MaterialPageRoute(builder: (_) {
      return const CategoriesPage();
    }));
  }
}
