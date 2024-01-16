// import 'dart:developer';
// import 'dart:io';

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:size_helper/size_helper.dart';

// import '../../core/exceptions/exceed_file_size_limit_exception.dart';
// import '../../core/utils/file_picker_helper.dart';
// import '../../core/utils/navigator_helper.dart';
// import '../../res/style/app_colors.dart';
// import '../other/show_snack_bar.dart';

// class UserProfileImagePicker extends StatefulWidget {
//   const UserProfileImagePicker({
//     Key? key,
//     String? currentImage,
//     bool normalImagePicker = false,
//     ValueChanged<String>? onImageSelected,
//   })  : assert(normalImagePicker || onImageSelected != null),
//         _currentImage = currentImage,
//         _normalImagePicker = normalImagePicker,
//         _onImageSelected = onImageSelected,
//         super(key: key);

//   final String? _currentImage;
//   final bool _normalImagePicker;
//   final ValueChanged<String>? _onImageSelected;

//   @override
//   _UserProfileImagePickerState createState() => _UserProfileImagePickerState();
// }

// class _UserProfileImagePickerState extends State<UserProfileImagePicker> {
//   String? _currentImage;

//   @override
//   void initState() {
//     _currentImage = widget._currentImage;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = context.sizeHelper(
//       mobileLarge: 100.0,
//       tabletNormal: 120.0,
//       tabletLarge: 150.0,
//       tabletExtraLarge: 170.0,
//       desktopSmall: 190.0,
//     );
//     return Hero(
//       tag: 'CurrentUserProfileTag',
//       transitionOnUserGestures: true,
//       child: Material(
//         type: MaterialType.transparency,
//         child: Container(
//           width: size + 20.0,
//           height: size + 20.0,
//           alignment: Alignment.center,
//           child: Stack(
//             clipBehavior: Clip.none,
//             alignment: Alignment.center,
//             children: [
//               (_currentImage != null && _currentImage != '')
//                   ? _buildImage(
//                       context,
//                       size: size,
//                       image: _currentImage!,
//                     )
//                   : _buildDefaultIcon(size, context),
//               if (!widget._normalImagePicker) _buildPickImageIconButton(context)
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildImage(
//     BuildContext context, {
//     required double size,
//     required String image,
//   }) {
//     final fromUrl = image.startsWith('http');
//     return Container(
//       width: size,
//       height: size,
//       decoration: BoxDecoration(
//         color: Colors.lightBlue[50],
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20.0),
//         child: fromUrl
//             ? Image.network(
//                 image,
//                 fit: BoxFit.cover,
//               )
//             : Image.file(
//                 File(image),
//                 fit: BoxFit.cover,
//               ),
//       ),
//     );
//   }

//   Widget _buildDefaultIcon(double size, BuildContext context) {
//     final iconSize = context.sizeHelper(
//       mobileLarge: 28.0,
//       tabletNormal: 32.0,
//       desktopSmall: 38.0,
//     );
//     return Container(
//       width: size,
//       height: size,
//       padding: const EdgeInsets.all(24.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       child: SvgPicture.asset(
//         'lib/res/assets/user_icon.svg',
//         width: iconSize,
//         height: iconSize,
//       ),
//     );
//   }

//   Widget _buildPickImageIconButton(BuildContext context) {
//     final size = context.sizeHelper(
//       mobileLarge: 26.0,
//       tabletNormal: 30.0,
//       desktopSmall: 34.0,
//     );
//     return PositionedDirectional(
//       end: -10.0,
//       top: -10.0,
//       child: InkWell(
//         child: Container(
//           decoration: const BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(8.0)),
//             color: AppColors.BACKGROUND_COLOR,
//           ),
//           padding: const EdgeInsets.all(4.0),
//           child: SvgPicture.asset(
//             'lib/res/assets/camera_icon.svg',
//             width: size,
//             height: size,
//           ),
//         ),
//         onTap: _pickImage,
//       ),
//     );
//   }

//   void _pickImage() async {
//     final imagePicker = await showImageTypeBottomSheet(context);
//     if (imagePicker == null) return;

//     try {
//       final imagePath = await imagePicker.pick();

//       widget._onImageSelected!(imagePath);

//       setState(() => _currentImage = imagePath);
//     } on ExceedFileSizeLimitException catch (e) {
//       showSnackBar(
//         context,
//         message: 'image_exceed_size_limit' +
//             (e.fileSizeLimit == null ? '' : ': 5mb'),
//       );
//     } catch (e) {
//       log(e.toString());
//     }
//   }

//   Future<FilePickerHelper?> showImageTypeBottomSheet(BuildContext context) {
//     return showCupertinoModalPopup<FilePickerHelper>(
//       context: context,
//       builder: (BuildContext context) => CupertinoActionSheet(
//         actions: [
//           CupertinoActionSheetAction(
//             child: Text('gallery'.tr()),
//             onPressed: () =>
//                 NavigatorHelper.of(context).pop(FilePickerHelper.gallery()),
//           ),
//           CupertinoActionSheetAction(
//             child: Text('camera'.tr()),
//             onPressed: () =>
//                 NavigatorHelper.of(context).pop(FilePickerHelper.camera()),
//           )
//         ],
//         cancelButton: CupertinoActionSheetAction(
//           child: Text('cancel'.tr()),
//           isDestructiveAction: true,
//           onPressed: NavigatorHelper.of(context).pop,
//         ),
//       ),
//     );
//   }
// }
