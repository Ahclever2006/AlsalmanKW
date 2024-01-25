import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../api_end_point.dart';
import '../../../../core/data/models/banner_model.dart';
import '../../../../core/utils/media_query_values.dart';
import '../../../../core/utils/navigator_helper.dart';
import '../../../../shared_widgets/stateful/gif_widget.dart';
import '../../../../shared_widgets/stateless/custom_cached_network_image.dart';
import '../../../../shared_widgets/stateless/inner_appbar.dart';
import '../../../category_products/presentation/pages/category_products_page.dart';
import '../blocs/cubit/categories_cubit.dart';
import '../../../../shared_widgets/stateless/category_card.dart';
import '../../../../core/data/models/home_categ_model.dart';

import '../../../../shared_widgets/stateless/empty_page_message.dart';
import '/di/injector.dart';
import '/shared_widgets/other/show_snack_bar.dart';
import '/shared_widgets/stateless/custom_app_page.dart';
import '/shared_widgets/stateless/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesPage extends StatefulWidget {
  static const routeName = '/CategoriesPage';
  const CategoriesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    Widget child = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InnerPagesAppBar(
          label: 'categories'.tr().toUpperCase(),
        ),
        Expanded(
          child: BlocConsumer<CategoriesCubit, CategoriesState>(
            listener: (context, state) {
              if (state.isError)
                showSnackBar(context, message: state.errorMessage);
            },
            builder: (context, state) {
              if (state.isInitial || state.isLoading)
                return const CustomLoading(
                    loadingStyle: LoadingStyle.ShimmerList);

              if (state.categories != null)
                return _buildCategories(context,
                    categories: state.categories?.data ?? []);
              else
                return const SizedBox();
            },
          ),
        ),
      ],
    );

    return Scaffold(body: _buildBody(context, child));
  }

  Widget _buildBody(BuildContext context, Widget child) => BlocProvider(
        create: (_) => Injector().categoriesCubit..getCategoriesData(),
        child: CustomAppPage(
          safeTop: true,
          child: child,
        ),
      );

  Widget _buildCategories(
    BuildContext context, {
    required List<CategoryModel> categories,
  }) {
    final categoriesCubit = context.read<CategoriesCubit>();

    return categories.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHomeBanners(
                  context, categoriesCubit.state.categoriesBanners,
                  autoPlay: false),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => categoriesCubit.refresh(),
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1.0,
                            mainAxisSpacing: 15),
                    shrinkWrap: true,
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      final category = categories[index];
                      return CategoryCard(
                          onPress: () async {
                            categoriesCubit.selectCategoryId(category.id!);

                            _goToProductsPage(
                                context, category.id!, category.name!);
                          },
                          category: category,
                          size: context.width * 0.2);
                    },
                  ),
                ),
              ),
            ],
          )
        : EmptyPageMessage(
            title: 'no_categories_available',
            onRefresh: () => categoriesCubit.refresh(),
          );
  }

  void _goToProductsPage(
      BuildContext context, int categoryId, String categoryName) {
    NavigatorHelper.of(context).push(MaterialPageRoute(builder: (_) {
      return CategoryProductsPage(
        categoryName: categoryName,
        categoryId: categoryId,
      );
    }));
  }

  Widget _buildHomeBanners(BuildContext context, HomeBannerModel? banners,
      {bool? autoPlay}) {
    var width = context.width;
    if (banners == null || banners.data!.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: CarouselSlider.builder(
        options: CarouselOptions(
          // height: context.width / 2,
          aspectRatio: 16 / 9,
          viewportFraction: 1.0,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: isGif
          ? ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              child: FittedBox(
                fit: BoxFit.fill,
                child: GIFWidget(
                  gifUrl: '${ApiEndPoint.domainUrl}/$image',
                ),
              ),
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
    );
  }
}
