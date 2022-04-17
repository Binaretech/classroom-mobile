import 'package:classroom_mobile/bloc/authentication/authentication_bloc.dart';
import 'package:classroom_mobile/bloc/user/user_bloc.dart';
import 'package:classroom_mobile/bloc/configuration/configuration_bloc.dart';
import 'package:classroom_mobile/globals.dart';
import 'package:classroom_mobile/modules/auth/login.dart';
import 'package:classroom_mobile/modules/auth/register.dart';
import 'package:classroom_mobile/modules/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  final String? token;
  final String? userData;

  const App({
    Key? key,
    this.token,
    this.userData,
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
      ),
      darkTheme: ThemeData.dark(),
      themeMode: config.themeMode,
      initialRoute: auth.isAutheticated ? '/' : '/login',
      routes: {
        '/': (_) => const Home(),
        '/login': (_) => const Login(),
        '/register': (_) => const Register(),
      },
    );
  }

  List<BlocProvider> _blocProviders() {
    return [
      BlocProvider<AuthenticationBloc>(
        create: (_) => AuthenticationBloc(token: token),
      ),
      BlocProvider<ConfigurationBloc>(
        create: (_) => ConfigurationBloc(),
      ),
      BlocProvider<UserBloc>(
        create: (_) => UserBloc(userData: userData),
      ),
    ];
  }

  Widget _blocBuilders({
    required BuildContext context,
    required Widget Function(
      BuildContext,
      ConfigurationState,
      AuthenticationState,
    )
        builder,
  }) {
    return BlocBuilder<ConfigurationBloc, ConfigurationState>(
      bloc: BlocProvider.of<ConfigurationBloc>(context),
      builder: (BuildContext context, ConfigurationState config) {
        return BlocBuilder<AuthenticationBloc, AuthenticationState>(
          bloc: BlocProvider.of<AuthenticationBloc>(context),
          builder: (BuildContext context, AuthenticationState auth) {
            return builder(context, config, auth);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _blocProviders(),
      child: Builder(
        builder: (context) => _blocBuilders(
          context: context,
          builder: _buildApp,
        ),
      ),
    );
  }
}
