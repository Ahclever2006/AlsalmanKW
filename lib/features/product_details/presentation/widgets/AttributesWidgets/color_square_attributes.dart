import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../res/style/app_colors.dart';
import '../../../../../shared_widgets/stateless/title_text.dart';
import '../../../data/model/attributes/color_square_attribute_model.dart';
import '../../../data/model/product_details_model.dart';
import '../../blocs/cubit/product_details_cubit.dart';

class ColorSquareAttributes extends StatefulWidget {
  const ColorSquareAttributes({Key? key, required this.attributeModel})
      : super(key: key);
  final ProductAttribute? attributeModel;
  @override
  State<ColorSquareAttributes> createState() => _ColorSquareAttributesState();
}

class _ColorSquareAttributesState extends State<ColorSquareAttributes> {
  int? selectedColorIndex;

  @override
  void initState() {
    for (var element in widget.attributeModel!.values!) {
      if (element.isPreSelected!) {
        selectedColorIndex = widget.attributeModel!.values!.indexOf(element);

        final cubit = context.read<ProductDetailsCubit>();
        var name = widget.attributeModel!.name;

        if (name == 'Text Color' || name == 'لون النص')
          cubit.createTexColor(element.colorSquaresRgb);
        if (name == 'Image Color' || name == 'لون الصورة')
          cubit.changeImageId(element.pictureId);

        cubit.addToAttributeList({
          'product_attribute_${widget.attributeModel!.id}':
              element.id.toString()
        });

        cubit.adjustProductPrice(element.priceAdjustmentValue!);

        setState(() {});
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailsCubit>();
    final ColorSquareAttributeModel model =
        ColorSquareAttributeModel(values: widget.attributeModel!.values);
    if (model.selectedColorBox != null) {
      widget.attributeModel!.currentValue =
          widget.attributeModel!.values![model.selectedColorBox!];
    }

    final Widget notRequiredTitle =
        TitleText(text: widget.attributeModel!.name!);
    final Widget requiredTitle = Row(
      children: [
        TitleText(
          text: widget.attributeModel!.name!,
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.attributeModel!.name != null &&
            widget.attributeModel!.name.toString().isNotEmpty)
          widget.attributeModel!.isRequired! ? requiredTitle : notRequiredTitle,
        const SizedBox(
          height: 10.0,
        ),
        SizedBox(
          height: 52,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: model.values!.length,
            itemBuilder: (BuildContext context, int index) {
              Color? color;
              if (model.values![index].colorSquaresRgb != null) {
                final String strColor = (model.values![index].colorSquaresRgb
                        as String)
                    .trim()
                    .substring(1, model.values![index].colorSquaresRgb.length);
                final String colorInInt = "0xFF$strColor";
                color = Color(int.parse(colorInInt));
              }

              return GestureDetector(
                onTap: () async {
                  FocusManager.instance.primaryFocus?.unfocus();

                  widget.attributeModel!.error = null;

                  var name = widget.attributeModel!.name;

                  if (name == 'Text Color' || name == 'لون النص')
                    cubit.createTexColor(model.values![index].colorSquaresRgb);
                  else if (name == 'Image Color' || name == 'لون الصورة')
                    cubit.changeImageId(model.values![index].pictureId);

                  var key = 'product_attribute_${widget.attributeModel!.id}';
                  if (cubit.state.selectedAttributesList?.containsKey(key) ==
                      true) {
                    var previousSelectedValue =
                        cubit.state.selectedAttributesList![key];
                    //TODO: remove the price of the previous selected color if any
                    cubit.adjustProductPrice(model.values!
                            .where((element) =>
                                element.id == int.parse(previousSelectedValue))
                            .toList()
                            .first
                            .priceAdjustmentValue! *
                        -1);
                  }
                  cubit.addToAttributeList({
                    'product_attribute_${widget.attributeModel!.id}':
                        model.values![index].id.toString()
                  });

                  cubit.adjustProductPrice(
                      model.values![index].priceAdjustmentValue!);

                  setState(() {
                    model.selectedColorBox = index;
                    selectedColorIndex = index;
                  });
                },
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: selectedColorIndex == index
                                ? Border.all(
                                    color: AppColors.PRIMARY_COLOR_DARK,
                                    width: 2.0)
                                : null,
                            // borderRadius:
                            //     const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          padding: const EdgeInsets.all(16.0),
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          // child: Container(
                          //   padding: const EdgeInsets.all(2.0),
                          //   color: Colors.black26,
                          //   child: Text(
                          //     model.values![index].name!,
                          //     textAlign: TextAlign.center,
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .bodySmall!
                          //         .copyWith(color: Colors.white),
                          //   ),
                          // ),
                        ),
                      ],
                    )
                  ],
                ),
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
