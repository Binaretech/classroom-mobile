part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class LoggedUserState extends UserState {
  final User user;

  const LoggedUserState({required this.user});

  @override
  List<Object> get props => [user];
}

class UnLoggedUserState extends UserState {
  const UnLoggedUserState();

  @override
  List<Object> get props => [];
}
