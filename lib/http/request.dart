import 'dart:convert';

import 'package:classroom_mobile/config/config.dart';
import 'package:classroom_mobile/globals.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Response {
  final int statusCode;
  final Map<String, dynamic> data;

  Response(this.statusCode, this.data);
}

class Request {
  static Future<Response> post<T>(String url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    try {
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
