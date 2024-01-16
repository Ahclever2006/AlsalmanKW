class ExceedFileSizeLimitException implements Exception {
  final String _message;
  int? fileSizeLimit;

  ExceedFileSizeLimitException({
    String? message,
    this.fileSizeLimit,
  }) : _message = message ?? 'Exceed file size limit';

  @override
  String toString() =>
      _message + (fileSizeLimit != null ? ': $fileSizeLimit' : '');
}
