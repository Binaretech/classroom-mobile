part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class LoggedUserState extends UserState {
  final String id;
  final String name;
  final String lastname;

  const LoggedUserState(
      {required this.id, required this.name, required this.lastname});

  @override
  List<Object> get props => [id, name, lastname];
}

class UnLoggedUserState extends UserState {
  const UnLoggedUserState();

  @override
  List<Object> get props => [];
}
