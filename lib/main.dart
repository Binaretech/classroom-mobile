import 'package:classroom_mobile/bloc/authentication/authentication_bloc.dart';
import 'package:classroom_mobile/globals.dart';
import 'package:classroom_mobile/l10n/localization.dart';
import 'package:classroom_mobile/router/app_route_information_delegate.dart';
import 'package:classroom_mobile/router/app_router_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const Classroom());
}

class Classroom extends StatelessWidget {
  const Classroom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthenticationBloc(),
      child: MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('es'),
        title: 'Classroom',
        scaffoldMessengerKey: snackbarKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerDelegate: AppRouterDelegate(),
        routeInformationParser: AppRouteInformationRouter(),
      ),
    );
  }
}
