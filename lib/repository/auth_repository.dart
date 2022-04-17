import 'package:classroom_mobile/http/request.dart';
import 'package:classroom_mobile/models/file.dart';
import 'package:classroom_mobile/models/user.dart';
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
class UserResponse extends User {
  UserResponse({
    required String id,
    required String name,
    required String lastname,
    File? profileImage,
  }) : super(
          id: id,
          name: name,
          lastname: lastname,
          profileImage: profileImage,
        );

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>;

    final profileImage = user.containsKey('profileImage')
        ? File(
            id: user['profileImage']['ID'],
            key: user['profileImage']['key'],
            type: user['profileImage']['type'],
            bucket: user['profileImage']['bucket'],
            mimeType: user['profileImage']['mimeTYpe'],
            fileableType: user['profileImage']['fileableType'],
            fileableID: user['profileImage']['fileableID'])
        : null;

    return UserResponse(
      id: user['ID'],
      name: user['name'],
      lastname: user['lastname'],
      profileImage: profileImage,
    );
  }
}

/// Sends a request to login the user.
Future<AuthResponse> login(
    {required String email, required String password}) async {
  final response = await Request.post(
    '/auth/login',
    body: {
      'email': email,
      'password': password,
    },
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
