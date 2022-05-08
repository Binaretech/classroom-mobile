import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:classroom_mobile/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({User? user}) : super(initialState(user)) {
    on<SetUserEvent>(
      (event, emit) {
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString('user', json.encode(event.user.toMap()));
        });

        return emit(LoggedUserState(user: event.user));
      },
    );

    on<RemoveUserEvent>(
      (event, emit) {
        SharedPreferences.getInstance().then((prefs) {
          prefs.remove('user');
        });

        return emit(const UnLoggedUserState());
      },
    );
  }
}

UserState initialState(User? user) {
  if (user == null) return const UnLoggedUserState();

  return LoggedUserState(user: user);
}
