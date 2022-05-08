import 'dart:convert';

import 'package:classroom_mobile/bloc/authentication/authentication_bloc.dart';
import 'package:classroom_mobile/http/request.dart';
import 'package:classroom_mobile/modules/auth/login.dart';
import 'package:classroom_mobile/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../app_wrapper.dart';
import '../mocks/request.mocks.dart';

void main() {
  setUp(() async {
    await dotenv.load();
  });

  testWidgets('Test login screen', (WidgetTester tester) async {
    final client = MockRequest();

    final loginData = {'email': 'test@mail.com', 'password': 'test'};

    final response = {
      'token': {
        'access_token': 'test_token',
      }
    };

    when(client.post(
      '/auth/login',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(loginData),
      encoding: null,
    )).thenAnswer((_) async {
      return Response(200, response);
    });

    await tester.pumpWidget(
      AppWrapper(
        child: BlocProvider(
          create: (_) => AuthenticationBloc(),
          child: Login(
            repository: AuthRepository(client: client),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField).first, 'test@mail.com');
    await tester.enterText(find.byType(TextFormField).last, 'test');

    await tester.tap(find.byType(ElevatedButton));
  });
}
