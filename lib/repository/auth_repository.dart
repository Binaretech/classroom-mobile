import 'dart:convert';

import 'package:classroom_mobile/http/request.dart';
import 'package:classroom_mobile/repository/resources/user.dart';
import 'package:classroom_mobile/repository/repository.dart';

class AuthRepository extends Repository {
  final Request _client;

  AuthRepository({Request? client}) : _client = client ?? Request();

  /// Sends a request to login the user.
  Future<AuthResponse> login(
      {required String email, required String password}) async {
    final response = await _client.post(
      '/auth/login',
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (hasResponseErrors(response)) {
      throw Exception(response);
    }

    return AuthResponse.fromJson(response.data);
  }

  /// Sends a request to register the user.
  Future<AuthResponse> register({
    required String email,
    required String password,
  }) async {
    final response = await _client.post(
      '/auth/register',
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (hasResponseErrors(response)) {
      throw Exception(response);
    }

    return AuthResponse.fromJson(response.data);
  }

  Future<AuthResponse> googleSignIn({required String idToken}) async {
    final response = await _client.post(
      '/auth/google',
      body: jsonEncode({'idToken': idToken}),
    );

    if (hasResponseErrors(response)) {
      throw Exception(response);
    }

    return AuthResponse.fromJson(response.data);
  }

  void close() {
    _client.close();
  }
}

/// Represents the auth response.
class AuthResponse {
  final Token token;

  AuthResponse(this.token);

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(Token.fromJson(json['token']));
  }
}
