import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:requests_inspector/requests_inspector.dart';

// import '../../features/splash/presentation/pages/splash_page.dart';
// import '../../api_end_point.dart';
import '../../main.dart';
import '../exceptions/connection_exception.dart';
import '../exceptions/redundant_request_exception.dart';
import '../utils/custom_printer.dart';
import 'cache_service.dart';
// import '../exceptions/request_exception.dart';

CancelToken cancelToken = CancelToken();

abstract class NetworkService {
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  });

  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  });

  Future<Response> patch(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  });

  Future<Response> put(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  });

  Future<Response> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  });

  Future<Response> downloadFile(
    String apiBaseUrl,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<Uint8List> readBytes(String apiBaseUrl);

  Future<Map<String, dynamic>> getDefaultHeaders([String? language]);

  Map<String, dynamic>? formatQueryIfNeeded(
    Map<String, dynamic>? queryParameters,
  );
}

class NetworkServiceImpl implements NetworkService {
  NetworkServiceImpl(this._networkServiceUtil);

  final NetworkServiceUtil _networkServiceUtil;

  final _dio = Dio(BaseOptions(
      contentType: Headers.jsonContentType, validateStatus: (_) => true))
    ..interceptors.add(inspectorEnabled
        ? RequestsInspectorInterceptor()
        : const Interceptor());

  String? _requestName;

  final _pendingRequests = <String>[];

  @override
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    _requestName = _extractName(url);
    headers ??= await getDefaultHeaders();
    final requestId = _generateRequestId(
        url: url, queryParameters: queryParameters, headers: headers);
    if (_pendingRequests.contains(requestId)
        //  &&
        //     !requestId.contains('homepageslider')
        )
      throw RedundantRequestException('Request is already pending for $url');

    _pendingRequests.add(requestId);
    return _connectionExceptionCatcher(() => _get(
          url,
          queryParameters: formatQueryIfNeeded(queryParameters),
          headers: headers!,
          cancelToken: cancelToken,
        )).whenComplete(() => _pendingRequests.remove(requestId));
  }

  @override
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    _requestName = _extractName(url);
    headers ??= await getDefaultHeaders();
    final requestId = _generateRequestId(
        url: url,
        queryParameters: queryParameters,
        headers: headers,
        data: data);
    if (_pendingRequests.contains(requestId))
      throw RedundantRequestException('Request is already pending for $url');

    _pendingRequests.add(requestId);
    return _connectionExceptionCatcher(() => _post(
          url,
          queryParameters: formatQueryIfNeeded(queryParameters),
          data: data,
          headers: headers!,
          cancelToken: cancelToken,
        )).whenComplete(() => _pendingRequests.remove(requestId));
  }

  @override
  Future<Response> patch(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    _requestName = _extractName(url);
    headers ??= await getDefaultHeaders();
    final requestId = _generateRequestId(
        url: url,
        queryParameters: queryParameters,
        headers: headers,
        data: data);
    if (_pendingRequests.contains(requestId))
      throw RedundantRequestException('Request is already pending for $url');

    _pendingRequests.add(requestId);
    return _connectionExceptionCatcher(() => _patch(
          url,
          queryParameters: formatQueryIfNeeded(queryParameters),
          data: data,
          headers: headers!,
          cancelToken: cancelToken,
        )).whenComplete(() => _pendingRequests.remove(requestId));
  }

  @override
  Future<Response> put(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    _requestName = _extractName(url);
    headers ??= await getDefaultHeaders();
    final requestId = _generateRequestId(
        url: url,
        queryParameters: queryParameters,
        headers: headers,
        data: data);
    if (_pendingRequests.contains(requestId))
      throw RedundantRequestException('Request is already pending for $url');

    _pendingRequests.add(requestId);
    return _connectionExceptionCatcher(() => _put(
          url,
          queryParameters: formatQueryIfNeeded(queryParameters),
          data: data,
          headers: headers!,
          cancelToken: cancelToken,
        )).whenComplete(() => _pendingRequests.remove(requestId));
  }

  @override
  Future<Response> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    _requestName = _extractName(url);
    headers ??= await getDefaultHeaders();
    final requestId = _generateRequestId(
        url: url,
        queryParameters: queryParameters,
        headers: headers,
        data: data);
    if (_pendingRequests.contains(requestId))
      throw RedundantRequestException('Request is already pending for $url');

    _pendingRequests.add(requestId);
    return _connectionExceptionCatcher(() => _delete(
          url,
          queryParameters: formatQueryIfNeeded(queryParameters),
          data: data,
          headers: headers!,
          cancelToken: cancelToken,
        )).whenComplete(() => _pendingRequests.remove(requestId));
  }

  String _generateRequestId({
    url,
    queryParameters,
    headers,
    data,
  }) =>
      '${url ?? ''}${queryParameters ?? ''}${headers ?? ''}${data ?? ''}';

  String _extractName(String url) {
    url = url.split('?').first;
    final name = url.split('/').last;
    return name.toUpperCase();
  }

  Future<Response> _get(
    String apiBaseUrl, {
    Map<String, dynamic>? queryParameters,
    required Map<String, dynamic> headers,
    CancelToken? cancelToken,
  }) async {
    final requestName = _requestName;
    _logRequest(requestName, apiBaseUrl, queryParameters, headers);
    var response = await _dio.get(apiBaseUrl,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        cancelToken: cancelToken);
    _logResponse(requestName, response);

    // if ([401, 403].contains(response.statusCode))
    //   response = (await _refreshToken((_) async {
    //     _requestName = requestName!;
    //     return _get(
    //       apiBaseUrl,
    //       queryParameters: queryParameters,
    //       headers: await _updateHeaderWithNewToken(headers),
    //     );
    //   }))!;

    _requestName = null;
    return response;
  }

  @override
  Future<Uint8List> readBytes(String apiBaseUrl) {
    final url = Uri.parse(apiBaseUrl);
    return http.readBytes(url);
  }

  Future<Response> _post(
    String apiBaseUrl, {
    Map<String, dynamic>? queryParameters,
    data,
    required Map<String, dynamic> headers,
    CancelToken? cancelToken,
  }) async {
    final requestName = _requestName;
    _logRequest(requestName, apiBaseUrl, queryParameters, headers, data);
    var response = await _dio.post(apiBaseUrl,
        queryParameters: queryParameters,
        data: data,
        options: Options(headers: headers),
        cancelToken: cancelToken);
    _logResponse(requestName, response);

    // if ([401, 403].contains(response.statusCode))
    //   response = (await _refreshToken((_) async {
    //     _requestName = requestName!;
    //     return _post(
    //       apiBaseUrl,
    //       queryParameters: queryParameters,
    //       data: data,
    //       headers: await _updateHeaderWithNewToken(headers),
    //     );
    //   }))!;

    _requestName = null;
    return response;
  }

  Future<Response> _patch(
    String apiBaseUrl, {
    Map<String, dynamic>? queryParameters,
    data,
    required Map<String, dynamic> headers,
    CancelToken? cancelToken,
  }) async {
    final requestName = _requestName;
    _logRequest(requestName, apiBaseUrl, queryParameters, headers, data);
    var response = await _dio.patch(apiBaseUrl,
        queryParameters: queryParameters,
        data: data,
        options: Options(headers: headers),
        cancelToken: cancelToken);
    _logResponse(requestName, response);

    // if ([401, 403].contains(response.statusCode))
    //   response = (await _refreshToken((_) async {
    //     _requestName = requestName!;
    //     return _patch(
    //       apiBaseUrl,
    //       queryParameters: queryParameters,
    //       data: data,
    //       headers: await _updateHeaderWithNewToken(headers),
    //     );
    //   }))!;

    _requestName = null;
    return response;
  }

  Future<Response> _put(
    String apiBaseUrl, {
    Map<String, dynamic>? queryParameters,
    data,
    required Map<String, dynamic> headers,
    CancelToken? cancelToken,
  }) async {
    final requestName = _requestName;
    _logRequest(requestName, apiBaseUrl, queryParameters, headers, data);
    var response = await _dio.put(apiBaseUrl,
        queryParameters: queryParameters,
        data: data,
        options: Options(headers: headers),
        cancelToken: cancelToken);
    _logResponse(requestName, response);

    // if ([401, 403].contains(response.statusCode))
    //   response = (await _refreshToken((_) async {
    //     _requestName = requestName!;
    //     return _put(
    //       apiBaseUrl,
    //       queryParameters: queryParameters,
    //       data: data,
    //       headers: await _updateHeaderWithNewToken(headers),
    //     );
    //   }))!;

    _requestName = null;
    return response;
  }

  Future<Response> _delete(
    String apiBaseUrl, {
    Map<String, dynamic>? queryParameters,
    data,
    required Map<String, dynamic> headers,
    CancelToken? cancelToken,
  }) async {
    final requestName = _requestName;
    _logRequest(requestName, apiBaseUrl, queryParameters, headers, data);
    var response = await _dio.delete(apiBaseUrl,
        queryParameters: queryParameters,
        data: data,
        options: Options(headers: headers),
        cancelToken: cancelToken);
    _logResponse(requestName, response);

    // if ([401, 403].contains(response.statusCode))
    //   response = (await _refreshToken((_) async {
    //     _requestName = requestName!;
    //     return _delete(
    //       apiBaseUrl,
    //       queryParameters: queryParameters,
    //       headers: await _updateHeaderWithNewToken(headers),
    //     );
    //   }))!;

    _requestName = null;
    return response;
  }

  void _logRequest(
    String? requestName,
    String apiBaseUrl,
    Map<String, dynamic>? params,
    Map<String, dynamic> headers, [
    data,
  ]) {
    if (requestName == null) return;

    CustomPrinter.logRequestPretty(
      header: headers,
      params: params,
      url: apiBaseUrl,
      title: requestName,
    );
    if (data != null)
      log('[$requestName] body: ${data is FormData ? Map.fromEntries([
              ...data.fields,
              ...data.files
            ]) : data}');
  }

  void _logResponse(String? requestName, Response<dynamic> response) {
    if (requestName == null) return;

    CustomPrinter.logJsonResponsePretty(title: requestName, response: response);
  }

  @override
  Future<Response> downloadFile(
    String apiBaseUrl,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return _dio.download(apiBaseUrl, savePath);
  }

  @override
  Future<Map<String, dynamic>> getDefaultHeaders([String? language]) async {
    final accessToken = await _networkServiceUtil.getCurrentAccessToken();
    final languageCode =
        await _networkServiceUtil.getLanguageCode() ?? language ?? 'en';
    const clientId = 'f93deb7e-56d9-4142-bb4e-c313781bfce6';
    final headers = <String, String>{
      if (accessToken != null) 'Authorization': 'Bearer $accessToken',
      'language': languageCode,
      'client_id': clientId,
      'Accept': '*/*',
    };

    return headers;
  }

  Future<T> _connectionExceptionCatcher<T>(Future<T> Function() request) async {
    try {
      return await request();
    } catch (e) {
      var message = e.toString();
      if (message.contains('SocketException') ||
          message.contains('HttpException'))
        throw ConnectionException('connection_error');
      rethrow;
    }
  }

  //This is a workaround for saving http request from requesting the refresh access token multiple times at the same time.
  //By making all http requests wait until the first refresh request done.
  //and then resend pending requests with the new access token.
  // Future? _alreadyRequestedFuture;

  // Future<T?> _refreshToken<T>(Future<T> Function(void) onSuccess) async {
  //   if (_alreadyRequestedFuture != null)
  //     return _alreadyRequestedFuture!
  //         .then(onSuccess)
  //         .whenComplete(() => _alreadyRequestedFuture = null);
  //   const url = ApiEndPoint.login;
  //   final headers = (await getDefaultHeaders())..remove('Authorization');
  //   final body = await _createRefreshTokenBody();

  //   _logRequest('REFRESHTOKEN', url, headers, body);

  //   final refreshRequest = _dio
  //       .post(url, data: body, options: Options(headers: headers))
  //       .then((response) {
  //     _logResponse('REFRESHTOKEN', response);

  //     if (response.statusCode == 200)
  //       return _updateCurrentTokens(response.data['data'])
  //           .then(onSuccess)
  //           .whenComplete(() => _alreadyRequestedFuture = null);

  //     if ([401, 403].contains(response.statusCode))
  //       return _logout().then(
  //         (_) {
  //           _navigateToLoginPage();
  //           _alreadyRequestedFuture = null;
  //           throw RequestException('session_expired');
  //         },
  //       );

  //     throw RequestException(response.data);
  //   });
  //   _alreadyRequestedFuture = refreshRequest;

  //   return refreshRequest.then((value) => value);
  // }

  // Future<void> _navigateToLoginPage() => navigatorKey.currentState!
  //     //TODO: check where to go
  //     .pushNamedAndRemoveUntil(SplashPage.routeName, (route) => false);

  // Future<Map<String, String>> _createRefreshTokenBody() async {
  //   final accessToken = await _networkServiceUtil.getCurrentAccessToken();
  //   final refreshToken = await _networkServiceUtil.getCurrentRefreshToken();
  //   return {
  //     if (accessToken != null) 'accessToken': accessToken,
  //     if (refreshToken != null) 'refreshToken': refreshToken,
  //   };
  // }

  // Future<void> _updateCurrentTokens(Map data) =>
  //     _networkServiceUtil.updateCurrentTokens(
  //       accessToken: data['token'],
  //       refreshToken: data['refresh_token'],
  //       expireDate: data['expire_date'],
  //     );

  // Future<void> _logout() => _networkServiceUtil.clearCurrentUserData();

  // Future<Map<String, dynamic>> _updateHeaderWithNewToken(
  //     Map<String, dynamic> headers) async {
  //   final newHeaders = await getDefaultHeaders();
  //   headers['Authorization'] = newHeaders['Authorization'];
  //   return headers;
  // }

  @override
  Map<String, dynamic>? formatQueryIfNeeded(
    Map<String, dynamic>? queryParameters,
  ) {
    if (queryParameters == null) return null;
    final newQueryParameters = <String, dynamic>{};

    for (final entry in queryParameters.entries) {
      if (entry.value is Map || entry.value is List) {
        final newEntries = _extractNormalEntriesFromMap(entry.key, entry.value);
        newQueryParameters.addEntries(newEntries);
      } else
        newQueryParameters[entry.key] = entry.value;
    }

    return newQueryParameters;
  }

  List<MapEntry<String, dynamic>> _extractNormalEntriesFromMap(
    String key,
    value,
  ) {
    if (value is! Map && value is! List) return [MapEntry(key, value)];

    final newEntries = <MapEntry<String, dynamic>>[];

    if (value is List)
      for (var i = 0; i < value.length; i++) {
        final item = value[i];
        if (item is! List && item is! Map)
          newEntries.add(MapEntry('$key[$i]', item));
        else
          newEntries.addAll(_extractNormalEntriesFromMap('$key[$i]', item));
      }
    else if (value is Map)
      for (var entry in value.entries) {
        if (entry.value is! Map && entry.value is! List)
          newEntries.add(MapEntry('$key.${entry.key}', entry.value));
        else
          newEntries.addAll(
              _extractNormalEntriesFromMap('$key.${entry.key}', entry.value));
      }

    return newEntries;
  }
}

abstract class NetworkServiceUtil {
  Future<String?> getCurrentAccessToken();
  Future<String?> getCurrentRefreshToken();
  Future<String?> getLanguageCode();
  Future<void> updateCurrentTokens({
    String? accessToken,
    String? refreshToken,
    String? expireDate,
  });
  Future<void> clearCurrentUserData();
}

///Used only as a helper inside NetworkService to handle tokens and language code.
///DONT: use it outside the NetworkService.
class NetworkServiceUtilImpl implements NetworkServiceUtil {
  NetworkServiceUtilImpl(this._cacheService);
  final CacheService _cacheService;
  @override
  Future<String?> getCurrentAccessToken() async {
    final token = await _cacheService.getUserToken();
    if (token == null) return null;
    return token;
  }

  @override
  Future<String?> getCurrentRefreshToken() async {
    final refreshToken = await _cacheService.getUserRefreshToken();
    if (refreshToken == null) return null;
    return refreshToken;
  }

  @override
  Future<String?> getLanguageCode() async {
    final languageString = await _cacheService.getLanguageCode();
    if (languageString == null) return null;
    final languageCode = languageString.split('_').first;
    return languageCode;
  }

  @override
  Future<void> updateCurrentTokens({
    String? accessToken,
    String? refreshToken,
    String? expireDate,
  }) async {
    await _cacheService.saveUserRefreshToken(refreshToken!);
    await _cacheService.saveUserToken(accessToken!);
    await _cacheService.saveUserTokenExpirationDate(expireDate!);
  }

  @override
  Future<void> clearCurrentUserData() => _cacheService.clearUserData();
}
