import 'package:classroom_mobile/http/request.dart';
import 'package:classroom_mobile/repository/models/user.dart';
import 'package:classroom_mobile/repository/repository.dart';

class AuthResponse {
  final Token token;

  AuthResponse(this.token);

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(Token.fromJson(json['token']));
  }
}

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
