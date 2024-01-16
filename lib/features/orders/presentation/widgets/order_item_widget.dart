import '../../../../../shared_widgets/stateless/subtitle_text.dart';
import '../../../../../shared_widgets/stateless/title_text.dart';

import 'package:flutter/material.dart';

import '../../../../res/style/app_colors.dart';
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
        borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(20.0), topStart: Radius.circular(20.0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildRowItem(label: 'order_id', value: '#${order!.id!}'),
                _buildRowItem(
                    label: 'date', value: order!.createdOn!.split(' ').first),
                _buildRowItem(
                    label: 'order_status', value: order!.orderStatus ?? ''),
                _buildRowItem(label: 'amount', value: order!.orderTotal ?? ''),
              ],
            ),
          ),
          IconButton(
              onPressed: onPress,
              icon: const Icon(
                Icons.chevron_right,
                size: 40.0,
              ))
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
          SubtitleText(text: label),
          TitleText(text: value),
        ],
      ),
    );
  }
}
