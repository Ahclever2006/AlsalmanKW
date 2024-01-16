class LauncherException implements Exception {
  final String _message;

  LauncherException([message])
      : _message = (message ??= 'Failed') is String
            ? message
            : message is List
                ? message.join(',\n')
                : message.toString();

  @override
  String toString() => _message;
}
