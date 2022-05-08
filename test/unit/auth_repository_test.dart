import 'dart:convert';

import 'package:classroom_mobile/http/request.dart';
import 'package:classroom_mobile/repository/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/request.mocks.dart';

void main() {
  final client = MockRequest();

  group('Test auth repository', () {
    test('Test login', () async {
      final responseData = {
        'token': {
          'accessToken': 'test_token',
          'refreshToken': 'test_refresh_token',
          'accessExpires': DateTime.now().millisecondsSinceEpoch,
        }
      };

      final loginData = {'email': 'test@mail.com', 'password': 'test'};

      when(client.post('/auth/login',
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(loginData),
              encoding: null))
          .thenAnswer((_) async => Response(200, responseData));

      final repository = AuthRepository(client: client);

      final result = await repository.login(
          email: loginData['email']!, password: loginData['password']!);

      expect(result.token.accessToken, responseData['token']!['accessToken']);
    });
  });
}
