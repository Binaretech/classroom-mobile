import 'package:classroom_mobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:classroom_mobile/bloc/authentication/authentication_bloc.dart';
import 'package:classroom_mobile/bloc/configuration/configuration_bloc.dart';
import 'package:classroom_mobile/bloc/user/user_bloc.dart';

class AppBlocBuilder extends StatelessWidget {
  final String? token;
  final User? user;
  final Widget Function(BuildContext, ConfigurationState, AuthenticationState)
      builder;

  const AppBlocBuilder({
    Key? key,
    this.token,
    this.user,
    required this.builder,
  }) : super(key: key);

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

  List<BlocProvider> _blocProviders() {
    return [
      BlocProvider<AuthenticationBloc>(
        create: (_) => AuthenticationBloc(token: token),
      ),
      BlocProvider<ConfigurationBloc>(create: (_) => ConfigurationBloc()),
      BlocProvider<UserBloc>(
        create: (_) => UserBloc(user: user),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _blocProviders(),
      child: Builder(
        builder: (context) => _blocBuilders(
          context: context,
          builder: builder,
        ),
      ),
    );
  }
}
