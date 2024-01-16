import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import '../../../../shared_widgets/stateless/title_text.dart';

import '../../../../../features/orders/presentation/pages/order_details_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../../../res/style/app_colors.dart';
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

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  int selectedTabIndex = 0;
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
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
              InnerPagesAppBar(label: 'orders'.tr().toUpperCase()),
              BlocConsumer<OrderCubit, OrderState>(
                listener: (context, state) {
                  if (state.isError)
                    showSnackBar(context, message: state.errorMessage);
                },
                builder: (context, state) {
                  if (state.isInitial ||
                      (state.isLoading && state.currentOrders == null))
                    return const Expanded(
                      child: CustomLoading(
                        loadingStyle: LoadingStyle.ShimmerList,
                      ),
                    );

                  return Expanded(
                    child: _buildPageView(
                      context,
                      state.currentOrders,
                      state.previousOrders,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageView(
    BuildContext context,
    MyOrdersModel? currentOrders,
    MyOrdersModel? previousOrders,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 12.0),
          color: AppColors.PRIMARY_COLOR,
          child: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 4.0,
            onTap: (index) {
              selectedTabIndex = index;
              setState(() {});
            },
            tabs: [
              TitleText(
                text: 'current',
                color: selectedTabIndex == 0 ? Colors.white : Colors.black,
              ),
              TitleText(
                text: 'previous',
                color: selectedTabIndex == 1 ? Colors.white : Colors.black,
              ),
            ],
            controller: _tabController,
          ),
        ),
        const SizedBox(height: 12.0),
        Expanded(
          child: TabBarView(controller: _tabController, children: [
            _buildCurrentOrderList(context, orderModel: currentOrders),
            _buildPreviousOrderList(context, orderModel: previousOrders),
          ]),
        ),
      ],
    );
  }

  Widget _buildCurrentOrderList(
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

  Widget _buildPreviousOrderList(
    BuildContext context, {
    required MyOrdersModel? orderModel,
  }) {
    final orderCubit = context.read<OrderCubit>();

    return orderModel?.orders?.isNotEmpty == true
        ? LazyLoadScrollView(
            onEndOfPage: () => orderCubit.getMorePreviousOrders(),
            isLoading: orderCubit.state.isLoadingMore,
            child: RefreshIndicator(
                onRefresh: () => orderCubit.refreshPreviousOrders(),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: orderModel!.orders!.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 16,
                    );
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
            title: 'no_previous_orders_available',
            onRefresh: () => orderCubit.refreshPreviousOrders(),
          );
  }
}
