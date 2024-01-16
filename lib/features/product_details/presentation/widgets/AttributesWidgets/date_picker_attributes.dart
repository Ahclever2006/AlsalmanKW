import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../res/style/app_colors.dart';
import '../../../data/model/attributes/date_picker_attribute_model.dart';
import '../../../data/model/product_details_model.dart';
import '../../blocs/cubit/product_details_cubit.dart';

class DatePickerAttributes extends StatefulWidget {
  const DatePickerAttributes({Key? key, required this.attributeModel})
      : super(key: key);
  final ProductAttribute? attributeModel;
  @override
  State<DatePickerAttributes> createState() => _DatePickerAttributesState();
}

class _DatePickerAttributesState extends State<DatePickerAttributes> {
  TextEditingController? textEditingController = TextEditingController();
  String? day;
  String? month;
  String? year;
  @override
  Widget build(BuildContext context) {
    final DatePickerAttributeModel model =
        DatePickerAttributeModel(hint: 'pick date');
    widget.attributeModel!.textEditingController;

    final Widget notRequiredTitle = Text(
      widget.attributeModel!.name!,
      style: Theme.of(context).textTheme.bodyText1,
    );
    final Widget requiredTitle = Row(
      children: <Widget>[
        Text(
          widget.attributeModel!.name!,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(
          width: 5.0,
        ),
        const Text(
          "*",
          style: TextStyle(color: Colors.red),
        ),
      ],
    );

    return Theme(
      data: ThemeData(primaryColor: AppColors.PRIMARY_COLOR),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (widget.attributeModel!.name != null &&
              widget.attributeModel!.name.toString().isNotEmpty)
            widget.attributeModel!.isRequired!
                ? requiredTitle
                : notRequiredTitle,
          const SizedBox(
            height: 10.0,
          ),
          InkWell(
            onTap: () {
              selectDate(model, widget.attributeModel!);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: AppColors.PRIMARY_COLOR,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                enabled: false,
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintText: model.hint,
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                ),
                style: Theme.of(context).textTheme.bodyText1,
                controller: textEditingController,
                onEditingComplete: () async {
                  // final String request =
                  //     makeRequestStringForConditionalAttribute();
                  // await callApiForConditionalAttribute(request);

                  setState(() {});
                },
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }

  Future selectDate(
      DatePickerAttributeModel model, ProductAttribute attributeModel) async {
    final cubit = context.read<ProductDetailsCubit>();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 2),
    );

    if (picked != null) {
      String pickedDate = intl.DateFormat('dd/MM/yyyy').format(picked);

      setState(() {
        model.value = pickedDate;
        day = picked.day.toString();
        month = picked.month.toString();
        year = picked.year.toString();
        textEditingController!.text = pickedDate;
        attributeModel.error = null;

        cubit.addToAttributeList({
          'product_attribute_${widget.attributeModel!.id}_day': day,
          'product_attribute_${widget.attributeModel!.id}_month': month,
          'product_attribute_${widget.attributeModel!.id}_year': year
        });
      });
    }
  }
}
