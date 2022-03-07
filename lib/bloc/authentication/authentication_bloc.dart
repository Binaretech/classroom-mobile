import 'package:classroom_mobile/globals.dart';
import 'package:classroom_mobile/http/request.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:classroom_mobile/bloc/user/user_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({String? token})
      : super(AuthenticationState(token: token ?? '')) {
    if (token?.isNotEmpty ?? false) {
      Request.setToken(token);
    }

    on<AuthenticationStatusChanged>(
      (event, emit) {
        Request.setToken(event.token);

        final userBloc =
            BlocProvider.of<UserBloc>(navigatorKey.currentContext!);

        SharedPreferences.getInstance().then((prefs) {
          prefs.setString('token', event.token);
        });

        userBloc.add(const RemoveUserEvent());

        return emit(AuthenticationState(token: event.token));
      },
    );
  }
}
