import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../shared_widgets/stateless/title_text.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/stateful/default_button.dart';
import '../../data/models/my_orders_model.dart';

class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget({
    Key? key,
    required this.order,
    required this.onPress,
  }) : super(key: key);

  final Order? order;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: const BoxDecoration(
        color: AppColors.PRIMARY_COLOR_LIGHT,
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildRowItem(
              label: 'order_id', value: ' #${order!.id!}', isOrderId: true),
          _buildRowItem(
              label: 'date', value: order!.createdOn!.split(' ').first),
          _buildRowItem(label: 'order_status', value: order!.orderStatus ?? ''),
          _buildRowItem(
              label: 'payment_status', value: order!.paymentStatus ?? ''),
          _buildRowItem(label: 'amount', value: order!.orderTotal ?? ''),
          _buildButtons(context)
        ],
      ),
    );
  }

  Widget _buildRowItem(
      {required String label, required String value, bool? isOrderId = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TitleText(text: label),
          if (isOrderId == false) const TitleText(text: ' : '),
          TitleText(text: value),
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      child: DefaultButton(
        label: 'order_details'.tr(),
        onPressed: onPress,
      ),
    );
  }
}
