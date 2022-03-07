import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({String? userData}) : super(loadInitialState(userData)) {
    on<SetUserEvent>(
      (event, emit) {
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString(
              'user',
              json.encode({
                'id': event.id,
                'name': event.name,
                'lastname': event.lastname,
              }));
        });

        return emit(LoggedUserState(
          id: event.id,
          name: event.name,
          lastname: event.lastname,
        ));
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

  final user = json.decode(userData);

  return LoggedUserState(
    id: user['id'],
    name: user['name'],
    lastname: user['lastname'],
  );
}
