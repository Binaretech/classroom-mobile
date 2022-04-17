import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:classroom_mobile/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({String? userData}) : super(loadInitialState(userData)) {
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

UserState loadInitialState(String? userData) {
  if (userData == null) {
    return const UnLoggedUserState();
  }

  final user = json.decode(userData) as Map<String, dynamic>;

  return LoggedUserState(user: User.fromMap(user));
}
