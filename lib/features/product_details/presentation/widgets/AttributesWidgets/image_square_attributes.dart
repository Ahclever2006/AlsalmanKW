import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/attributes/image_square_attribute.dart';
import '../../../data/model/product_details_model.dart';
import '../../blocs/cubit/product_details_cubit.dart';

class ImageSquareAttributes extends StatefulWidget {
  const ImageSquareAttributes({Key? key, required this.attributeModel})
      : super(key: key);
  final ProductAttribute? attributeModel;
  @override
  State<ImageSquareAttributes> createState() => _ImageSquareAttributesState();
}

class _ImageSquareAttributesState extends State<ImageSquareAttributes> {
  int? selectedColorIndex = 0;

  @override
  void initState() {
    for (var element in widget.attributeModel!.values!) {
      if (element.isPreSelected!) {
        selectedColorIndex = widget.attributeModel!.values!.indexOf(element);
        final cubit = context.read<ProductDetailsCubit>();

        cubit.addToAttributeList({
          'product_attribute_${widget.attributeModel!.id}':
              element.id.toString()
        });

        setState(() {});
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailsCubit>();
    final ImageSquareAttribute model =
        ImageSquareAttribute(values: widget.attributeModel!.values);
    if (model.selectedImageBox != null) {
      widget.attributeModel!.currentValue =
          widget.attributeModel!.values![model.selectedImageBox!];
    }

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
              if (model.selectedImageBox != null &&
                  model.selectedImageBox == index) {}

              return GestureDetector(
                onTap: () async {
                  FocusManager.instance.primaryFocus?.unfocus();

                  cubit.addToAttributeList({
                    'product_attribute_${widget.attributeModel!.id}':
                        model.values![index].id.toString()
                  });

                  //TODO:remove the price of previous selected image if any

                  cubit.adjustProductPrice(
                      model.values![index].priceAdjustmentValue!);
                  setState(() {
                    selectedColorIndex = index;
                    model.selectedImageBox = index;
                    log(model.selectedImageBox.toString());

                    widget.attributeModel!.error = null;
                  });
                },
                child: Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    Container(
                      width: 40.0,
                      height: 50,
                      margin: const EdgeInsetsDirectional.only(end: 15.0),
                      child: model.values![index].imageSquaresPictureModel!
                                      .imageUrl !=
                                  null &&
                              model.values![index].imageSquaresPictureModel!
                                  .imageUrl!.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: model.values![index]
                                  .imageSquaresPictureModel!.imageUrl
                                  .toString()
                                  .replaceAll('http:', 'https:'),
                              width: 40,
                              height: 50,
                              placeholder: (context, url) =>
                                  const Text('place holder'),
                            )
                          : const Text('no data'),
                    ),
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
