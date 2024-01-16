import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../res/style/app_colors.dart';
import '../../../../../shared_widgets/stateful/default_button.dart';
import '../../../data/model/attributes/file_chooser_attribute_model.dart';
import '../../../data/model/product_details_model.dart';
import '../../blocs/cubit/product_details_cubit.dart';

class FilePickerAttributes extends StatefulWidget {
  const FilePickerAttributes({Key? key, required this.attributeModel})
      : super(key: key);
  final ProductAttribute? attributeModel;
  @override
  State<FilePickerAttributes> createState() => _FilePickerAttributesState();
}

class _FilePickerAttributesState extends State<FilePickerAttributes> {
  bool fileAlreadyUploaded = false;
  String? fileName;
  String? filePath;
  String? fileExtension;
  @override
  Widget build(BuildContext context) {
    final FileChooserAttributeModel model =
        FileChooserAttributeModel(label: 'choose file');

    final Widget notRequiredTitle = Text(
      widget.attributeModel!.name!,
      style: Theme.of(context).textTheme.bodyText1,
    );
    final Widget requiredTitle = Row(
      children: <Widget>[
        Expanded(
          child: Text(
            widget.attributeModel!.name!,
            style: Theme.of(context).textTheme.bodyText1,
          ),
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
        DefaultButton(
          onPressed: () async {
            return chooseFile(
                context, model, widget.attributeModel!.id.toString());
          },
          backgroundColor: AppColors.PRIMARY_COLOR,
          label:
              !fileAlreadyUploaded ? 'upload_file'.tr() : 'file_uploaded'.tr(),
          margin: const EdgeInsets.all(16.0),
          isExpanded: true,
        ),
        if (fileAlreadyUploaded)
          Text(
            'File Name: $fileName',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        if (fileAlreadyUploaded &&
            (fileExtension == 'jpg' ||
                fileExtension == 'png' ||
                fileExtension == 'jpeg'))
          Align(
            alignment: Alignment.center,
            child: Image.file(
              File(filePath!),
              // height: 180.0,
              width: 120.0,
              //fit: BoxFit.cover,
            ),
          ),
      ],
    );
  }

  Future chooseFile(
      BuildContext context, FileChooserAttributeModel model, String id) async {
    final cubit = context.read<ProductDetailsCubit>();

    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.any);
      if (result != null) filePath = result.files.single.path!;
      if (filePath != null && filePath!.isNotEmpty) {
        final File file = File(filePath!);
        final result = await cubit.uploadProductFile(id, file);
        setState(() {
          fileAlreadyUploaded = result;
          fileName = filePath!.split('/').last;
          fileExtension = fileName!.split('.').last.toLowerCase();
        });
      }
    } catch (e) {
      log('error is');
      log(e.toString());
    }
  }
}
