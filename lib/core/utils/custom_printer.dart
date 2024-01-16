import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class CustomPrinter {
  static JsonEncoder encoder = const JsonEncoder.withIndent('  ');

  static logJsonResponsePretty({String? title, required dynamic response}) {
    if (response.runtimeType == Response<dynamic>) {
      String prettyResponse = encoder.convert(response.data);

      log('[$title] StatusCode: ${response.statusCode}');
      log('[$title] response:');
      log(prettyResponse);
    } else
      log(response.toString());
  }

  static logRequestPretty(
      {String? title,
      String? url,
      Map<String, dynamic>? params,
      required Map<String, dynamic> header}) {
    String prettyHeader = encoder.convert(header);

    log('[$title] url: $url');

    if (params != null) {
      String prettyParams = encoder.convert(params);

      log('[$title] params:');
      log(prettyParams);
    }

    log('[$title] headers:');
    log(prettyHeader);
  }
}
