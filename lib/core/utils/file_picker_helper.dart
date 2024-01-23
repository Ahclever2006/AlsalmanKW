import 'package:image_picker/image_picker.dart';

abstract class FilePickerHelper {
  static const _compressionPercentage = 40;

  ///returns `filePath`
  Future<String> pick();

  FilePickerHelper();

  factory FilePickerHelper.gallery() => _GalleryPicker();

  factory FilePickerHelper.camera() => _CameraPicker();
}

class _GalleryPicker extends FilePickerHelper {
  @override
  Future<String> pick() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: FilePickerHelper._compressionPercentage,
    );

    if (pickedImage == null) throw Exception('User didn\'t pick an image');

    // final imageSize = await pickedImage.length();

    // const fileSizeLimitAfterCompression =
    //     (FileSize.size5MB * FilePickerHelper._compressionPercentage) / 350;

    // if (imageSize > fileSizeLimitAfterCompression)
    //   throw ExceedFileSizeLimitException(fileSizeLimit: FileSize.size5MB);

    return pickedImage.path;
  }
}

class _CameraPicker extends FilePickerHelper {
  @override
  Future<String> pick() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: FilePickerHelper._compressionPercentage,
    );

    if (pickedImage == null) throw Exception('User didn\'t pick an image');

    // final imageSize = await pickedImage.length();

    // const fileSizeLimitAfterCompression =
    //     (FileSize.size5MB * FilePickerHelper._compressionPercentage) / 350;

    // if (imageSize > fileSizeLimitAfterCompression)
    //   throw ExceedFileSizeLimitException(fileSizeLimit: FileSize.size5MB);

    return pickedImage.path;
  }
}
