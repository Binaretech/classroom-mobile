import 'dart:convert';

import 'package:classroom_mobile/config/config.dart';
import 'package:http/http.dart' as http;

/// This class manager the response data
class Response {
  final int statusCode;
  final Map<String, dynamic> data;

  Response(this.statusCode, this.data);
}

/// Manage the request to the server and return the response
class Request {
  final http.Client _client;

  Request({http.Client? client}) : _client = client ?? http.Client();

  static String? _token;

  static void setToken(String? token) {
    _token = token;
  }

  /// Send a post request to the server with the given [url] and [body]
  Future<Response> post(
    String path, {
    Map<String, String> headers = const {},
    Object? body,
    Encoding? encoding,
  }) async {
    try {
      final Map<String, String> requestHeaders = {}
        ..addAll(_token != null ? {'Authorization': 'Bearer $_token'} : {})
        ..addAll({'Content-Type': 'application/json'})
        ..addAll(headers);

      final res = await _client.post(formatUri(path),
          body: body,
          headers: requestHeaders,
          encoding: encoding ?? Encoding.getByName('utf-8'));

      return Response(res.statusCode, json.decode(utf8.decode(res.bodyBytes)));
    } catch (e) {
      throw Response(0, {});
    }
  }

  /// Send a post request to the server with the given [path] and [body]
  Future<Response> get(
    String path, {
    Map<String, String> headers = const {},
    Encoding? encoding,
  }) async {
    try {
      final Map<String, String> requestHeaders = {}
        ..addAll(_token != null ? {'Authorization': 'Bearer $_token'} : {})
        ..addAll(headers);

      final res = await _client.get(formatUri(path), headers: requestHeaders);

      return Response(
          res.statusCode,
          res.bodyBytes.isNotEmpty
              ? json.decode(utf8.decode(res.bodyBytes))
              : {});
    } catch (e) {
      throw Response(0, {});
    }
  }

  void close() {
    _client.close();
  }
}

class MultipartRequest {
  final http.MultipartRequest Function()? clientFactory;

  MultipartRequest({this.clientFactory});

  static String? _token;

  static void setToken(String? token) {
    _token = token;
  }

  http.MultipartRequest _generateClient(String method, String path) {
    if (clientFactory != null) {
      return clientFactory!();
    }

    return http.MultipartRequest(method, formatUri(path));
  }

  Future<Response> post(
    String path, {
    Map<String, String> headers = const {},
    Map<String, String>? body,
    Encoding? encoding,
    List<http.MultipartFile>? files,
  }) async {
    try {
      final Map<String, String> requestHeaders = {}
        ..addAll(_token != null ? {'Authorization': 'Bearer $_token'} : {})
        ..addAll(headers);

      final client = _generateClient('POST', path);

      client.headers.addAll(requestHeaders);

      if (body != null) {
        client.fields.addAll(body);
      }

      if (files != null) {
        client.files.addAll(files);
      }

      final res = await client.send();

      return Response(
          res.statusCode, json.decode(utf8.decode(await res.stream.toBytes())));
    } catch (e) {
      throw Response(0, {});
    }
  }
}

Uri formatUri(String path) {
  return Config.useHttps
      ? Uri.https(Config.domain, path)
      : Uri.http(Config.domain, path);
}
