import '../product_details_model.dart';

class ImageSquareAttribute {
  int? selectedImageBox;
  List<Value>? values = <Value>[];

  ImageSquareAttribute({this.values}) {
    for (int i = 0; i < values!.length; i++) {
      if (values![i].isPreSelected!) {
        selectedImageBox = i;
      }
    }
  }
}
