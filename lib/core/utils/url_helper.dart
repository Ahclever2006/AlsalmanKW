abstract class UrlHelper {
  static String removeSignature(String url) => url.split('?').first;

  static String getFileName(String url) {
    url = removeSignature(url);
    final fileNameWithExtension = url.split('/').last.split('.');
    final fileName = (fileNameWithExtension..removeLast()).join('.');
    return fileName;
  }

  static String getFileExtension(String url) {
    url = removeSignature(url);
    final fileNameWithExtension = url.split('/').last.split('.');
    return fileNameWithExtension.last;
  }
}
