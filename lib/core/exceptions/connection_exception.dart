import 'package:dio/dio.dart';

class ConnectionException implements Exception {
  final String _message;

  ConnectionException(message)
      : _message = (message ??= 'Failed') is String
            ? message
            : message is List
                ? message.join(',\n')
                : message is DioError
                    ? _returnMessage(message)
                    : message.toString();

  @override
  String toString() => _message;

  static String _returnMessage(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.connectTimeout:
        return 'Connection timeout with ApiServer';
      case DioErrorType.sendTimeout:
        return 'Send timeout with ApiServer';
      case DioErrorType.receiveTimeout:
        return 'Receive timeout with ApiServer';
      case DioErrorType.response:
        return _returnMessageFromDioResponse(dioError);
      case DioErrorType.cancel:
        return 'Request to ApiServer was canceled';
      case DioErrorType.other:
        if (dioError.message.contains('SocketException')) {
          return 'No Internet Connection';
        }
        return 'Unexpected Error, Please try again!';
      default:
        return 'Opps There was an Error, Please try again';
    }
  }

  static String _returnMessageFromDioResponse(DioError dioError) {
    var statusCode = dioError.response!.statusCode;
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return dioError.response!.data['error']['message'];
    } else if (statusCode == 404) {
      return 'Your request not found, Please try later!';
    } else if (statusCode == 500) {
      return 'Internal Server error, Please try later';
    } else {
      return 'Opps There was an Error, Please try again';
    }
  }
}
