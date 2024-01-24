import 'package:flutter_svg/svg.dart';

import '../../../../core/data/models/schedule_delivery_shipping_times_model.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/data/models/schedule_delivery_shipping_dates_model.dart';
import '../../../../core/data/models/schedule_delivery_shipping_methods_model.dart';
import '../../../../shared_widgets/stateless/diagonal_line.dart';
import '../../../../shared_widgets/stateless/subtitle_text.dart';
import '../../../../shared_widgets/stateless/title_text.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart' as intl;

import '../../../../res/style/app_colors.dart';

class ShippingMethodItemWidget extends StatelessWidget {
  const ShippingMethodItemWidget({
    Key? key,
    required this.shippingMethod,
    required this.onPress,
    this.onDatePress,
    this.onTimePress,
    this.backgroundColor = AppColors.PRIMARY_COLOR_LIGHT,
    this.borderColor = AppColors.PRIMARY_COLOR_LIGHT,
    this.isSelected = false,
    this.dates,
    this.times,
  }) : super(key: key);

  final ScheduleDeliveryShippingMethodsModel shippingMethod;
  final VoidCallback onPress;
  final ValueChanged<ScheduleDeliveryShippingDatesModel>? onDatePress;
  final ValueChanged<ScheduleDeliveryShippingTimesModel>? onTimePress;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool isSelected;
  final List<ScheduleDeliveryShippingDatesModel>? dates;
  final List<ScheduleDeliveryShippingTimesModel>? times;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: onPress,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor!),
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (isSelected)
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 16.0),
                        child: SvgPicture.asset(
                            'lib/res/assets/selected_icon.svg'),
                      ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleText(
                          text: shippingMethod.title ?? '',
                          color: AppColors.PRIMARY_COLOR_DARK,
                        ),
                        if (shippingMethod.description != null)
                          SubtitleText(
                            text: shippingMethod.description ?? '',
                            color: AppColors.PRIMARY_COLOR_DARK,
                          ),
                      ],
                    )),
                    TitleText(
                      text:
                          '${shippingMethod.price!.toStringAsFixed(3)} ${'currency'.tr()}',
                      color: AppColors.PRIMARY_COLOR_DARK,
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                if (shippingMethod.type == 'DateAndTime' &&
                    isSelected &&
                    dates != null &&
                    dates!.isNotEmpty) ...[
                  const SizedBox(height: 12.0),
                  ShippingDateWidget(dates: dates!, onDatePress: onDatePress!)
                ],
                if (shippingMethod.type == 'DateAndTime' &&
                    isSelected &&
                    times != null &&
                    times!.isNotEmpty) ...[
                  const SizedBox(height: 12.0),
                  ShippingTimesWidget(times: times!, onTimePress: onTimePress!)
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ShippingDateWidget extends StatefulWidget {
  const ShippingDateWidget({
    required this.dates,
    required this.onDatePress,
    super.key,
  });

  final List<ScheduleDeliveryShippingDatesModel> dates;
  final ValueChanged<ScheduleDeliveryShippingDatesModel> onDatePress;

  @override
  State<ShippingDateWidget> createState() => _ShippingDateWidgetState();
}

class _ShippingDateWidgetState extends State<ShippingDateWidget> {
  int? selectedDateId;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.dates
          .map((e) => Expanded(
                child: InkWell(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: !e.isAvailable!
                              ? AppColors.GREY_BORDER_COLOR
                              : selectedDateId == e.id
                                  ? AppColors.PRIMARY_COLOR_DARK
                                  : AppColors.PRIMARY_COLOR,
                          border: Border.all(color: AppColors.PRIMARY_COLOR),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: SubtitleText.small(
                          text: intl.DateFormat(
                                  'dd MMMM yy', context.locale.languageCode)
                              .format(DateTime(
                            int.parse(e.date!.split('/').first),
                            int.parse(e.date!.split('/')[1]),
                            int.parse(e.date!.split('/').last),
                          )),
                          textAlign: TextAlign.center,
                          color: !e.isAvailable!
                              ? AppColors.PRIMARY_COLOR
                              : selectedDateId == e.id
                                  ? Colors.white
                                  : Colors.black,
                        ),
                      ),
                      if (!e.isAvailable!)
                        Positioned(
                          top: 2.0,
                          bottom: 2.0,
                          left: 12,
                          right: 12,
                          child:
                              CustomPaint(foregroundPainter: DiagonalPainter()),
                        ),
                    ],
                  ),
                  onTap: () {
                    if (e.isAvailable!) {
                      widget.onDatePress(e);
                      setState(() {
                        selectedDateId = e.id;
                      });
                    }
                  },
                ),
              ))
          .toList(),
    );
  }
}

class ShippingTimesWidget extends StatefulWidget {
  const ShippingTimesWidget({
    required this.times,
    required this.onTimePress,
    super.key,
  });

  final List<ScheduleDeliveryShippingTimesModel> times;
  final ValueChanged<ScheduleDeliveryShippingTimesModel> onTimePress;

  @override
  State<ShippingTimesWidget> createState() => _ShippingTimesWidgetState();
}

class _ShippingTimesWidgetState extends State<ShippingTimesWidget> {
  int? selectedDateId;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 8.0,
        spacing: 4.0,
        children: widget.times
            .map((e) => InkWell(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                          color: selectedDateId == e.id
                              ? AppColors.PRIMARY_COLOR_DARK
                              : AppColors.PRIMARY_COLOR_LIGHT,
                          border: Border.all(color: AppColors.PRIMARY_COLOR),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: SubtitleText.small(
                          text: '${e.fromTime}-${e.toTime}',
                          textAlign: TextAlign.center,
                          color: selectedDateId == e.id
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      if (!e.isAvailable!)
                        Positioned(
                          top: 4.0,
                          bottom: 4.0,
                          left: 0.0,
                          right: 0.0,
                          child:
                              CustomPaint(foregroundPainter: DiagonalPainter()),
                        ),
                    ],
                  ),
                  onTap: () {
                    if (e.isAvailable!) {
                      widget.onTimePress(e);
                      setState(() {
                        selectedDateId = e.id;
                      });
                    }
                  },
                ))
            .toList(),
      ),
    );
  }
}
