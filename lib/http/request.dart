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

  static void setToken(String token) {
    _token = token;
  }

  /// Send a post request to the server with the given [url] and [body]
  static Future<Response> post<T>(String url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    try {
      headers
          ?.addAll(_token != null ? {'Authorization': 'Bearer $_token'} : {});

      final res = await http.post(Uri.http(config['domain']!, url),
          body: body,
          headers: headers,
          encoding: encoding ?? Encoding.getByName('utf-8'));

      return Response(res.statusCode, json.decode(utf8.decode(res.bodyBytes)));
    } catch (e) {
      throw Response(0, {});
    }
  }
}
