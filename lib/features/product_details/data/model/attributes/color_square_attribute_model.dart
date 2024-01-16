import '../product_details_model.dart';

class ColorSquareAttributeModel {
  int? selectedColorBox;
  List<Value>? values = <Value>[];

  ColorSquareAttributeModel({this.values}) {
    for (int i = 0; i < values!.length; i++) {
      if (values![i].isPreSelected!) {
        selectedColorBox = i;
      }
    }
  }
}
