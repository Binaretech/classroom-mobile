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
  static String? _token;

  static void setToken(String? token) {
    _token = token;
  }

  /// Send a post request to the server with the given [url] and [body]
  static Future<Response> post(
    String path, {
    Map<String, String> headers = const {},
    Object? body,
    Encoding? encoding,
  }) async {
    try {
      final Map<String, String> requestHeaders = {}
        ..addAll(_token != null ? {'Authorization': 'Bearer $_token'} : {})
        ..addAll(headers);

      final res = await http.post(_formatUri(path),
          body: body,
          headers: requestHeaders,
          encoding: encoding ?? Encoding.getByName('utf-8'));

      return Response(res.statusCode, json.decode(utf8.decode(res.bodyBytes)));
    } catch (e) {
      throw Response(0, {});
    }
  }

  static Future<Response> multipartPost(
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

      final req = http.MultipartRequest('POST', _formatUri(path));

      req.headers.addAll(requestHeaders);

      if (body != null) {
        req.fields.addAll(body);
      }

      if (files != null) {
        req.files.addAll(files);
      }

      final res = await req.send();

      return Response(
          res.statusCode, json.decode(utf8.decode(await res.stream.toBytes())));
    } catch (e) {
      throw Response(0, {});
    }
  }

  /// Send a post request to the server with the given [path] and [body]
  static Future<Response> get(
    String path, {
    Map<String, String> headers = const {},
    Encoding? encoding,
  }) async {
    try {
      final Map<String, String> requestHeaders = {}
        ..addAll(_token != null ? {'Authorization': 'Bearer $_token'} : {})
        ..addAll(headers);

      final res = await http.get(_formatUri(path), headers: requestHeaders);

      return Response(res.statusCode, json.decode(utf8.decode(res.bodyBytes)));
    } catch (e) {
      throw Response(0, {});
    }
  }

  static Uri _formatUri(String path) {
    return Config.useHttps
        ? Uri.https(Config.domain, path)
        : Uri.http(Config.domain, path);
  }
}
