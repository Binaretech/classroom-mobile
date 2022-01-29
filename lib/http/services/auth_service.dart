import 'package:classroom_mobile/http/request.dart';

Future<Response> login(String email, String password) async {
  final response = await Request.post('/auth/login', body: {
    'email': email,
    'password': password,
  });

  return response;
}
