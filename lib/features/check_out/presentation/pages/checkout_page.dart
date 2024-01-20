import 'dart:developer';

import 'package:flutter_tap_payment/flutter_tap_payment.dart';
import '../../../../core/data/datasources/device_type_data_source.dart';
import '../../../../core/data/models/schedule_delivery_shipping_dates_model.dart';
import '../../../../core/data/models/schedule_delivery_shipping_times_model.dart';
import '../../../../core/service/app_info_service.dart';
import '../../../../shared_widgets/other/show_wallet_status_change_dialog.dart';
import '../../../../shared_widgets/stateful/wallet_switch.dart';
import '../../../auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import '../../../orders/presentation/pages/order_details_page.dart';
import '../../../../main.dart';

import '../../../../features/cart_tab/presentation/cubit/cart_cubit.dart';
import '../../../../features/check_out/presentation/widgets/shipping_method_item_widget.dart';
import '../../../../shared_widgets/stateless/title_text.dart';

import '../../../../core/data/models/cart_model.dart';
import '../../../../core/data/models/payment_summary.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../res/style/theme.dart';
import '../../../../shared_widgets/stateful/default_button.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared_widgets/stateless/custom_cached_network_image.dart';
import '../../../../shared_widgets/stateless/diagonal_line.dart';
import '../../../layout/presentation/cubit/main_layout_cubit.dart';
import '../blocs/order_cubit/checkout_cubit.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../../../shared_widgets/stateless/empty_page_message.dart';
import '../../../../shared_widgets/stateless/inner_appbar.dart';
import '../../../address/data/models/addresses_model.dart';
import '../../../address/presentation/blocs/address_cubit/address_cubit.dart';
import '../../../address/presentation/pages/add_address_screen.dart';
import '../../../address/presentation/widgets/address_item_widget.dart';

import '/di/injector.dart';
import '/shared_widgets/other/show_snack_bar.dart';
import '/shared_widgets/stateless/custom_app_page.dart';
import '/shared_widgets/stateless/custom_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatefulWidget {
  static const routeName = '/CheckoutPage';
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late final TextEditingController _discountController;
  @override
  void initState() {
    _discountController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _discountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Injector().checkoutCubit,
      child: CustomAppPage(
        safeTop: true,
        safeBottom: false,
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAppbarAndTimeLine(),
              BlocBuilder<CheckoutCubit, CheckoutState>(
                buildWhen: (previous, current) =>
                    previous.pageIndex != current.pageIndex,
                builder: (context, state) {
                  if (state.pageIndex == 0)
                    return _buildAddressStep();
                  else if (state.pageIndex == 1)
                    return _buildDateAndTimeStep();
                  else
                    return _buildPaymentStep();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppbarAndTimeLine() {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      buildWhen: (previous, current) => previous.pageIndex != current.pageIndex,
      builder: (context, state) {
        return Column(
          children: [
            InnerPagesAppBar(
              label: state.pageIndex == 0
                  ? 'address'.tr().toUpperCase()
                  : state.pageIndex == 1
                      ? 'date/time'.tr().toUpperCase()
                      : 'payment'.tr().toUpperCase(),
              // actionIcon: state.pageIndex == 0 ? 'add_icon' : null,
              // onActionPress: state.pageIndex == 0
              //     ? () => _goToAddAddress(context)
              //     : null
            ),
            SvgPicture.asset(state.pageIndex == 0
                ? 'lib/res/assets/address_timeline.svg'
                : state.pageIndex == 1
                    ? 'lib/res/assets/date_timeline.svg'
                    : 'lib/res/assets/payment_timeline.svg'),
            const SizedBox(height: 16.0),
          ],
        );
      },
    );
  }

  BlocConsumer<AddressCubit, AddressState> _buildAddressStep() {
    return BlocConsumer<AddressCubit, AddressState>(
      listener: (context, state) {
        if (state is AddressStateError)
          showSnackBar(context, message: state.message);
      },
      builder: (context, state) {
        if (state is AddressInitial ||
            (state is AddressStateLoading && state.addressModel == null))
          return const Expanded(
            child: CustomLoading(
              loadingStyle: LoadingStyle.ShimmerList,
            ),
          );

        return _buildAddresses(context, addressModel: state.addressModel);
      },
    );
  }

  void _goToAddAddress(BuildContext context) async {
    final result =
        await NavigatorHelper.of(context).pushNamed(AddAddressPage.routeName);

    if (result == true) {
      Future.delayed(const Duration(milliseconds: 200), () {
        final addressCubit = context.read<AddressCubit>();
        addressCubit.refreshAddresses();
      });
    }
  }

  Widget _buildAddresses(
    BuildContext context, {
    required AddressesModel? addressModel,
  }) {
    final addressCubit = context.read<AddressCubit>();
    final checkoutCubit = context.read<CheckoutCubit>();

    return Expanded(
      child: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () => addressCubit.refreshAddresses(),
            child: addressModel!.addresses!.isNotEmpty
                ? ListView.separated(
                    itemCount: addressModel.addresses!.length + 2,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 16);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      if (index == addressModel.addresses!.length + 1)
                        return const SizedBox(height: navbarHeight);
                      if (index == addressModel.addresses!.length)
                        return DefaultButton(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 32.0),
                            label: 'add_address'.tr(),
                            onPressed: () => _goToAddAddress(context));
                      return BlocBuilder<CheckoutCubit, CheckoutState>(
                        buildWhen: (previous, current) =>
                            previous.addressId != current.addressId,
                        builder: (context, state) {
                          return AddressItemWidget(
                            address: addressModel.addresses![index],
                            // borderColor: (state.addressId != null &&
                            //         state.addressId !=
                            //             addressModel.addresses![index].id)
                            //     ? AppColors.PRIMARY_COLOR_DARK
                            //     : AppColors.PRIMARY_COLOR_LIGHT,
                            // backgroundColor: (state.addressId != null &&
                            //         state.addressId !=
                            //             addressModel.addresses![index].id)
                            //     ? AppColors.GREY_LIGHT_COLOR
                            //     : AppColors.PRIMARY_COLOR_LIGHT,
                            onPress: () {
                              checkoutCubit.chooseAddresses(
                                  addressModel.addresses![index].id!);
                            },
                            inCheckOut: true,
                            isSelected: state.addressId != null &&
                                state.addressId ==
                                    addressModel.addresses![index].id,
                          );
                        },
                      );
                    },
                  )
                : SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        EmptyPageMessage(
                            heightRatio: 0.5,
                            title: '${'no'.tr()} ${'addresses'.tr()}'),
                        DefaultButton(
                            label: 'add_address'.tr(),
                            onPressed: () => _goToAddAddress(context))
                      ],
                    ),
                  ),
          ),
          Positioned(
              bottom: 32.0,
              left: 16.0,
              right: 16.0,
              child: BlocListener<CheckoutCubit, CheckoutState>(
                listener: (context, state) async {
                  if (state.isAddressChosen) {
                    await checkoutCubit.getShippingMethods();
                    checkoutCubit.changePageIndex(1);
                  }
                },
                child: DefaultButton(
                    label: 'confirm_order'.tr(),
                    onPressed: () async {
                      if (checkoutCubit.state.addressId != null)
                        await checkoutCubit.setShippingAndBillingAddress();
                      else
                        showSnackBar(context, message: 'choose_address');
                    }),
              )),
        ],
      ),
    );
  }

  Widget _buildDateAndTimeStep() {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        final checkoutCubit = context.read<CheckoutCubit>();
        if (state.shippingMethods == null) return const EmptyPageMessage();
        return Expanded(
          child: Stack(
            children: [
              ListView(
                children: state.shippingMethods!.map((e) {
                  var isChecked =
                      (state.shippingOption == e.optionName && e.isAvailable!);

                  var isAvailable = (e.isAvailable!);
                  return Stack(
                    children: [
                      ShippingMethodItemWidget(
                          shippingMethod: e,
                          isSelected: isChecked,
                          dates: state.shippingMethodDates,
                          times: state.shippingMethodTimes,
                          onDatePress:
                              (ScheduleDeliveryShippingDatesModel date) async {
                            await checkoutCubit.getShippingTimes(
                                date.id!, date.date!);
                          },
                          onTimePress:
                              (ScheduleDeliveryShippingTimesModel time) {
                            checkoutCubit.chooseShippingTime(
                                time.id!, time.fullTimeText!);
                          },
                          borderColor: !isAvailable
                              ? AppColors.GREY_NORMAL_COLOR
                              : AppColors.PRIMARY_COLOR_LIGHT,
                          backgroundColor: (!isAvailable || !isChecked)
                              ? AppColors.GREY_NORMAL_COLOR
                              : AppColors.PRIMARY_COLOR_LIGHT,
                          onPress: () async {
                            if (e.isAvailable!) {
                              checkoutCubit.chooseShippingMethod(
                                  e.shippingMethodSystemName ?? '',
                                  e.optionName ?? '',
                                  e.type!);

                              if (e.type == 'DateAndTime')
                                await checkoutCubit.getShippingDates(e.id!);
                              else
                                checkoutCubit.clearDatesAndTimes();
                            } else {
                              log('click on not available method');
                            }
                          }),
                      if (!isAvailable)
                        Positioned(
                          top: 6.0,
                          bottom: 6.0,
                          left: 0,
                          right: 0,
                          child:
                              CustomPaint(foregroundPainter: DiagonalPainter()),
                        ),
                    ],
                  );
                }).toList(),
              ),
              Positioned(
                  bottom: 32.0,
                  left: 16.0,
                  right: 16.0,
                  child: BlocListener<CheckoutCubit, CheckoutState>(
                    listener: (context, state) async {
                      if (state.isShippingMethodChosen) {
                        await checkoutCubit.getAndSetPaymentMethods();
                        checkoutCubit.changePageIndex(2);
                      }
                    },
                    child: DefaultButton(
                        label: 'payments'.tr().toUpperCase(),
                        onPressed: () async {
                          if (state.shippingOption != null) {
                            if (state.shippingMethodType == 'DateAndTime' &&
                                (state.selectedTimeSlotId == null ||
                                    state.selectedTimeSlotId == -1)) {
                              showSnackBar(
                                context,
                                message: 'choose_shipping_time',
                              );
                            } else {
                              await checkoutCubit.setShippingMethods();
                              await checkoutCubit.setShippingTime();
                              await checkoutCubit.getPaymentSummary();
                              await checkoutCubit.getWalletBalance();
                            }
                          } else
                            showSnackBar(
                              context,
                              message: 'choose_shipping_method',
                              margin: const EdgeInsets.fromLTRB(
                                  15.0, 5.0, 15.0, 100.0),
                            );
                        }),
                  )),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPaymentStep() {
    return BlocConsumer<CheckoutCubit, CheckoutState>(
      listener: (context, state) {
        if (state.isError) showSnackBar(context, message: state.errorMessage);

        if (state.isOrderShared) _goToHomePage(context, 'order_shared');
      },
      builder: (context, state) {
        if (state.paymentSummaryModel == null) return const SizedBox();
        return _buildBody(context,
            payment: state.paymentSummaryModel!,
            selectedPaymentMethod: state.selectedPaymentMethod,
            walletStatus: state.walletStatus ?? false);
      },
    );
  }

  void _goToHomePage(BuildContext context, String message) {
    final mainLayoutCubit = context.read<MainLayoutCubit>();
    final cartCubit = context.read<CartCubit>();

    mainLayoutCubit.onBottomNavPressed(0);

    NavigatorHelper.of(context)
        .popUntil(ModalRoute.withName("/MainLayOutPage"));

    cartCubit.clearCart();

    if (message.isNotEmpty) showSnackBar(context, message: message);
  }

  Widget _buildBody(
    BuildContext context, {
    PaymentSummaryModel? payment,
    required int selectedPaymentMethod,
    required bool walletStatus,
  }) {
    final cubit = context.read<CheckoutCubit>();
    final cartCubit = context.read<CartCubit>();
    String? enteredCouponCode;
    final appliedDiscountsWithCodes =
        cartCubit.state.cart?.discountBox?.appliedDiscountsWithCodes;
    if (appliedDiscountsWithCodes?.isNotEmpty == true)
      enteredCouponCode = appliedDiscountsWithCodes!.first.couponCode;
    return Expanded(
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ..._buildPaymentMethods(context, selectedPaymentMethod),
                WalletSwitchButton(
                    isEnabled: walletStatus,
                    onPress: (value) {
                      cubit.changeWalletStatus(status: value).whenComplete(() {
                        showWalletStatusDialog(context,
                            label: value ? 'label_active' : 'label_deactive',
                            subtitle: value
                                ? 'subtitle_active'
                                : 'subtitle_deactive');
                      });
                    }),
                _buildDivider(),
                ..._buildOrderSummary(context),
                _buildCouponDiscount(context,
                    couponCode: payment!.totalsModel!.orderTotalDiscount != null
                        ? enteredCouponCode
                        : null),
                const SizedBox(height: navbarHeight * 3),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomSection(context, payment),
          )
        ],
      ),
    );
  }

  List<Widget> _buildOrderSummary(BuildContext context) {
    final cubit = context.read<CartCubit>();
    final orderProducts = cubit.state.cart!.items;
    var normalItems = orderProducts?.where((e) => e.productId != 348).toList();

    return [
      if (normalItems != null)
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: TitleText(text: 'order_summary'),
        ),
      if (normalItems != null)
        ...normalItems
            .map((cartItem) => _buildCartItem(context, cartItem))
            .toList(),
      if (normalItems != null) _buildDivider(),
    ];
  }

  Widget _buildCartItem(BuildContext context, Item cartItem) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.PRIMARY_COLOR,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: CustomCachedNetworkImage(
              width: 50.0,
              height: 50.0,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              imageUrl: cartItem.picture!.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: TitleText(
                text: cartItem.productName!,
                maxLines: 2,
              ),
            ),
          ),
          TitleText(text: cartItem.subTotal ?? ''),
        ],
      ),
    );
  }

  Widget _buildCouponDiscount(BuildContext context, {String? couponCode}) {
    final cartCubit = context.read<CartCubit>();
    final checkOutCubit = context.read<CheckoutCubit>();
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.GREY_BORDER_COLOR, width: 2),
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              )),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  enabled: couponCode == null,
                  controller: _discountController,
                  decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: couponCode == null
                          ? 'enter_coupon'.tr()
                          : couponCode.tr()),
                ),
              ),
              BlocListener<CartCubit, CartState>(
                listener: (context, state) {
                  if (state.isError)
                    showSnackBar(context, message: state.errorMessage);
                },
                child: DefaultButton(
                    backgroundColor: Colors.transparent,
                    label:
                        couponCode == null ? 'apply'.tr() : 'deactivate'.tr(),
                    labelStyle: Theme.of(context).textTheme.displayLarge!,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    onPressed: () async {
                      if (couponCode == null)
                        await cartCubit
                            .applyCoupon(_discountController.text.trim())
                            .then((value) async {
                          await cartCubit.loadCart();
                          await checkOutCubit.getPaymentSummary();
                        });
                      else {
                        cartCubit.deactivateCoupon().whenComplete(
                            () => checkOutCubit.getPaymentSummary());
                      }
                    }),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: AppColors.PRIMARY_COLOR_DARK,
    );
  }

  Widget _buildBottomSection(
      BuildContext context, PaymentSummaryModel? payment) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration:
          const BoxDecoration(color: Colors.white, boxShadow: AppColors.SHADOW),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ..._buildPaymentSummarySection(context, payment),
          const SizedBox(height: 16.0),
          _buildCheckOutAndShareOrderSection(context),
        ],
      ),
    );
  }

  List<Widget> _buildPaymentSummarySection(
      BuildContext context, PaymentSummaryModel? payment) {
    return [
      _buildCheckOutSummaryItem(
          label: 'sub_total', value: payment?.totalsModel?.subTotal ?? ''),
      _buildCheckOutSummaryItem(
          label: 'shipping', value: payment?.totalsModel?.shipping ?? ''),
      _buildCheckOutSummaryItem(
          label: 'wallet',
          value: payment?.totalsModel?.customProperties?.deductFromWallet ?? '',
          color: Colors.red),
      _buildCheckOutSummaryItem(
          label: 'discount',
          value: payment?.totalsModel?.customProperties?.totalDiscount ?? '',
          color: Colors.red),
      _buildCheckOutSummaryItem(
          label: 'grand_total', value: payment?.totalsModel?.orderTotal ?? '')
    ];
  }

  Widget _buildCheckOutSummaryItem({
    required String label,
    required String value,
    Color? color,
  }) {
    return value.isNotEmpty && !value.contains("0.000")
        ? Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleText(
                  text: label,
                ),
                TitleText(
                  text: value,
                  color: color,
                ),
              ],
            ),
          )
        : const SizedBox();
  }

  Widget _buildCheckOutAndShareOrderSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPayButton(context),
        // const SizedBox(width: 16.0),
        // _buildShareButton(context),
      ],
    );
  }

  Widget _buildPayButton(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();
    final authCubit = context.read<AuthCubit>();
    final userInfo = authCubit.state.userInfo?.data;
    return Expanded(
      flex: 2,
      child: DefaultButton(
          label: 'submit_order'.tr(),
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          onPressed: () async {
            final appInfo = await AppInfoServiceImpl().init();
            await cubit.confirmOrder().whenComplete(() async {
              String price = cubit
                  .state.paymentSummaryModel!.totalsModel!.orderTotal
                  .toString()
                  .replaceAll(RegExp(r'[^0-9.]'), '');

              double totalPrice = _getTotalPrice(price);

              if (totalPrice == 0) {
                _goToHomePage(context, '');
                navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) {
                  return OrderDetailsPage(
                      paymentStatus: true,
                      orderId: cubit.state.confirmModel!.id);
                }));
              } else {
                if (cubit.state.confirmModel!.id != null) {
                  _goToHomePage(context, '');
                  NavigatorHelper.of(context)
                      .push(MaterialPageRoute(builder: (_) {
                    return TapPayment(
                      // apiKey: "sk_test_ytlzZPQhfjcJ2LCTEvYA6O1R",
                      apiKey: "sk_live_lLOp45bgKfYMi0r1aeHtvsmZ",
                      redirectUrl: "https://tap.company",
                      postUrl: "https://tap.company",
                      paymentData: {
                        "amount": totalPrice,
                        "currency": "kwd",
                        "threeDSecure": true,
                        "save_card": false,
                        //TODO: check below var
                        "description": "Description Message",
                        "statement_descriptor": "Sample",
                        "metadata": const {"udf1": "test 1", "udf2": "test 2"},
                        "reference": {
                          "transaction": "txn_0001",
                          "order": "${cubit.state.confirmModel!.id}"
                        },
                        "receipt": const {"email": false, "sms": true},
                        "customer": {
                          "first_name": userInfo?.firstName ?? 'Guest User',
                          "last_name": userInfo?.lastName ?? '',
                          "mobile_type":
                              DeviceTypeDataSourceImpl().getDeviceType(),
                          "app_version":
                              '${appInfo.version} - ${appInfo.buildNumber}',
                          "email": userInfo?.email ?? 'Guest User',
                          "phone": {
                            "country_code": "965",
                            "number": userInfo?.phone ?? ''
                          }
                        },
                        "merchant": const {"id": "17288713"},

                        "source": {
                          "id": cubit.state.selectedPaymentMethod == 1
                              ? "src_kw.knet"
                              : "src_all"
                        },
                      },
                      onSuccess: (Map params) async {
                        log(params['id']);

                        await cubit
                            .confirmPayment(invoiceId: params['id'])
                            .whenComplete(() => navigatorKey.currentState
                                    ?.push(MaterialPageRoute(builder: (_) {
                                  return OrderDetailsPage(
                                      paymentStatus: true,
                                      orderId: cubit.state.confirmModel!.id);
                                })));
                      },
                      onError: (error) {
                        //log(error.toString());
                        Future.delayed(const Duration(milliseconds: 200), () {
                          navigatorKey.currentState
                              ?.push(MaterialPageRoute(builder: (_) {
                            return OrderDetailsPage(
                                paymentStatus: false,
                                orderId: cubit.state.confirmModel!.id);
                          }));
                        });
                      },
                    );
                  }));
                }
              }
            });
          }),
    );
  }

  double _getTotalPrice(String totalPriceWithManyDote) {
    final String numberBeforeDot =
        totalPriceWithManyDote.toString().split('.').first;

    final String numberAfterDot =
        totalPriceWithManyDote.toString().split('.')[1];

    final String total = '$numberBeforeDot.$numberAfterDot';
    final double totalPrice = double.parse(total);
    return totalPrice;
  }

  List<Widget> _buildPaymentMethods(BuildContext context, int selectedMethod) {
    final cubit = context.read<CheckoutCubit>();
    return [
      const TitleText(
          text: 'payment_method',
          margin: EdgeInsets.symmetric(horizontal: 16.0)),
      RadioListTile<int>(
        value: 1,
        groupValue: selectedMethod,
        onChanged: (newVal) {
          cubit.onPaymentOptionRadioPressed(
            newVal,
            'kNet',
          );
        },
        title: const TitleText(text: 'kNet'),
        secondary: Image.asset(
          'lib/res/assets/knet.png',
          height: 40.0,
        ),
      ),
      RadioListTile<dynamic>(
        value: 2,
        groupValue: selectedMethod,
        onChanged: (newVal) {
          cubit.onPaymentOptionRadioPressed(
            newVal,
            'Visa/Master',
          );
        },
        title: const TitleText(text: 'Visa/Master'),
        secondary: Image.asset(
          'lib/res/assets//visa.png',
          height: 40.0,
        ),
      ),
    ];
  }
}
