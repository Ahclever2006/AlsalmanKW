import 'package:flutter/material.dart';

import '../../features/product_details/data/model/product_details_model.dart';
import '../../res/style/app_colors.dart';
import '../stateless/subtitle_text.dart';

class MessageCardDesignChooser extends StatefulWidget {
  const MessageCardDesignChooser(
      {required this.values,
      required this.productAttributeId,
      required this.onPress,
      super.key});

  final List<Value>? values;
  final int productAttributeId;
  final ValueChanged<Map<String, String>> onPress;

  @override
  State<MessageCardDesignChooser> createState() =>
      _MessageCardDesignChooserState();
}

class _MessageCardDesignChooserState extends State<MessageCardDesignChooser> {
  int? selectedId;

  Map<String, String> chosenData = {};

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: widget.values!.map(
      (e) {
        var isSelected = selectedId == e.id;
        return InkWell(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.PRIMARY_COLOR : Colors.white,
              border: Border.all(color: AppColors.PRIMARY_COLOR),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: SubtitleText(
              text: e.name ?? '',
              color: isSelected ? Colors.white : AppColors.PRIMARY_COLOR_DARK,
            ),
          ),
          onTap: () {
            chosenData.clear();
            chosenData.addAll(
                {"product_attribute_${widget.productAttributeId}": "${e.id}"});
            widget.onPress(chosenData);
            setState(() {
              selectedId = e.id;
            });
          },
        );
      },
    ).toList());
  }
}
