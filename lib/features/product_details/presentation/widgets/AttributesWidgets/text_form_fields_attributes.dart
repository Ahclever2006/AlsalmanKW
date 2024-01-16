import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared_widgets/stateless/subtitle_text.dart';
import '../../../../../shared_widgets/stateless/title_text.dart';

import '../../../../../res/style/app_colors.dart';
import '../../../data/model/attributes/text_form_field_attribute_model.dart';
import '../../../data/model/product_details_model.dart';
import '../../blocs/cubit/product_details_cubit.dart';

class TextFormFieldAttributes extends StatefulWidget {
  const TextFormFieldAttributes({Key? key, required this.attributeModel})
      : super(key: key);
  final ProductAttribute? attributeModel;
  @override
  State<TextFormFieldAttributes> createState() =>
      _TextFormFieldAttributesState();
}

class _TextFormFieldAttributesState extends State<TextFormFieldAttributes> {
  TextEditingController? textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailsCubit>();
    final TextFormFieldAttributeModel model =
        TextFormFieldAttributeModel(hint: 'write here');
    if (textEditingController!.text.isEmpty &&
        model.value != null &&
        model.value!.isNotEmpty) {
      textEditingController!.text = model.value!;
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
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.attributeModel!.name != null &&
                widget.attributeModel!.name.toString().isNotEmpty)
              widget.attributeModel!.isRequired!
                  ? requiredTitle
                  : notRequiredTitle,
            SubtitleText(
                text:
                    '${textEditingController!.text.length.toString()} / ${widget.attributeModel?.maxLength}')
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: AppColors.PRIMARY_COLOR,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextFormField(
            textInputAction: TextInputAction.next,
            controller: textEditingController,
            maxLength: widget.attributeModel?.maxLength != 0
                ? widget.attributeModel?.maxLength
                : 100,
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: model.hint,
              counterText: '',
              hintStyle: Theme.of(context).textTheme.bodyText1,
            ),
            style: Theme.of(context).textTheme.bodyText1,
            onChanged: (value) {
              if (textEditingController!.text.isNotEmpty) {
                cubit.addToAttributeList({
                  'product_attribute_${widget.attributeModel!.id}':
                      textEditingController!.text
                });

                cubit.createTextMessageOnProduct(textEditingController!.text);

                cubit.adjustProductPrice(0);
              } else {
                cubit.removeFromAttributeList(
                    'product_attribute_${widget.attributeModel!.id}');

                cubit.createTextMessageOnProduct(textEditingController!.text);

                cubit.adjustProductPrice(0);
              }
              if (textEditingController!.text.isNotEmpty) {
                widget.attributeModel!.error = null;

                setState(() {});
              }
            },
            onFieldSubmitted: (value) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'enter valid data';
              } else {
                return null;
              }
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
