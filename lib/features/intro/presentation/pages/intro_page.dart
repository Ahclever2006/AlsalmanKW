import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/stateless/image_not_exist_place_holder.dart';
import '../../../../core/utils/media_query_values.dart';

import '../../../../api_end_point.dart';
import '../../../../core/data/models/banner_model.dart';
import '../../../../core/utils/navigator_helper.dart';
import '../../../../di/injector.dart';
import '../../../../shared_widgets/stateless/custom_cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import '../../../../shared_widgets/stateless/title_text.dart';
import '../../../layout/presentation/pages/main_layout_page.dart';
import '../cubit/intro_cubit.dart';
import '/shared_widgets/other/show_snack_bar.dart';
import '/shared_widgets/stateless/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntroPage extends StatefulWidget {
  static const routeName = '/IntroPage';
  const IntroPage({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  late CarouselController imageController;

  @override
  void initState() {
    imageController = CarouselController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppPage(
      safeTop: false,
      safeBottom: false,
      child: BlocProvider(
        create: (context) => Injector().introCubit..loadIntroData(),
        child: BlocConsumer<IntroCubit, IntroState>(
          listener: (context, state) {
            if (state.isError)
              showSnackBar(context, message: state.errorMessage);
          },
          builder: (context, state) {
            if (state.isInitial || state.isLoading)
              return const CustomLoading();

            return _buildIntroPageBody(
              context,
              banners: state.introBanners,
            );
          },
        ),
      ),
    );
  }

  Widget _buildIntroPageBody(
    BuildContext context, {
    HomeBannerModel? banners,
  }) {
    return Scaffold(
      body: Column(children: [
        SizedBox(height: context.height * 0.15),
        _buildIntroBanners(context, banners),
        SizedBox(height: context.height * 0.10),
        Expanded(child: _buildTextAndDots()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSkipBtn(context),
            _buildMoreBtn(context),
          ],
        )
      ]),
    );
  }

  Widget _buildSkipBtn(BuildContext context) => Align(
        alignment: Alignment.bottomLeft,
        child: InkWell(
          onTap: () => _goToHomePage(context),
          child: Container(
            margin:
                const EdgeInsets.only(bottom: 48.0, left: 16.0, right: 16.0),
            width: 100.0,
            height: 45.0,
            padding: const EdgeInsetsDirectional.all(8.0),
            child: const Center(
                child: TitleText(
              text: 'skip',
              color: AppColors.PRIMARY_COLOR,
            )),
          ),
        ),
      );

  Widget _buildMoreBtn(BuildContext context) => Align(
        alignment: Alignment.bottomRight,
        child: BlocBuilder<IntroCubit, IntroState>(
          builder: (context, state) {
            return InkWell(
              onTap: () {
                imageController.jumpToPage((state.introBannerIndex! + 1));
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.PRIMARY_COLOR,
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                margin: const EdgeInsets.only(
                    bottom: 48.0, left: 16.0, right: 16.0),
                width: 100.0,
                height: 45.0,
                padding: const EdgeInsetsDirectional.all(8.0),
                child: const Center(
                    child: TitleText(
                  text: 'more',
                  color: Colors.white,
                )),
              ),
            );
          },
        ),
      );

  Widget _buildIntroBanners(BuildContext context, HomeBannerModel? banners) {
    final cubit = context.read<IntroCubit>();
    var width = context.width * 0.80;
    var height = context.height * 0.5;
    if (banners == null || banners.data?.isNotEmpty == false)
      return const SizedBox();
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: height,
        viewportFraction: 1.0,
        onPageChanged: (index, reason) => cubit.autoChangedCarouselIndex(index),
        autoPlayInterval: const Duration(
          seconds: 10,
        ),
      ),
      carouselController: imageController,
      itemCount: banners.data?.length ?? 0,
      itemBuilder: (context, index, realIndex) {
        var banner = banners.data![index];
        final String? image = banner.fileUrl;
        return Align(
          alignment: Alignment.topCenter,
          child: _buildImage(context, width, height, image, banner.link),
        );
      },
    );
  }

  Widget _buildTextAndDots() {
    return BlocBuilder<IntroCubit, IntroState>(
      builder: (context, state) {
        if (state.introBanners == null ||
            state.introBanners?.data?.isNotEmpty == false)
          return const SizedBox();
        var banner = state.introBanners!.data![state.introBannerIndex ?? 0];
        final String text = banner.text ?? '';
        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: TitleText(
                    subtractedSize: -4,
                    text: text,
                    textAlign: TextAlign.center),
              ),
            ),
            AnimatedSmoothIndicator(
                activeIndex: state.introBannerIndex ?? 0,
                count: state.introBanners?.data?.length ?? 0,
                effect: const ColorTransitionEffect(
                  activeDotColor: AppColors.PRIMARY_COLOR_DARK,
                  spacing: 4.0,
                  dotColor: AppColors.GREY_NORMAL_COLOR,
                )),
          ],
        );
      },
    );
  }

  Widget _buildImage(BuildContext context, double width, double height,
      String? image, String? link) {
    return InkWell(
      onTap: () {},
      child: CustomCachedNetworkImage(
        imageUrl: '${ApiEndPoint.domainUrl}/$image',
        width: width,
        height: height,
        imageMode: ImageMode.Pad,
        fit: BoxFit.fill,
        placeholder: (_, __) => const ImageNotExistPlaceHolder(),
      ),
    );
  }

  void _goToHomePage(BuildContext context) {
    final cubit = context.read<IntroCubit>();

    cubit.setIsFirstLunch().whenComplete(() => NavigatorHelper.of(context)
        .pushReplacementNamed(MainLayOutPage.routeName));
  }
}
