import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/exceptions/exceed_file_size_limit_exception.dart';
import '../../core/utils/file_picker_helper.dart';
import '../../core/utils/navigator_helper.dart';
import '../../res/style/app_colors.dart';
import '../other/show_snack_bar.dart';
import 'package:size_helper/size_helper.dart';
import 'package:easy_localization/easy_localization.dart';

class UserProfileImagePicker extends StatefulWidget {
  const UserProfileImagePicker({
    Key? key,
    String? currentImage,
    bool normalImagePicker = false,
    bool isLarge = false,
    String? heroTag,
    ValueChanged<String>? onImageSelected,
  })  : assert(normalImagePicker || onImageSelected != null),
        _currentImage = currentImage,
        _normalImagePicker = normalImagePicker,
        _isLarge = isLarge,
        _heroTag = heroTag,
        _onImageSelected = onImageSelected,
        super(key: key);

  final String? _currentImage;
  final bool _normalImagePicker;
  final bool _isLarge;
  final String? _heroTag;
  final ValueChanged<String>? _onImageSelected;

  @override
  _UserProfileImagePickerState createState() => _UserProfileImagePickerState();
}

class _UserProfileImagePickerState extends State<UserProfileImagePicker> {
  String? _currentImage;

  @override
  void initState() {
    _currentImage = widget._currentImage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = context.sizeHelper(
      mobileLarge: 40.0,
      tabletNormal: 60.0,
      tabletLarge: 70.0,
      tabletExtraLarge: 100.0,
      desktopSmall: 110.0,
    );
    return Hero(
      tag: widget._heroTag ?? 'CurrentUserProfileTag',
      transitionOnUserGestures: true,
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          decoration: const BoxDecoration(shape: BoxShape.circle),
          width: widget._isLarge ? size * 2 : size,
          height: widget._isLarge ? size * 2 : size,
          alignment: Alignment.center,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              (_currentImage != null && _currentImage != '')
                  ? Padding(
                      padding: EdgeInsets.only(
                          bottom: !widget._normalImagePicker ? 20 : 0),
                      child: _buildImage(
                        context,
                        size: widget._isLarge ? size * 2 : size,
                        image: _currentImage!,
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                          bottom: !widget._normalImagePicker ? 20 : 0),
                      child: _buildDefaultIcon(
                          widget._isLarge ? size * 2 : size, context),
                    ),
              if (!widget._normalImagePicker) _buildPickImageIconButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(
    BuildContext context, {
    required double size,
    required String image,
  }) {
    final fromUrl = image.startsWith('http');
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: fromUrl
          ? Image.network(
              image,
              fit: BoxFit.cover,
            )
          : Image.file(
              File(image),
              fit: BoxFit.cover,
            ),
    );
  }

  Widget _buildDefaultIcon(double size, BuildContext context) {
    final iconSize = context.sizeHelper(
      mobileLarge: 20.0,
      tabletNormal: 24.0,
      desktopSmall: 28.0,
    );
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.PRIMARY_COLOR_DARK,
        shape: BoxShape.circle,
        border: Border.all(
            color: AppColors.PROFILE_CONTAINER_BORDER_COLOR, width: 4.0),
      ),
      child: SvgPicture.asset(
        'lib/res/assets/user_icon.svg',
        color: AppColors.PROFILE_EDIT_COLOR,
        width: iconSize,
        height: iconSize,
      ),
    );
  }

  Widget _buildPickImageIconButton(BuildContext context) {
    return PositionedDirectional(
      bottom: 32.0,
      end: 0.0,
      child: InkWell(
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.PROFILE_EDIT_COLOR,
          ),
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            'lib/res/assets/edit_icon.svg',
            color: AppColors.PROFILE_CONTAINER_BORDER_COLOR,
          ),
        ),
        onTap: _pickImage,
      ),
    );
  }

  void _pickImage() async {
    final imagePicker = await showImageTypeBottomSheet(context);
    if (imagePicker == null) return;

    try {
      final imagePath = await imagePicker.pick();

      widget._onImageSelected!(imagePath);

      setState(() => _currentImage = imagePath);
    } on ExceedFileSizeLimitException catch (e) {
      showSnackBar(
        context,
        message: 'image_exceed_size_limit' +
            (e.fileSizeLimit == null ? '' : ': 5mb'),
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<FilePickerHelper?> showImageTypeBottomSheet(BuildContext context) {
    return showCupertinoModalPopup<FilePickerHelper>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text('gallery'.tr()),
            onPressed: () =>
                NavigatorHelper.of(context).pop(FilePickerHelper.gallery()),
          ),
          CupertinoActionSheetAction(
            child: Text('camera'.tr()),
            onPressed: () =>
                NavigatorHelper.of(context).pop(FilePickerHelper.camera()),
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text('cancel'.tr()),
          isDestructiveAction: true,
          onPressed: NavigatorHelper.of(context).pop,
        ),
      ),
    );
  }
}
