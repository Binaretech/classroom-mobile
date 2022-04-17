import 'dart:io';

import 'package:classroom_mobile/http/request.dart';
import 'package:classroom_mobile/repository/auth_repository.dart';
import 'package:classroom_mobile/repository/repository.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

Future<UserResponse?> getUser() async {
  final response = await Request.get('/api/user');

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
  File? avatar,
}) async {
  final response = await Request.multipartPost(
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
              contentType:
                  MediaType.parse(lookupMimeType(avatar.path) ?? 'image/jpeg'),
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
