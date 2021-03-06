// Mocks generated by Mockito 5.1.0 from annotations
// in classroom_mobile/test/login_test.dart.
// Do not manually edit this file.

import 'dart:async';
import 'dart:convert';

import 'package:classroom_mobile/http/request.dart';
import 'package:mockito/mockito.dart';

class FakeResponse extends Fake implements Response {}

/// A class which mocks [Request].
///
/// See the documentation for Mockito's code generation for more information.
class MockRequest extends Mock implements Request {
  MockRequest() {
    throwOnMissingStub(this);
  }

  @override
  Future<Response> post(String? path,
          {Map<String, String>? headers = const {},
          Object? body,
          Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [path],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<Response>.value(FakeResponse()))
          as Future<Response>);
  @override
  Future<Response> get(
    String? path, {
    Map<String, String>? headers = const {},
    Encoding? encoding,
    Map<String, String>? queryParameters,
  }) =>
      (super.noSuchMethod(
              Invocation.method(#get, [
                path
              ], {
                #headers: headers,
                #encoding: encoding,
                #queryParameters: queryParameters
              }),
              returnValue: Future<Response>.value(FakeResponse()))
          as Future<Response>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
}
