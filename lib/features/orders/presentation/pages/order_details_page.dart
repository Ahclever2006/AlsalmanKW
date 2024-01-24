import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/media_query_values.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../../../shared_widgets/stateful/default_button.dart';
import '../../../cart_tab/presentation/cubit/cart_cubit.dart';
import '/di/injector.dart';
import '/shared_widgets/other/show_snack_bar.dart';
import '/shared_widgets/stateless/custom_app_page.dart';
import '/shared_widgets/stateless/custom_loading.dart';
import '../../../../../features/orders/data/models/order_details_model.dart';
import '../../../../../features/orders/presentation/blocs/order_details_cubit/order_details_cubit.dart';
import '../../../../../shared_widgets/stateless/title_text.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/stateless/custom_cached_network_image.dart';
import '../../../../shared_widgets/stateless/inner_appbar.dart';
import '../../../../shared_widgets/stateless/subtitle_text.dart';
import '../../../address/data/models/addresses_model.dart';
import '../../../address/presentation/widgets/address_item_widget.dart';

class OrderDetailsPage extends StatefulWidget {
  static const routeName = '/OrderDetailsPage';
  const OrderDetailsPage({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  final int orderId;

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  bool? isFav;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          Injector().orderDetailsCubit..getOrderDetails(widget.orderId),
      child: CustomAppPage(
        safeTop: true,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              InnerPagesAppBar(label: 'order_details'.tr().toUpperCase()),
              Expanded(
                child: Builder(builder: (context) {
                  final orderDetailsCubit = context.read<OrderDetailsCubit>();

                  return RefreshIndicator(
                    onRefresh: () => orderDetailsCubit.refresh(widget.orderId),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          BlocConsumer<OrderDetailsCubit, OrderDetailsState>(
                            listener: (context, state) {
                              if (state.isError)
                                showSnackBar(context,
                                    message: state.errorMessage);

                              if (state.isReOrder) _goToHomePage(context);
                            },
                            builder: (context, state) {
                              if (state.isInitial ||
                                  (state.isLoading &&
                                      state.orderDetails == null))
                                return const CustomLoading();

                              return _buildBody(
                                context,
                                orderDetails: state.orderDetails!,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context, {
    required OrderDetailsModel orderDetails,
  }) {
    final orderCubit = context.read<OrderDetailsCubit>();

    var orderDetailsModel = orderDetails.data;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTopSection(orderDetailsModel),
        ..._buildDeliveryAddressSection(orderDetailsModel!.shippingAddress),
        ..._buildShippingMethodSection(orderDetailsModel.shippingMethod),
        ..._buildOrderSummary(context, orderDetailsModel.items),
        const SizedBox(height: 16.0),
        DefaultButton(
            margin: EdgeInsets.symmetric(horizontal: context.width * 0.15),
            label: 're_order'.tr(),
            onPressed: () => orderCubit.reOrder(orderDetails.data!.id!)),
        DefaultButton(
            margin: EdgeInsets.symmetric(
                horizontal: context.width * 0.15, vertical: 16.0),
            label: 'share'.tr(),
            backgroundColor: AppColors.PRIMARY_COLOR_DARK,
            onPressed: () {
              final box = context.findRenderObject() as RenderBox?;
              return orderCubit.getPdfInvoice(
                  widget.orderId,
                  box == null
                      ? null
                      : box.localToGlobal(Offset.zero) & box.size);
            })
      ],
    );
  }

  List<Widget> _buildOrderSummary(
      BuildContext context, List<Items>? orderProducts) {
    // var normalItems = orderProducts?.where((e) => e.productId != 348).toList();

    return [
      if (orderProducts != null && orderProducts.isNotEmpty)
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: TitleText(
            text: 'order_summary',
            color: AppColors.PRIMARY_COLOR_DARK,
          ),
        ),
      if (orderProducts != null && orderProducts.isNotEmpty)
        ...orderProducts
            .map((cartItem) => _buildCartItem(context, cartItem))
            .toList(),
    ];
  }

  void _goToHomePage(BuildContext context) {
    final cartCubit = context.read<CartCubit>();

    // final mainLayoutCubit = context.read<MainLayoutCubit>();
    // mainLayoutCubit.onBottomNavPressed(0);

    cartCubit
        .loadCart()
        .then((value) => NavigatorHelper.of(context)
            .popUntil(ModalRoute.withName("/MainLayOutPage")))
        .whenComplete(() => showSnackBar(context, message: 're_order_success'));
  }

  Widget _buildCartItem(BuildContext context, Items cartItem) {
    return Container(
      height: 156.0,
      decoration: const BoxDecoration(
        color: AppColors.PRIMARY_COLOR_LIGHT,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.PRIMARY_COLOR,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: CustomCachedNetworkImage(
              width: 140.0,
              height: 140.0,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              imageUrl: cartItem.picture!.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(
                  text: cartItem.productName!,
                  maxLines: 2,
                  color: AppColors.PRIMARY_COLOR_DARK,
                ),
                const Spacer(),
                TitleText(
                  text: '${'qty'.tr()} : ${cartItem.quantity}',
                  color: AppColors.PRIMARY_COLOR_DARK,
                ),
                const SizedBox(height: 12.0),
                TitleText(
                  text: cartItem.subTotal ?? '',
                  color: AppColors.PRIMARY_COLOR_DARK,
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTopSection(Data? order) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.PRIMARY_COLOR_LIGHT,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildRowItem(label: 'order_id', value: '#${order!.id!}'),
          _buildRowItem(
              label: 'date', value: order.createdOn!.split(' ').first),
          _buildRowItem(label: 'order_status', value: order.orderStatus ?? ''),
          _buildRowItem(label: 'amount', value: order.orderTotal ?? ''),
        ],
      ),
    );
  }

  Widget _buildRowItem({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SubtitleText(
            text: label,
            color: AppColors.PRIMARY_COLOR_DARK,
          ),
          TitleText(
            text: value,
            color: AppColors.PRIMARY_COLOR_DARK,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDeliveryAddressSection(Address? shippingAddress) {
    return [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: TitleText(
          text: 'delivery_address',
          color: AppColors.PRIMARY_COLOR_DARK,
        ),
      ),
      AddressItemWidget(
        address: shippingAddress!,
        backgroundColor: AppColors.PRIMARY_COLOR_LIGHT,
        borderColor: Colors.transparent,
      )
    ];
  }

  List<Widget> _buildShippingMethodSection(String? shippingMethod) {
    return [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: TitleText(
          text: 'shipping_method',
          color: AppColors.PRIMARY_COLOR_DARK,
        ),
      ),
      Container(
        decoration: const BoxDecoration(
          color: AppColors.PRIMARY_COLOR_LIGHT,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TitleText.medium(
          text: shippingMethod ?? '',
          color: AppColors.PRIMARY_COLOR_DARK,
        ),
      )
    ];
  }
}
