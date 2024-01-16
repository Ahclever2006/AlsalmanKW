import 'package:flutter/material.dart';

import '../../data/model/product_details_model.dart';
import 'AttributesWidgets/check_box_list_attributes.dart';
import 'AttributesWidgets/color_square_attributes.dart';
import 'AttributesWidgets/date_picker_attributes.dart';
import 'AttributesWidgets/drop_down_attributes.dart';
import 'AttributesWidgets/file_picker_attributes.dart';
import 'AttributesWidgets/image_square_attributes.dart';
import 'AttributesWidgets/multi_text_form_field_attributes.dart';
import 'AttributesWidgets/radio_list_attributes.dart';
import 'AttributesWidgets/read_only_check_box_list_attributes.dart';
import 'AttributesWidgets/text_form_fields_attributes.dart';

class AttributesListWidget extends StatelessWidget {
  const AttributesListWidget({Key? key, required this.attributes})
      : super(key: key);

  final List<ProductAttribute>? attributes;

  @override
  Widget build(BuildContext context) {
    List<ProductAttribute> model = attributes!;
    if (attributes!.isEmpty) {
      return Container();
    }
    return Card(
      color: Colors.transparent,
      elevation: 0.0,
      margin: const EdgeInsets.only(top: 10.0, left: 4.0, right: 4.0),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 15.0, left: 15.0, right: 15.0, bottom: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List<Widget>.generate(
            model.length,
            (int index) {
              switch (model[index].attributeControlType) {
                case 1:
                  return dropDownList(model[index]);

                case 2:
                  return radioList(model[index]);

                case 3:
                  return checkBoxList(model[index]);

                case 4:
                  return textFormField(model[index]);

                case 10:
                  return multiTextFormField(model[index]);

                case 40:
                  return colorSquare(model[index]);

                case 45:
                  return imageSquare(model[index]);

                case 50:
                  return readOnlyCheckBoxList(model[index]);

                case 20:
                  return datePicker(model[index]);

                case 30:
                  return filePicker(model[index]);

                default:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget dropDownList(ProductAttribute attributeModel) {
    return DropDownAttributes(
      attributeModel: attributeModel,
    );
  }

  Widget radioList(ProductAttribute attributeModel) {
    return RadioListAttribute(
      attributeModel: attributeModel,
    );
  }

  Widget checkBoxList(ProductAttribute attributeModel) {
    return CheckBoxAttributes(
      attributeModel: attributeModel,
    );
  }

  Widget textFormField(ProductAttribute attributeModel) {
    return TextFormFieldAttributes(
      attributeModel: attributeModel,
    );
  }

  Widget multiTextFormField(ProductAttribute attributeModel) {
    return MultiTextFormFieldAttributes(
      attributeModel: attributeModel,
    );
  }

  Widget colorSquare(ProductAttribute attributeModel) {
    return ColorSquareAttributes(
      attributeModel: attributeModel,
    );
  }

  Widget imageSquare(ProductAttribute attributeModel) {
    return ImageSquareAttributes(
      attributeModel: attributeModel,
    );
  }

  Widget readOnlyCheckBoxList(ProductAttribute attributeModel) {
    return ReadOnlyCheckBoxListAttributes(
      attributeModel: attributeModel,
    );
  }

  Widget datePicker(ProductAttribute attributeModel) {
    return DatePickerAttributes(
      attributeModel: attributeModel,
    );
  }

  Widget filePicker(ProductAttribute attributeModel) {
    return FilePickerAttributes(
      attributeModel: attributeModel,
    );
  }
}
