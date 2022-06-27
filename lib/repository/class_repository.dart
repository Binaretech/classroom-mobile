import 'package:classroom_mobile/http/request.dart';
import 'package:classroom_mobile/models/paginated_data.dart';
import 'package:classroom_mobile/repository/repository.dart';
import 'package:classroom_mobile/repository/resources/section.dart';
import 'package:classroom_mobile/repository/resources/section_member.dart';

class ClassRepository extends Repository {
  final Request _client;

  ClassRepository({Request? client}) : _client = client ?? Request();

  Future<PaginatedData<SectionResource>> getSections({int page = 1}) async {
    final response = await _client.get('/api/sections', queryParameters: {
      'page': page.toString(),
    });

    if (hasResponseErrors(response)) {
      throw Exception(response);
    }

    return PaginatedData.fromJson(response.data, SectionResource.fromList);
  }

  Future<PaginatedData<SectionMember>> getMembers(int id,
      [int page = 1]) async {
    final response =
        await _client.get('/api/sections/$id/members', queryParameters: {
      'page': page.toString(),
    });

    if (hasResponseErrors(response)) {
      throw Exception(response);
    }

    return PaginatedData.fromJson(response.data, SectionMember.fromList);
  }
}
