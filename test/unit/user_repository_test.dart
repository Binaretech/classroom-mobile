import 'package:classroom_mobile/http/request.dart';
import 'package:classroom_mobile/models/user.dart';
import 'package:classroom_mobile/repository/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/request.mocks.dart';

void main() {
  final client = MockRequest();

  group('Test user repository', () {
    test('Test get user', () async {
      const user =
          User(id: '1231asd-1231-s1231', name: 'John', lastname: 'Doe');

      when(client.get('/api/user'))
          .thenAnswer((_) async => Response(200, ({'user': user.toMap()})));

      final repository = UserRepository(client: client);

      final result = await repository.getUser();

      expect(result!.name, user.name);
    });
  });
}
