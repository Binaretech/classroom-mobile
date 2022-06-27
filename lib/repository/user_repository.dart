import 'dart:io' as io;

import 'package:classroom_mobile/http/request.dart';
import 'package:classroom_mobile/models/file.dart';
import 'package:classroom_mobile/models/user.dart';
import 'package:classroom_mobile/repository/repository.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class UserRepository extends Repository {
  final Request _client;

  final MultipartRequest? _multipartClient;

  UserRepository({Request? client, MultipartRequest? multipartClient})
      : _client = client ?? Request(),
        _multipartClient = multipartClient ?? MultipartRequest();

  /// Sends a request to store user data.
  Future<UserResponse> registerUserInfo({
    required String name,
    required String lastname,
  }) async {
    final response = await _client.post(
      '/api/user',
      body: {
        'name': name,
        'lastname': lastname,
      },
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (hasResponseErrors(response)) {
      throw Exception(response);
    }

    return UserResponse.fromJson(response.data);
  }

  Future<UserResponse?> getUser() async {
    final response = await _client.get('/api/user');

    if (response.statusCode == 404) {
      return null;
    }

    if (hasResponseErrors(response)) {
      throw Exception(response);
    }

    return UserResponse.fromJson(response.data);
  }

  Future<Response> storeUserData({
    required String name,
    required String lastname,
    io.File? avatar,
  }) async {
    if (_multipartClient == null) {
      throw Exception('Multipart client is null');
    }

    final response = await _multipartClient!.post(
      '/api/user',
      body: {
        'name': name,
        'lastname': lastname,
      },
      files: avatar != null
          ? [
              http.MultipartFile.fromBytes(
                'image',
                (await avatar.readAsBytes()).toList(),
                contentType: MediaType.parse(
                    lookupMimeType(avatar.path) ?? 'image/jpeg'),
                filename: 'avatar.jpeg',
              )
            ]
          : null,
    );

    if (hasResponseErrors(response)) {
      throw Exception(response);
    }

    return response;
  }

  void close() {
    _client.close();
  }
}

/// Represents a response with the user data.
class UserResponse extends User {
  const UserResponse({
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

    final profileImage = user['profileImage'] != null
        ? File(
            id: user['profileImage']['id'],
            key: user['profileImage']['key'],
            type: user['profileImage']['type'],
            bucket: user['profileImage']['bucket'],
            mimeType: user['profileImage']['mimeTYpe'],
            fileableType: user['profileImage']['fileableType'],
            fileableId: user['profileImage']['fileableId'])
        : null;

    return UserResponse(
      id: user['id'],
      name: user['name'],
      lastname: user['lastname'],
      profileImage: profileImage,
    );
  }
}
