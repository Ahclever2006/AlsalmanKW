import 'package:flutter/material.dart';

import '../../../data/model/attributes/check_box_attribute_model.dart';
import '../../../data/model/product_details_model.dart';

class ReadOnlyCheckBoxListAttributes extends StatefulWidget {
  const ReadOnlyCheckBoxListAttributes({Key? key, required this.attributeModel})
      : super(key: key);
  final ProductAttribute? attributeModel;
  @override
  State<ReadOnlyCheckBoxListAttributes> createState() =>
      _ReadOnlyCheckBoxListAttributesState();
}

class _ReadOnlyCheckBoxListAttributesState
    extends State<ReadOnlyCheckBoxListAttributes> {
  @override
  Widget build(BuildContext context) {
    final CheckBoxAttributeModel model =
        CheckBoxAttributeModel(values: widget.attributeModel!.values);

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

    for (int i = 0; i < model.values!.length; i++) {
      if (model.values![i].isPreSelected!) {
        widget.attributeModel!.currentValueList!.add(model.values![i]);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.attributeModel!.name != null &&
            widget.attributeModel!.name.toString().isNotEmpty)
          widget.attributeModel!.isRequired! ? requiredTitle : notRequiredTitle,
        const SizedBox(
          height: 5.0,
        ),
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(model.values!.length, (int index) {
              return Row(
                children: <Widget>[
                  Checkbox(
                    value: model.values![index].isPreSelected,
                    onChanged: null,
                  ),
                  InkWell(
                      child: Container(
                    width: 250.0,
                    height: 40.0,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      model.values![index].name!,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ))
                ],
              );
            })),
        const SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}
