import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../res/style/app_colors.dart';
import '../../../../../shared_widgets/stateless/title_text.dart';
import '../../../data/model/attributes/radio_button_attribute_model.dart';
import '../../../data/model/product_details_model.dart';
import '../../blocs/cubit/product_details_cubit.dart';

class RadioListAttribute extends StatefulWidget {
  const RadioListAttribute({Key? key, required this.attributeModel})
      : super(key: key);
  final ProductAttribute? attributeModel;
  @override
  State<RadioListAttribute> createState() => _RadioListAttributeState();
}

class _RadioListAttributeState extends State<RadioListAttribute> {
  Value? selected;

  @override
  void initState() {
    final cubit = context.read<ProductDetailsCubit>();

    selected = widget.attributeModel!.values!
        .firstWhereOrNull((e) => e.isPreSelected!);

    for (var element in widget.attributeModel!.values!) {
      if (element.isPreSelected!) {
        cubit.adjustProductPrice(element.priceAdjustmentValue!);
        cubit.addToAttributeList({
          'product_attribute_${widget.attributeModel!.id}':
              element.id.toString()
        });
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailsCubit>();
    final RadioButtonAttributeModel model =
        RadioButtonAttributeModel(values: widget.attributeModel!.values);
    final Widget notRequiredTitle =
        TitleText(text: widget.attributeModel!.name!);
    final Widget requiredTitle = Row(
      children: <Widget>[
        TitleText(text: widget.attributeModel!.name!),
        const SizedBox(
          width: 5.0,
        ),
        const Text(
          "*",
          style: TextStyle(color: Colors.red),
        ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.attributeModel!.name != null &&
            widget.attributeModel!.name.toString().isNotEmpty)
          widget.attributeModel!.isRequired! ? requiredTitle : notRequiredTitle,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List<Widget>.generate(
            model.values!.length,
            (int index) {
              return Row(
                children: <Widget>[
                  FocusScope(
                    node: FocusScopeNode(),
                    child: Theme(
                      data: ThemeData(radioTheme: RadioThemeData(
                        fillColor: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return AppColors.PRIMARY_COLOR_LIGHT;
                          } else
                            return AppColors.PRIMARY_COLOR_DARK;
                        }),
                      )),
                      child: Radio<Value>(
                        value: widget.attributeModel!.values![index],
                        groupValue: selected,
                        onChanged: (value) async {
                          FocusManager.instance.primaryFocus?.unfocus();

                          if (selected != null)
                            cubit.adjustProductPrice(
                                (selected!.priceAdjustmentValue!) * -1);

                          selected = value;

                          cubit.addToAttributeList({
                            'product_attribute_${widget.attributeModel!.id}':
                                value!.id.toString()
                          });

                          cubit.adjustProductPrice(value.priceAdjustmentValue!);

                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  TitleText(text: model.values![index].name!),
                ],
              );
            },
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}
