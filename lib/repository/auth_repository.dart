import 'package:classroom_mobile/http/request.dart';
import 'package:classroom_mobile/repository/models/user.dart';
import 'package:classroom_mobile/repository/repository.dart';

/// Represents the auth response.
class AuthResponse {
  final Token token;

  AuthResponse(this.token);

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(Token.fromJson(json['token']));
  }
}

/// Represents a response with the user data.
class UserResponse {
  final String id;
  final String name;
  final String lastname;

  UserResponse(this.id, this.name, this.lastname);

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(json['id'], json['name'], json['lastname']);
  }
}

/// Sends a request to login the user.
Future<AuthResponse> login(
    {required String email, required String password}) async {
  final response = await Request.post('/auth/login', body: {
    'email': email,
    'password': password,
  });

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
  final response = await Request.post('/auth/register', body: {
    'email': email,
    'password': password,
  });

  if (hasResponseErrors(response)) {
    throw Exception(response);
  }

  return AuthResponse.fromJson(response.data);
}

/// Sends a request to store user data.
Future<UserResponse> registerUserInfo({
  required String name,
  required String lastname,
}) async {
  final response = await Request.post('/api/user', body: {
    'name': name,
    'lastname': lastname,
  });

  if (hasResponseErrors(response)) {
    throw Exception(response);
  }

  return UserResponse.fromJson(response.data);
}
