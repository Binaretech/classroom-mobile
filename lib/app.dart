import 'package:classroom_mobile/bloc/authentication/authentication_bloc.dart';
import 'package:classroom_mobile/globals.dart';
import 'package:classroom_mobile/l10n/localization.dart';
import 'package:classroom_mobile/modules/auth/RegisterUserInfo.dart';
import 'package:classroom_mobile/modules/auth/login.dart';
import 'package:classroom_mobile/modules/auth/register.dart';
import 'package:classroom_mobile/modules/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthenticationBloc(),
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('es'),
        title: 'Classroom',
        scaffoldMessengerKey: snackbarKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        initialRoute: '/register/user',
        routes: {
          '/': (BuildContext context) => const Home(),
          '/login': (BuildContext context) => const Login(),
          '/register': (BuildContext context) => const Register(),
          '/register/user': (BuildContext context) => const RegisterUserInfo(),
        },
      ),
    );
  }
}
