import 'package:classroom_mobile/bloc/authentication/authentication_bloc.dart';
import 'package:classroom_mobile/bloc/configuration/configuration_bloc.dart';
import 'package:classroom_mobile/globals.dart';
import 'package:classroom_mobile/models/user.dart';
import 'package:classroom_mobile/modules/auth/login.dart';
import 'package:classroom_mobile/modules/home/home.dart';
import 'package:classroom_mobile/routes.dart';
import 'package:classroom_mobile/widgets/app_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  final String? token;
  final User? user;

  const App({
    Key? key,
    this.token,
    this.user,
  }) : super(key: key);

  Widget _buildApp(BuildContext context, ConfigurationState config,
      AuthenticationState auth) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
      locale: config.locale,
      title: 'Classroom',
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: snackbarKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      darkTheme: ThemeData.dark(),
      themeMode: config.themeMode,
      initialRoute: auth.isAutheticated ? Home.route : Login.route,
      routes: routes,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBlocBuilder(
      builder: _buildApp,
      token: token,
    );
  }
}
