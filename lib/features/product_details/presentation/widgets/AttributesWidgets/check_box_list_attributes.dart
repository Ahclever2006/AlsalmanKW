import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../res/style/app_colors.dart';
import '../../../../../shared_widgets/stateless/title_text.dart';
import '../../../data/model/attributes/check_box_attribute_model.dart';
import '../../../data/model/product_details_model.dart';
import '../../blocs/cubit/product_details_cubit.dart';

class CheckBoxAttributes extends StatefulWidget {
  const CheckBoxAttributes({Key? key, required this.attributeModel})
      : super(key: key);
  final ProductAttribute? attributeModel;
  @override
  State<CheckBoxAttributes> createState() => _CheckBoxAttributesState();
}

class _CheckBoxAttributesState extends State<CheckBoxAttributes> {
  List<num> selectedIds = [];

  @override
  void initState() {
    _fillSelectedListWithPreSelectedValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailsCubit>();
    final CheckBoxAttributeModel model =
        CheckBoxAttributeModel(values: widget.attributeModel!.values);

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

    for (int i = 0; i < model.values!.length; i++) {
      if (widget.attributeModel!.currentValueList!.isNotEmpty) {
        if (widget.attributeModel!.currentValueList!
            .contains(widget.attributeModel!.values![i])) {
          if (!model.values![i].isPreSelected!) {
            widget.attributeModel!.currentValueList!.remove(model.values![i]);
          }
        } else {
          if (model.values![i].isPreSelected!) {
            widget.attributeModel!.currentValueList!.add(model.values![i]);
          }
        }
      } else {
        if (model.values![i].isPreSelected!) {
          widget.attributeModel!.currentValueList!.add(model.values![i]);
        }
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
          children: List<Widget>.generate(
            model.values!.length,
            (int index) {
              String priceValue = model.values![index].priceAdjustment == null
                  ? ''
                  : ' [${model.values![index].priceAdjustment}]';
              return Row(
                children: <Widget>[
                  Theme(
                    data: ThemeData(
                        checkboxTheme: CheckboxThemeData(
                      fillColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return AppColors.PRIMARY_COLOR_LIGHT;
                        } else
                          return AppColors.PRIMARY_COLOR_DARK;
                      }),
                      checkColor: MaterialStateProperty.all(
                          AppColors.GREY_BORDER_COLOR),
                    )),
                    child: Checkbox(
                      value: model.values![index].isPreSelected,
                      // focusNode: f3,
                      onChanged: (value) async {
                        FocusManager.instance.primaryFocus?.unfocus();

                        log('click check box and value is ${model.values![index].name}');
                        //here we add and remove from selected attributes list based on selected ids

                        //1. add to our list if box checked

                        var name = widget.attributeModel!.name;

                        if (value!) {
                          selectedIds.add(model.values![index].id!);

                          cubit.adjustProductPrice(
                              model.values![index].priceAdjustmentValue!);

                          if (name == 'Dots Between Initials' ||
                              name == 'النقاط بين الأحرف الأولى') {
                            cubit.createTextMessageDotsInitialStatus(true);
                          }
                        }
                        //2. remove from our list if box unchecked
                        else {
                          selectedIds.remove(model.values![index].id!);

                          cubit.adjustProductPrice(
                              (model.values![index].priceAdjustmentValue!) *
                                  -1);

                          if (name == 'Dots Between Initials' ||
                              name == 'النقاط بين الأحرف الأولى') {
                            cubit.createTextMessageDotsInitialStatus(false);
                          }
                        }

                        //3. add to API list if our list not empty

                        if (selectedIds.isNotEmpty) {
                          String selectedBoxes = '';
                          for (var element in selectedIds) {
                            selectedBoxes =
                                selectedBoxes + element.toString() + ',';
                          }

                          cubit.addToAttributeList({
                            'product_attribute_${widget.attributeModel!.id}':
                                selectedBoxes
                          });
                        }
                        //4. remove from API list if our list empty

                        else {
                          cubit.removeFromAttributeList(
                              'product_attribute_${widget.attributeModel!.id}');
                        }

                        //5. update ui

                        setState(() {
                          model.values![index].isPreSelected = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                        onTap: () async {
                          setState(() {});
                        },
                        child: TitleText(
                            text: model.values![index].name! + priceValue,
                            maxLines: 2)),
                  )
                ],
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

  void _fillSelectedListWithPreSelectedValues() {
    final cubit = context.read<ProductDetailsCubit>();

    for (var element in widget.attributeModel!.values!) {
      if (element.isPreSelected!) {
        selectedIds.add(element.id!);
        var name = widget.attributeModel!.name;
        if (name == 'Dots Between Initials' ||
            name == 'النقاط بين الأحرف الأولى') {
          cubit.createTextMessageDotsInitialStatus(true);
        }
      }

      if (selectedIds.isNotEmpty) {
        final cubit = context.read<ProductDetailsCubit>();
        String selectedBoxes = '';
        for (var element in selectedIds) {
          selectedBoxes = '$selectedBoxes$element,';
          cubit.adjustProductPrice((widget.attributeModel!.values!
              .firstWhere((e) => e.id == element)).priceAdjustmentValue!);
        }

        cubit.addToAttributeList(
            {'product_attribute_${widget.attributeModel!.id}': selectedBoxes});
      }
    }
  }
}
