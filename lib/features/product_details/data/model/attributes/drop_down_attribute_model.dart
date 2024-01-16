import 'package:flutter/material.dart';

import '../product_details_model.dart';

class DropDownAttributeModel {
  List<Value>? values = <Value>[];

  List<Value>? dropDownItems = [];
  Value? currentValue;
  BuildContext? context;

  DropDownAttributeModel(this.context, {this.values}) {
    generateDropDownList(values!);
  }

  generateDropDownList(List<Value> values) {
    for (int i = 0; i < values.length; i++) {
      if (values[i].isPreSelected!) {
        currentValue = values[i];
      }
      dropDownItems!.add(
        values[i],
      );
    }
  }
}
