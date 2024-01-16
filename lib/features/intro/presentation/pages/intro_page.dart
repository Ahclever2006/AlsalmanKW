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
  @override
  void initState() {
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
      body: Stack(children: [
        _buildIntroBanners(context, banners),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: IgnorePointer(
            child: Container(
              height: context.height / 2,
              width: context.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0, 0.4, 0.7, 1.0],
                  colors: <Color>[
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.37),
                    Colors.black.withOpacity(0.57),
                    AppColors.SECONDARY_COLOR,
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
            left: 16.0, right: 16.0, bottom: 100.0, child: _buildTextAndDots()),
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
        child: InkWell(
          onTap: () {},
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.PRIMARY_COLOR,
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            margin:
                const EdgeInsets.only(bottom: 48.0, left: 16.0, right: 16.0),
            width: 100.0,
            height: 45.0,
            padding: const EdgeInsetsDirectional.all(8.0),
            child: const Center(
                child: TitleText(
              text: 'more',
              color: Colors.white,
            )),
          ),
        ),
      );

  Widget _buildIntroBanners(BuildContext context, HomeBannerModel? banners) {
    final cubit = context.read<IntroCubit>();
    var width = context.width;
    var height = context.height;
    if (banners == null || banners.data?.isNotEmpty == false)
      return const SizedBox();
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: height,
        autoPlay: true,
        viewportFraction: 1.0,
        onPageChanged: (index, reason) => cubit.autoChangedCarouselIndex(index),
        autoPlayInterval: const Duration(
          seconds: 10,
        ),
      ),
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
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: context.width * 0.75,
                child: TitleText.large(text: text, color: Colors.white)),
            const SizedBox(height: 16.0),
            AnimatedSmoothIndicator(
                activeIndex: state.introBannerIndex ?? 0,
                count: state.introBanners?.data?.length ?? 0,
                effect: const ColorTransitionEffect(
                  activeDotColor: Colors.white,
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
