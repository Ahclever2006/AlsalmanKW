import 'package:alsalman_app/features/product_details/presentation/blocs/cubit/product_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../res/style/app_colors.dart';
import '../../../data/model/attributes/text_form_field_attribute_model.dart';
import '../../../data/model/product_details_model.dart';

class MultiTextFormFieldAttributes extends StatefulWidget {
  const MultiTextFormFieldAttributes({Key? key, required this.attributeModel})
      : super(key: key);
  final ProductAttribute? attributeModel;
  @override
  State<MultiTextFormFieldAttributes> createState() =>
      _MultiTextFormFieldAttributesState();
}

class _MultiTextFormFieldAttributesState
    extends State<MultiTextFormFieldAttributes> {
      
  @override
  Widget build(BuildContext context) {
                        final cubit = context.read<ProductDetailsCubit>();

    final TextFormFieldAttributeModel model =
        TextFormFieldAttributeModel(hint: 'write here');
    if (widget.attributeModel!.textEditingController!.text.isEmpty &&
        model.value != null &&
        model.value!.isNotEmpty) {
      widget.attributeModel!.textEditingController!.text = model.value!;
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
          TextFormField(
            controller: widget.attributeModel!.textEditingController,
            maxLines: 3,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: model.hint,
            ),
                  onChanged: (value) {

              if (widget
                  .attributeModel!.textEditingController!.text.isNotEmpty) {
                cubit.addToAttributeList({
                  'product_attribute_${widget.attributeModel!.id}':
                      widget.attributeModel!.textEditingController!.text
                });

                cubit.adjustProductPrice(0);
              } else {
                cubit.removeFromAttributeList(
                    'product_attribute_${widget.attributeModel!.id}');

                cubit.adjustProductPrice(0);
              }
              if (widget
                  .attributeModel!.textEditingController!.text.isNotEmpty) {
                widget.attributeModel!.error = null;

                setState(() {});
              }
            },
            onFieldSubmitted: (value) {
              if (widget
                  .attributeModel!.textEditingController!.text.isNotEmpty) {
                widget.attributeModel!.error = null;

                setState(() {});
              } else {}
            },
          ),
          const SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }
}
