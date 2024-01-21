import 'dart:io';

import 'package:path_provider/path_provider.dart' as path_provider;

abstract class FileLocalDataSource {
  ///returns `filePath`
  Future<String?> getFile({required String id});
}

class FileLocalDataSourceImpl implements FileLocalDataSource {
  @override
  Future<String?> getFile({required String id}) async {
    final filePath = await _getAttachmentFilePath(id, 'pdf');
    final file = File(filePath);
    if (!(await file.exists())) return null;
    return filePath;
  }

  Future<String> _getAttachmentFilePath(String id, String ext) async {
    final directory = await path_provider.getApplicationDocumentsDirectory();
    return '${directory.path}/Baqah/orderDetails$id.$ext';
  }
}
