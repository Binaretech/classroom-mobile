import 'package:classroom_mobile/http/request.dart';
import 'package:classroom_mobile/repository/repository.dart';

class ClassRepository extends Repository {
  final Request _client;

  ClassRepository({Request? client}) : _client = client ?? Request();

  Future<Response> getSections() async {
    final response = await _client.get('/api/sections');

    if (hasResponseErrors(response)) {
      throw Exception(response);
    }

    return response;
  }
}
