import 'package:classroom_mobile/bloc/authentication/authentication_bloc.dart';
import 'package:classroom_mobile/globals.dart';
import 'package:classroom_mobile/http/request.dart';
import 'package:classroom_mobile/repository/auth_repository.dart';
import 'package:classroom_mobile/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<UserResponse> getUser() async {
  final response = await Request.get('/api/user');

  if (hasResponseErrors(response)) {
    throw Exception(response);
  }

  return UserResponse.fromJson(response.data);
}
