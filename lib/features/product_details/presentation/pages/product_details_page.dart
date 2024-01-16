import '../../../../core/enums/text_size.dart';
import '../../../../shared_widgets/other/show_register_first_snack_bar.dart';

import '../../../../api_end_point.dart';
import '../../../../core/enums/text_position.dart';
import '../../../../core/utils/hex_color_helper.dart';
import '../../../../core/utils/media_query_values.dart';

import '../../../../shared_widgets/dialogs/image_interactive_dialog.dart';
import '../../../cart_tab/presentation/cubit/cart_cubit.dart';
import '../../../../shared_widgets/other/show_size_guide_bottom_sheet.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../../../core/utils/type_defs.dart';
import '../../../auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import '../../../../res/style/theme.dart';
import '../../../../shared_widgets/other/show_simple_bottom_sheet.dart';
import '../../../../shared_widgets/stateful/quantity_button.dart';
import '../../../../shared_widgets/stateless/title_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/stateful/default_button.dart';
import '../../../../shared_widgets/stateful/favorite_button.dart';

import '../../../../shared_widgets/stateful/share_button.dart';
import '../../../../shared_widgets/stateless/custom_cached_network_image.dart';
import '../../../../shared_widgets/stateless/product_card.dart';
import '../../../../shared_widgets/text_fields/default_text_form_field.dart';
import '../../data/model/product_details_model.dart';
import '../blocs/cubit/product_details_cubit.dart';
import '../widgets/attribute_list_widget.dart';
import '/di/injector.dart';
import '/shared_widgets/other/show_snack_bar.dart';
import '/shared_widgets/stateless/custom_app_page.dart';
import '/shared_widgets/stateless/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatefulWidget {
  static const routeName = '/ProductDetailsPage';
  const ProductDetailsPage({
    Key? key,
    required this.productId,
    this.image,
    this.heroTag,
    this.isFromFavPage = false,
  }) : super(key: key);

  final int productId;
  final bool isFromFavPage;
  final String? image;
  final String? heroTag;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool? isFav;
  late CarouselController imageController;
  @override
  void initState() {
    imageController = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final isLoggedIn = authCubit.state.isUserLoggedIn;
    return BlocProvider(
      create: (_) => Injector().productDetailsCubit
        ..getProductDetailsData(widget.productId)
        ..getProductDetailsConditionalAttributesData(widget.productId)
        ..getProductDetailsCombinationAttributesData(widget.productId),
      child: CustomAppPage(
        //safeTop: true,
        safeBottom: false,
        onWillPop: widget.isFromFavPage
            ? () async {
                NavigatorHelper.of(context).pop(isFav);
                return false;
              }
            : null,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
              builder: (context, state) {
            final productDetailsCubit = context.read<ProductDetailsCubit>();
            final vendorId =
                state.productDetailsData?.productDetailsModel?.vendorModel?.id;

            return SizedBox(
              height: context.height,
              child: Column(
                children: [
                  if (vendorId == 33 || vendorId == 35)
                    _buildImagesSection(isLoggedIn, vendorId == 35),
                  Expanded(
                    child: _buildWholeBodySection(
                        productDetailsCubit, vendorId, isLoggedIn, context),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildWholeBodySection(ProductDetailsCubit productDetailsCubit,
      int? vendorId, bool isLoggedIn, BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => productDetailsCubit.refresh(widget.productId),
      child: Stack(
        fit: StackFit.expand,
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                if (vendorId != 33 && vendorId != 35)
                  _buildImagesSection(isLoggedIn, false),
                BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
                  listener: (context, state) {
                    const snackBarMargin =
                        EdgeInsets.fromLTRB(16, 16, 16, navbarHeight);
                    if (state.isError)
                      showSnackBar(context,
                          message: state.errorMessage, margin: snackBarMargin);

                    if (state.isProductFileUploaded)
                      showSnackBar(context,
                          message: 'file_uploaded_successfully',
                          margin: snackBarMargin);

                    if (state.isProductAddedToCart) {
                      showSnackBar(context,
                          message: 'item_added_to_cart_successfully',
                          margin: snackBarMargin);
                    }
                  },
                  builder: (context, state) {
                    if (state.isInitial ||
                        (state.isLoading && state.productDetailsData == null))
                      return const CustomLoading();
                    if (state.productDetailsData != null) {
                      return _buildBody(
                        context,
                        productDetails: state.productDetailsData!,
                        conditionalAttributes: state.showConditionalAttributes,
                        productPrice: state.productPrice ?? 0.0,
                        isLoggedIn: isLoggedIn,
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
          _buildAddToCartSection(context),
        ],
      ),
    );
  }

  Widget _buildImagesSection(bool isLoggedIn, bool showTextOnAllImages) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      buildWhen: (previous, current) =>
          (previous.productDetailsData != current.productDetailsData ||
              previous.bannerIndex != current.bannerIndex ||
              previous.imageId != current.imageId),
      builder: (context, state) {
        List<String>? images;

        if (widget.image != null) images = [widget.image!];
        if (!state.isInitial &&
            !state.isLoading &&
            state.productDetailsData != null) {
          isFav ??= state.productDetailsData!.productDetailsModel!.isFavorite!;
          var pictureModels =
              state.productDetailsData!.productDetailsModel!.pictureModels;
          images = pictureModels!.map((e) => e.imageUrl!).toList();
        }

        if (state.imageId != null) {
          int pageNumber = state
              .productDetailsData!.productDetailsModel!.pictureModels!
              .indexWhere((e) => e.id == state.imageId);
          imageController.jumpToPage(pageNumber);
        }
        int? textPosition;
        int? textSize;
        String? fontFamily;

        var productDetailsModelClass =
            state.productDetailsData?.productDetailsModel;
        if (productDetailsModelClass?.hasSpacialAttributes == true) {
          textPosition = productDetailsModelClass?.textPosition;
          textSize = productDetailsModelClass?.fontSize;
          fontFamily = productDetailsModelClass?.fontName;
        }

        double fontSize = textSize == TextSizeEnum.Small.index
            ? 14
            : textSize == TextSizeEnum.Medium.index
                ? 18
                : 24;

        var isTextVertical = [
          TextPositionEnum.TopVertical.index,
          TextPositionEnum.BottomVertical.index,
          TextPositionEnum.CenterVertical.index,
          TextPositionEnum.TopLeftVertical.index,
          TextPositionEnum.TopRightVertical.index,
          TextPositionEnum.BottomLeftVertical.index,
          TextPositionEnum.BottomRightVertical.index,
          TextPositionEnum.CenterRightVertical.index,
          TextPositionEnum.CenterLeftVertical.index,
        ].contains(textPosition);

        var isTextPositionTop = [
          TextPositionEnum.TopVertical.index,
          TextPositionEnum.TopHorizontal.index,
          TextPositionEnum.TopLeftHorizontal.index,
          TextPositionEnum.TopLeftVertical.index,
          TextPositionEnum.TopRightHorizontal.index,
          TextPositionEnum.TopRightVertical.index,
        ].contains(textPosition);

        var isTextPositionBottom = [
          TextPositionEnum.BottomHorizontal.index,
          TextPositionEnum.BottomLeftHorizontal.index,
          TextPositionEnum.BottomLeftVertical.index,
          TextPositionEnum.BottomRightHorizontal.index,
          TextPositionEnum.BottomRightVertical.index,
          TextPositionEnum.BottomVertical.index,
        ].contains(textPosition);

        var isTextPositionCenter = [
          TextPositionEnum.CenterHorizontal.index,
          TextPositionEnum.CenterLeftHorizontal.index,
          TextPositionEnum.CenterLeftVertical.index,
          TextPositionEnum.CenterRightHorizontal.index,
          TextPositionEnum.CenterRightVertical.index,
          TextPositionEnum.CenterVertical.index,
        ].contains(textPosition);

        var isTextPositionLeft = [
          TextPositionEnum.TopLeftHorizontal.index,
          TextPositionEnum.TopLeftVertical.index,
          TextPositionEnum.BottomLeftHorizontal.index,
          TextPositionEnum.BottomLeftVertical.index,
          TextPositionEnum.CenterLeftHorizontal.index,
          TextPositionEnum.CenterLeftVertical.index,
        ].contains(textPosition);

        var topPosition = textPosition != null
            ? isTextPositionTop
                ? context.toPadding / 2
                : context.width * 0.40
            : context.width * 0.33;

        var leftPosition = textPosition != null
            ? isTextPositionLeft
                ? context.width / 1.8
                : context.width / 2.5
            : context.width / 2.5;

        var rightPosition = textPosition != null
            ? isTextPositionLeft
                ? context.width / 3
                : context.width / 2.5
            : context.width / 2.5;

        return Stack(
          children: [
            _buildBanners(
                context,
                images,
                state.productDetailsData?.productDetailsModel?.pictureModels,
                isLoggedIn),
            if (state.bannerIndex == 0 || showTextOnAllImages)
              Positioned(
                top: topPosition,
                bottom: 0,
                left: leftPosition,
                right: rightPosition,
                child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                  builder: (context, state) {
                    var text = state.text;
                    var isDotsBetweenInitials =
                        state.isDotsBetweenInitials ?? false;
                    text = _addDotsBetweenInitialIfNeeded(
                        isDotsBetweenInitials, text);
                    var child = IgnorePointer(
                      child: Text(
                        text ?? '',
                        style: TextStyle(
                          fontFamily: state.fontFamily ??
                              getFontFamily(fontFamily ?? '') ??
                              'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: state.fontSize ?? fontSize,
                          color: state.textColor != null
                              ? HexColor(state.textColor!)
                              : Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );

                    return isTextVertical
                        ? Transform(
                            alignment: isTextPositionTop
                                ? Alignment.topRight
                                : isTextPositionCenter
                                    ? Alignment.topCenter
                                    : Alignment.center,
                            transform: Matrix4.rotationZ(-90 * 3.1415927 / 180),
                            child: child,
                          )
                        : child;
                  },
                ),
              )
          ],
        );
      },
    );
  }

  String? _addDotsBetweenInitialIfNeeded(
      bool isDotsBetweenInitials, String? text) {
    if (isDotsBetweenInitials == true && text != null) {
      text = text.split('').toList().join('.').toString();
    }
    return text;
  }

  String? getFontFamily(String item) {
    switch (item.toUpperCase()) {
      case 'LATO':
        return 'Lato';

      case 'CAIRO':
        return 'Cairo';

      case 'ROBOTO':
        return 'Roboto';

      default:
        return null;
    }
  }

  Widget _buildBody(
    BuildContext context, {
    required ProductDetailsModel productDetails,
    required List<ProductAttribute>? conditionalAttributes,
    required num productPrice,
    required bool isLoggedIn,
  }) {
    var productDetailsModel = productDetails.productDetailsModel;
    var productManufacturers = productDetailsModel?.productManufacturers;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._buildNameAndPriceAndVendorAndSku(
          context,
          name: productDetailsModel!.name,
          sku: productDetailsModel.sku,
          vendor: productManufacturers?.isNotEmpty == true
              ? productManufacturers?.first.name
              : null,
          price: productPrice,
        ),
        _buildShortDescription(context, productDetailsModel.shortDescription),
        ..._buildDescription(context, productDetailsModel.fullDescription),
        if (productDetailsModel.isDownload == true)
          ..._buildSizeGuide(context, productDetailsModel.downloadUrl),
        _buildAttributes(productDetailsModel.productAttributes),
        _buildConditionalAttributes(conditionalAttributes),
        if (productDetailsModel.hasSampleDownload!)
          _buildDownLoadProductSample(context),
        if (productDetailsModel.customProperties?.relatedProducts?.isNotEmpty ==
            true)
          ..._buildRelatedProductsSection(
              context, productDetailsModel.customProperties!.relatedProducts!),
        if (productDetailsModel.customProperties?.relatedProducts?.isNotEmpty ==
            true)
          const SizedBox(height: navbarHeight * 1)
        else
          const SizedBox(height: navbarHeight * 1.3),
      ],
    );
  }

  Widget _buildShareButton(BuildContext context) {
    final cubit = context.read<ProductDetailsCubit>();

    return ShareButton(onShareTap: () {
      final box = context.findRenderObject() as RenderBox?;

      final seName =
          cubit.state.productDetailsData!.productDetailsModel!.seName!;
      final link = '${ApiEndPoint.domainUrl}/$seName';

      cubit.shareProduct(
        box == null ? null : box.localToGlobal(Offset.zero) & box.size,
        link,
      );
    });
  }

  Widget _buildAttributes(List<ProductAttribute>? attributes) {
    return AttributesListWidget(
        attributes: attributes!.where((e) => !e.hasCondition!).toList());
  }

  Widget _buildConditionalAttributes(List<ProductAttribute>? attributes) {
    return AttributesListWidget(
        attributes: attributes!.where((e) => e.hasCondition!).toList());
  }

  Widget _buildShortDescription(
      BuildContext context, String? shortDescription) {
    if (shortDescription == null) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TitleText.medium(text: shortDescription),
    );
  }

  Widget _buildBanners(BuildContext context, List<String>? images,
      List<PictureModel>? pictureModel, bool isLoggedIn) {
    final cubit = context.read<ProductDetailsCubit>();
    var width = context.width;
    if (images == null) return const SizedBox();
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CarouselSlider.builder(
              options: CarouselOptions(
                height: width - 16.0,
                autoPlay: false,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  cubit.autoChangedCarouselIndex(index);
                  cubit.changeImageId(pictureModel![index].id);
                },
              ),
              carouselController: imageController,
              itemCount: images.length,
              itemBuilder: (context, index, realIndex) {
                String? image;
                if (images.isNotEmpty == true)
                  image = images[cubit.state.bannerIndex];
                return _buildImage(
                    width, image, images, cubit.state.bannerIndex);
              },
            ),
            _buildBackButton(context),
            _buildFavButton(isLoggedIn, context),
            _buildDots(cubit.state.bannerIndex, images.length),
          ],
        ),
      ],
    );
  }

  Widget _buildFavButton(bool isLoggedIn, BuildContext context) {
    final cubit = context.read<ProductDetailsCubit>();
    return PositionedDirectional(
      top: 40.0,
      end: 24.0,
      child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(4.0),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
            child: FavoriteButton(
              key: ValueKey(isFav.toString()),
              initial: isFav,
              onFavTap: () {
                if (!isLoggedIn) {
                  showRegisterFirstSnackbar(context);
                  return Future.value(false);
                } else {
                  if (!isFav!)
                    return cubit
                        .addProductToFav(widget.productId.toString(),
                            cubit.state.selectedAttributesList ?? {})
                        .then((value) {
                      if (value) isFav = !isFav!;
                      return value;
                    });
                  else if (isFav!) {
                    showSimpleBottomSheet(context,
                        label: 'remove_fav',
                        subtitle: 'remove_fav_subtitle', onPress: () async {
                      await cubit
                          .removeProductFromFav(widget.productId.toString())
                          .then((value) {
                        if (value) isFav = !isFav!;
                      }).whenComplete(() => NavigatorHelper.of(context).pop());
                    });
                    return !isFav!;
                  } else
                    return Future.value(false);
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return PositionedDirectional(
      top: 40.0,
      start: 24.0,
      child: InkWell(
        onTap: () => NavigatorHelper.of(context).pop(isFav),
        child: Container(
          padding: const EdgeInsets.all(4.0),
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: const Icon(
            Icons.chevron_left,
            size: 36.0,
            color: AppColors.PRIMARY_COLOR_DARK,
          ),
        ),
      ),
    );
  }

  Widget _buildDots(int index, int length) {
    return Positioned(
      bottom: 32.0,
      left: 8.0,
      right: 8.0,
      child: Center(
        child: AnimatedSmoothIndicator(
            activeIndex: index,
            count: length,
            effect: const JumpingDotEffect(
              dotWidth: 12.0,
              dotHeight: 6.0,
              activeDotColor: AppColors.PRIMARY_COLOR_DARK,
              spacing: 4.0,
              dotColor: AppColors.PRIMARY_COLOR_LIGHT,
            )),
      ),
    );
  }

  Widget _buildImage(
      double width, String? image, List<String> images, int index) {
    return Hero(
      tag: widget.heroTag ?? '',
      transitionOnUserGestures: true,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        width: width,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => openFullImage(
              context: context,
              images: images,
              index: index,
            ),
            child: CustomCachedNetworkImage(
              imageUrl: image,
              urlHeight: 600,
              urlWidth: 600,
              imageMode: ImageMode.Pad,
              scaleMode: ScaleMode.Both,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDescription(
      BuildContext context, String? fullDescription) {
    if (fullDescription == null || fullDescription == '')
      return const [SizedBox()];
    else
      return [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: TitleText(text: 'about_product'),
        ),
        Html(
          data: fullDescription,
          onLinkTap: (url, attributes, element) {
            launchUrl(Uri.parse(url!));
          },
        ),
      ];
  }

  Widget _buildAddToCartSection(BuildContext context) {
    final cubit = context.read<ProductDetailsCubit>();
    final cartCubit = context.read<CartCubit>();
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state.isInitial ||
              state.isLoading ||
              state.productDetailsData == null) return const SizedBox();
          return AddToCartButton(
            initialQuantity: 1,
            onAddPress: (quantity) {
              return cubit
                  .addProductToCart(widget.productId.toString(), quantity,
                      cubit.state.selectedAttributesList ?? {})
                  .whenComplete(() => cartCubit.loadCart());
            },
          );
        },
      ),
    );
  }

  Widget _buildDownLoadProductSample(BuildContext context) {
    final cubit = context.read<ProductDetailsCubit>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: DefaultTextFormField(
                currentFocusNode: FocusNode(),
                currentController: TextEditingController(),
                hint: 'download_sample'.tr()),
          ),
          const SizedBox(
            width: 8.0,
          ),
          DefaultButton(
              label: '',
              padding: const EdgeInsets.all(12.0),
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              backgroundColor: Colors.white,
              borderColor: AppColors.GREY_DARK_COLOR,
              icon: SvgPicture.asset('lib/res/assets/downLoadIcon.svg'),
              onPressed: () async => cubit.openProductSample())
        ],
      ),
    );
  }

  List<Widget> _buildNameAndPriceAndVendorAndSku(BuildContext context,
      {String? name,
      required String? sku,
      required num price,
      required String? vendor}) {
    return [
      Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TitleText.large(text: name ?? ''),
            ),
          ),
          _buildShareButton(context),
        ],
      ),
      const SizedBox(height: 8.0),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TitleText(text: '$price ${'currency'.tr()}'),
      ),
      if (vendor != null) const SizedBox(height: 8.0),
      if (vendor != null)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TitleText(
            text: '${'vendor'.tr()}: $vendor',
            color: AppColors.PRIMARY_COLOR,
          ),
        ),
      // if (sku != null)
      const SizedBox(height: 8.0),
      const Divider(
        color: AppColors.PRIMARY_COLOR,
        thickness: 2.0,
        indent: 8.0,
        endIndent: 8.0,
      ),
      // if (sku != null)
      //   Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
      //     child: TitleText(
      //       text: 'SKU: $sku',
      //       color: AppColors.PRIMARY_COLOR,
      //     ),
      //   ),
      const SizedBox(height: 8.0),
    ];
  }

  List<Widget> _buildRelatedProductsSection(
      BuildContext context, List<RelatedProductModel> relatedProducts) {
    final cartCubit = context.read<CartCubit>();
    return [
      const SizedBox(height: 16.0),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: TitleText(text: "similar_products"),
      ),
      const SizedBox(height: 16.0),
      SizedBox(
        height: 250.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: relatedProducts
              .map((e) => ProductCard(
                  heroTag: 'related${e.id}',
                  name: e.name ?? '',
                  price: e.productPrice?.price ?? '0',
                  oldPrice: e.productPrice?.OldPrice,
                  imageUrl: e.defaultPictureModel?.imageUrl ?? '',
                  discount: e.discountPercentage ?? 0,
                  isOutOfStock: e.isOutOfStock ?? false,
                  isSubscribedBackInStock: e.isSubscribedToBackInStock ?? false,
                  onPress: () => _goToProductDetailsPage(
                      context, e.id, e.defaultPictureModel?.imageUrl),
                  onAddPress: () => cartCubit
                          .addToCartFromCatalog(e.id.toString(), 1)
                          .then((value) {
                        if (value)
                          showSnackBar(context,
                              message: 'item_added_to_cart_successfully');
                        else {
                          _goToProductDetailsPage(
                              context, e.id, e.defaultPictureModel?.imageUrl);
                        }
                      }),
                  size: 150))
              .toList(),
        ),
      )
    ];
  }

  void _goToProductDetailsPage(
      BuildContext context, int? productId, String? image) {
    NavigatorHelper.of(context).push(MaterialPageRoute(builder: (_) {
      return ProductDetailsPage(
        productId: productId!,
        heroTag: 'related$productId',
        image: image,
      );
    }));
  }

  List<Widget> _buildSizeGuide(BuildContext context, String? downloadUrl) {
    var width = context.width;

    return [
      InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SvgPicture.asset('lib/res/assets/size_guide_icon.svg'),
              const SizedBox(width: 4.0),
              const TitleText(text: 'size_guide')
            ],
          ),
        ),
        onTap: () {
          showSizeGuideBottomSheet(context,
              label: 'size_guide', imageUrl: downloadUrl ?? '');
        },
      ),
      Container(
        margin: EdgeInsetsDirectional.only(start: 8.0, end: width * 0.7),
        height: 2,
        color: AppColors.PRIMARY_COLOR_DARK,
      )
    ];
  }

  // Future<void> _goToSignUpPage(BuildContext context) =>
  //     NavigatorHelper.of(context).pushNamed(SignUpPage.routeName);
}

class AddToCartButton extends StatefulWidget {
  const AddToCartButton({
    super.key,
    required this.onAddPress,
    required this.initialQuantity,
  });

  final FutureValueChanged<int> onAddPress;
  final int initialQuantity;

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  int _initialQuantity = 1;

  @override
  void initState() {
    _initialQuantity = widget.initialQuantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: 85.0,
      padding: const EdgeInsets.only(
          left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: AppColors.SHADOW,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: DefaultButton(
                borderColor: AppColors.PRIMARY_COLOR_DARK,
                backgroundColor: Colors.transparent,
                label: 'add_to_cart'.tr(),
                iconLocation: DefaultButtonIconLocation.End,
                icon: SvgPicture.asset(
                  'lib/res/assets/basket_fill_icon.svg',
                  color: AppColors.PRIMARY_COLOR,
                ),
                labelStyle: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: Colors.black, height: 1.0),
                keepButtonSizeOnLoading: true,
                onPressed: () async {
                  if (_initialQuantity <= 0) {
                    showSnackBar(context,
                        message: 'choose_quantity_and_add',
                        duration: 1,
                        margin: const EdgeInsets.fromLTRB(
                            16, 16, 16, navbarHeight));
                  } else {
                    await widget.onAddPress(_initialQuantity);
                  }
                }),
          ),
          // if (_initialQuantity > 0)
          Expanded(
            child: QuantityButton(
                quantity: _initialQuantity,
                onAddToCart: (quantity) {
                  _initialQuantity = quantity;
                },
                onRemoveFromCart: (quantity) {
                  _initialQuantity = quantity;
                }),
          )
        ],
      ),
    );
  }
}
