import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../../shared_widgets/stateless/subtitle_text.dart';

import '../../../../core/data/models/cart_model.dart';
import '../../../../core/data/models/payment_summary.dart';
import '../../../../core/utils/navigator_helper.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/other/show_cart_refresh_bottom_sheet.dart';
import '../../../../shared_widgets/other/show_simple_bottom_sheet.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import '../../../../shared_widgets/stateful/default_button.dart';
import '../../../../shared_widgets/stateful/stream_quantity_button.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import '../../../../shared_widgets/stateless/custom_cached_network_image.dart';
import '../../../../shared_widgets/stateless/custom_loading.dart';
import '../../../../shared_widgets/stateless/empty_page_message.dart';
import '../../../../shared_widgets/stateless/inner_appbar.dart';
import '../../../../shared_widgets/stateless/title_text.dart';
import '../../../check_out/presentation/pages/checkout_page.dart';
import '../cubit/cart_cubit.dart';

class CartTab extends StatelessWidget {
  static const routeName = '/CartTab';

  const CartTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomAppPage(
        safeTop: true,
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state.isError && state.cart == null)
              showSnackBar(context, message: state.errorMessage);
          },
          builder: (context, state) {
            if (state.isInitial || (state.isLoading && state.cart == null))
              return const CustomLoading(
                loadingStyle: LoadingStyle.ShimmerList,
              );
            if (state.cart?.items?.isNotEmpty == true) {
              return _buildBody(
                context,
                cartData: state.cart,
                payment: state.paymentSummary!,
              );
            } else
              return Column(
                children: [
                  InnerPagesAppBar(label: 'basket'.tr().toUpperCase()),
                  const EmptyPageMessage(
                    title: 'no_cart_items_found',
                    subTitle: "check_our_best",
                    svgImage: 'water_glass_icon',
                    isSVG: false,
                    textColor: AppColors.PRIMARY_COLOR_DARK,
                  ),
                ],
              );
          },
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context, {
    required CartModel? cartData,
    PaymentSummaryModel? payment,
  }) {
    if (cartData!.items!.isEmpty) return const SizedBox();
    final cubit = context.read<CartCubit>();

    return Column(
      children: [
        InnerPagesAppBar(label: 'basket'.tr().toUpperCase()),
        Expanded(
          child: RefreshIndicator(
              onRefresh: () => cubit.refresh(),
              child: _buildCartItemsList(
                context,
                cartItems: cartData.items,
                payment: payment!,
              )),
        ),
      ],
    );
  }

  Widget _buildCartItemsList(
    BuildContext context, {
    List<Item>? cartItems,
    PaymentSummaryModel? payment,
  }) {
    return Column(
      children: [
        Expanded(child: _buildCartItems(context, cartItems)),
        _buildCheckOutSection(context, payment),
      ],
    );
  }

  Widget _buildCartItems(BuildContext context, List<Item>? cartItems) {
    return ListView(
      children: cartItems!
          .map((cartItem) => _buildCartItem(context, cartItem, cartItems))
          .toList(),
    );
  }

  Widget _buildCheckOutSection(
      BuildContext context, PaymentSummaryModel? payment) {
    final cartCubit = context.read<CartCubit>();

    var warning = cartCubit.state.cart!.minOrderSubtotalWarning;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      margin: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: AppColors.PRIMARY_COLOR,
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildPaymentSummarySection(context, payment)),
              DefaultButton(
                  label: 'proceed_check_out'.tr(),
                  onPressed: () async {
                    if (warning != null)
                      return showSnackBar(context, message: warning);

                    await cartCubit.checkCartQuantityAvailable().then((value) {
                      if (value == true) {
                        NavigatorHelper.of(context)
                            .pushNamed(CheckoutPage.routeName);
                      } else {
                        showCartRefreshDialog(context,
                            label: 'cart_refresh',
                            subtitle: 'cart_refresh_subtitle',
                            onPress: () async {
                          await cartCubit.refreshCartItems().whenComplete(
                              () => NavigatorHelper.of(context).pop());
                        });
                      }
                    });
                  })
            ],
          ),
          if (warning != null) SubtitleText.medium(text: warning.toString()),
        ],
      ),
    );
  }

  Widget _buildCartItem(
      BuildContext context, Item cartItem, List<Item> cartItems) {
    return Container(
      key: cartItem.warnings!.isNotEmpty
          ? UniqueKey()
          : ValueKey('${cartItem.id}'),
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildImage(cartItem),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 8.0, top: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleText.medium(
                          text: cartItem.productName!,
                          maxLines: 2,
                        ),
                        Html(
                          data: cartItem.attributeInfo!,
                          style: {
                            "body": Style(
                                color: AppColors.PRIMARY_COLOR,
                                fontSize: FontSize(14)),
                          },
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      TitleText(
                        text: cartItem.unitPrice!,
                      ),
                      _buildQuantitySection(context, cartItem, cartItems),
                      _buildRemoveItem(context, cartItem)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(Item cartItem) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.PRIMARY_COLOR,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: CustomCachedNetworkImage(
        width: 100.0,
        height: 100.0,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        imageUrl: cartItem.picture!.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildQuantitySection(
      BuildContext context, Item cartItem, List<Item> cartItems) {
    final cubit = context.read<CartCubit>();
    return StreamQuantityButton(
        key: ValueKey(cartItem.quantity.toString()),
        quantity: cartItem.quantity,
        onAddToCart: (quantity) async {
          if (quantity >= 1)
            await cubit
                .updateCartItems(cartItem.id.toString(), quantity, cartItems)
                .then((value) {
              if (value == false) {
                showSnackBar(context, message: 'error_update_cart');
              }
            });
        },
        onRemoveFromCart: (quantity) {
          if (quantity >= 1)
            return cubit.updateCartItems(
                cartItem.id.toString(), quantity, cartItems);
          else
            return Future.value(null);
        });
  }

  Widget _buildRemoveItem(BuildContext context, Item cartItem) {
    final cubit = context.read<CartCubit>();
    return IconButton(
      icon: const Icon(Icons.delete,
          color: AppColors.GREY_DARK_COLOR, size: 30.0),
      onPressed: () {
        showSimpleBottomSheet(context,
            label: 'cart_remove_title',
            subtitle: 'remove_fav_subtitle',
            onPress: () =>
                cubit.removeFromCart(cartItem.id.toString()).whenComplete(() {
                  NavigatorHelper.of(context).pop();
                }));
      },
    );
  }

  Widget _buildPaymentSummarySection(
      BuildContext context, PaymentSummaryModel? payment) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(
            text: 'sub_total'.tr(),
            color: Colors.white,
          ),
          const SizedBox(height: 4.0),
          TitleText(
            text: payment?.totalsModel?.subTotal ?? '',
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
