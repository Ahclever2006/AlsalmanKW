import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../../../features/orders/presentation/pages/order_details_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/navigator_helper.dart';

import '../../../cart_tab/presentation/cubit/cart_cubit.dart';
import '../../../layout/presentation/cubit/main_layout_cubit.dart';
import '/di/injector.dart';
import '/shared_widgets/other/show_snack_bar.dart';
import '/shared_widgets/stateless/custom_app_page.dart';
import '/shared_widgets/stateless/custom_loading.dart';
import '../../../../shared_widgets/stateless/empty_page_message.dart';
import '../../../../shared_widgets/stateless/inner_appbar.dart';
import '../../data/models/my_orders_model.dart';
import '../blocs/order_cubit/order_cubit.dart';
import '../widgets/order_item_widget.dart';

class OrdersPage extends StatefulWidget {
  static const routeName = '/OrdersPage';
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Injector().orderCubit..getOrders(),
      child: CustomAppPage(
        safeTop: true,
        child: Scaffold(
          body: Column(
            children: [
              InnerPagesAppBar(label: 'orders'.tr()),
              BlocConsumer<OrderCubit, OrderState>(
                listener: (context, state) {
                  if (state.isError)
                    showSnackBar(context, message: state.errorMessage);

                  if (state.isReOrder) _goToHomePage(context);
                },
                builder: (context, state) {
                  if (state.isInitial ||
                      (state.isLoading && state.orders == null))
                    return const Expanded(
                      child: CustomLoading(
                        loadingStyle: LoadingStyle.ShimmerList,
                      ),
                    );

                  return Expanded(
                    child: _buildOrdersList(context, orderModel: state.orders),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrdersList(
    BuildContext context, {
    required MyOrdersModel? orderModel,
  }) {
    final orderCubit = context.read<OrderCubit>();

    return orderModel?.orders?.isNotEmpty == true
        ? LazyLoadScrollView(
            onEndOfPage: () => orderCubit.getMoreCurrentOrders(),
            isLoading: orderCubit.state.isLoadingMore,
            child: RefreshIndicator(
                onRefresh: () => orderCubit.refreshCurrentOrders(),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: orderModel!.orders!.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 16);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    var order = orderModel.orders![index];
                    return OrderItemWidget(
                      order: order,
                      onPress: () => _goToOrdersPage(context, order.id!),
                    );
                  },
                )),
          )
        : EmptyPageMessage(
            title: 'no_current_orders_available',
            onRefresh: () => orderCubit.refreshCurrentOrders(),
          );
  }

  void _goToOrdersPage(BuildContext context, int id) {
    NavigatorHelper.of(context).push(MaterialPageRoute(builder: (_) {
      return OrderDetailsPage(orderId: id);
    }));
  }

  void _goToHomePage(BuildContext context) {
    final cartCubit = context.read<CartCubit>();

    final mainLayoutCubit = context.read<MainLayoutCubit>();
    mainLayoutCubit.onBottomNavPressed(3);

    cartCubit
        .loadCart()
        .then((value) => NavigatorHelper.of(context)
            .popUntil(ModalRoute.withName("/MainLayOutPage")))
        .whenComplete(() => showSnackBar(context, message: 're_order_success'));
  }
}
