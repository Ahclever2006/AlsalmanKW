import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared_widgets/stateful/custom_drop_down_menu.dart';
import '../../../../../shared_widgets/stateless/title_text.dart';
import '../../../data/model/attributes/drop_down_attribute_model.dart';
import '../../../data/model/product_details_model.dart';
import '../../blocs/cubit/product_details_cubit.dart';

class DropDownAttributes extends StatefulWidget {
  const DropDownAttributes({Key? key, required this.attributeModel})
      : super(key: key);
  final ProductAttribute? attributeModel;
  @override
  State<DropDownAttributes> createState() => _DropDownAttributesState();
}

class _DropDownAttributesState extends State<DropDownAttributes> {
  Value? selected;
  FocusScopeNode node = FocusScopeNode();

  @override
  void initState() {
    final cubit = context.read<ProductDetailsCubit>();

    for (var element in widget.attributeModel!.values!) {
      if (element.isPreSelected!) {
        cubit.addToAttributeList({
          'product_attribute_${widget.attributeModel!.id}':
              element.id.toString()
        });

        var name = widget.attributeModel!.name;
        if (name == 'Font Family' || name == 'نوع الخط')
          cubit.createTexFontFamily(getFontFamily(element));
        else if (name == 'Text Font Size' || name == 'حجم الخط') {
          cubit.createTexFontSize(getFontSize(element));
        }
        if (element.priceAdjustmentValue != 0)
          cubit.adjustProductPrice(element.priceAdjustmentValue!);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailsCubit>();
    final DropDownAttributeModel model =
        DropDownAttributeModel(context, values: widget.attributeModel!.values);

    widget.attributeModel!.currentValue = model.currentValue;

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
        const SizedBox(
          height: 10.0,
        ),
        FocusScope(
          node: node,
          child: CustomDropDownMenu<Value>(
            key: UniqueKey(),
            isRequired: true,
            hint: widget.attributeModel!.name != null &&
                    widget.attributeModel!.name!.isNotEmpty
                ? widget.attributeModel!.name!
                : 'Choose attribute',
            currentItem: selected ?? model.currentValue,
            items: model.dropDownItems!,
            onChanged: (Value? value) async {
              if (selected != null && selected!.priceAdjustmentValue != 0)
                cubit
                    .adjustProductPrice((selected!.priceAdjustmentValue!) * -1);

              selected = value;
              widget.attributeModel!.currentValue = value;

              //here we add to selected list
              cubit.addToAttributeList({
                'product_attribute_${widget.attributeModel!.id}':
                    value!.id.toString()
              });

              var name = widget.attributeModel!.name;

              if (name == 'Font Family' || name == 'نوع الخط')
                cubit.createTexFontFamily(getFontFamily(value));
              else if (name == 'Text Font Size' || name == 'حجم الخط') {
                cubit.createTexFontSize(getFontSize(value));
              }

              cubit.adjustProductPrice(value.priceAdjustmentValue!);
            },
            getStringFromItem: (item) => item.name!,
            getFontFamilyFromItem: getFontFamily,
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
      ],
    );
  }

  String? getFontFamily(item) {
    var name = widget.attributeModel!.name;
    if (name == 'Font Family' || name == 'نوع الخط') {
      switch ((item as Value).name?.toUpperCase()) {
        case 'CENTURY GOTHIC':
          return 'CenturyGothic';

        case 'COMIC SANS':
          return 'ComicSans';

        case 'TIMES NEW ROMAN':
          return 'TimesNewRoman';

        default:
          return null;
      }
    } else
      return null;
  }

  double? getFontSize(item) {
    var name = widget.attributeModel!.name;
    if (name == 'Text Font Size' || name == 'حجم الخط') {
      switch ((item as Value).name?.toUpperCase()) {
        case '2.5 CM PER LETTER':
          return 16.0;

        case '3 CM PER LETTER':
          return 20.0;

        default:
          return null;
      }
    } else
      return null;
  }
}
