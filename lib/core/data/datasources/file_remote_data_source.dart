import 'package:dio/dio.dart';

import '../../exceptions/request_exception.dart';
import '../../service/network_service.dart';
import '../../utils/url_helper.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

abstract class FileRemoteDataSource {
  ///returns `filePath`
  Future<String?> getFile({required String fileUrl, required String id});
}

class FileRemoteDataSourceImpl implements FileRemoteDataSource {
  final NetworkService _networkService;

  FileRemoteDataSourceImpl(this._networkService);
  @override
  Future<String?> getFile({required String fileUrl, required String id}) async {
    final ext = UrlHelper.getFileExtension(fileUrl);
    final downloadPath = await _createAttachmentFilePath(id, ext);
    //final newUrl = '${ApiEndPoint.filesUrlDomain}$fileUrl';
    final newUrl = fileUrl;
    final response = await _networkService.downloadFile(
        newUrl, downloadPath, ResponseType.bytes);
    if (response.statusCode != 200) throw RequestException(response.data);
    return downloadPath;
  }

  Future<String> _createAttachmentFilePath(String id, String ext) async {
    final directory = await path_provider.getApplicationDocumentsDirectory();
    return directory.path + '/Alsalman/$id.$ext';
  }
}
